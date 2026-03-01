import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../providers/player_provider.dart';
import '../../../providers/lyrics_cover_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/audio_quality_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../data/models/lyrics.dart';
import '../../../data/models/audio_quality.dart';
import '../../../data/models/embed_service_config.dart';
import '../../../data/models/song.dart';
import '../../../core/network/connectivity_monitor.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/player_hero_helpers.dart';
import '../widgets/play_queue_sheet.dart';
import '../widgets/song_options_sheet.dart';
import '../widgets/synced_lyrics_view.dart';

/// 全屏播放器
class FullPlayerPage extends ConsumerStatefulWidget {
  const FullPlayerPage({super.key});

  @override
  ConsumerState<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends ConsumerState<FullPlayerPage>
    with TickerProviderStateMixin {
  bool _showLyrics = false;
  bool _isClosingRoute = false;
  PaletteGenerator? _paletteGenerator;
  late AnimationController _controller;
  late AnimationController _lyricsController;
  late Animation<double> _topBarAnimation;
  late Animation<double> _controlsAnimation;
  late Animation<double> _bottomBarAnimation;
  late Animation<double> _lyricsProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _lyricsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
      value: _showLyrics ? 1 : 0,
    );

    _topBarAnimation = CurvedAnimation(
      parent: _controller,
      // Delay top bar until background has likely covered the top area
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _controlsAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    );

    _bottomBarAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );
    _lyricsProgress = CurvedAnimation(
      parent: _lyricsController,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final song = ref.read(playerProvider).currentSong;
      if (song != null) {
        _updatePalette(song);
      }
    });
  }

  @override
  void dispose() {
    _lyricsController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updatePalette(Song? song) async {
    if (song == null) {
      if (mounted) setState(() => _paletteGenerator = null);
      return;
    }

    try {
      ImageProvider imageProvider;
      final previewCover = song.previewCoverUrl?.trim();
      if (song.isPreview && previewCover != null && previewCover.isNotEmpty) {
        imageProvider = CachedNetworkImageProvider(previewCover);
      } else {
        final coverArtId = song.coverArt;
        if (coverArtId == null || coverArtId.isEmpty) {
          if (mounted) setState(() => _paletteGenerator = null);
          return;
        }
        final url = ref
            .read(subsonicApiClientProvider)
            .getCoverArtUrl(coverArtId, size: 300);
        imageProvider = CachedNetworkImageProvider(url);
      }
      final generator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 20,
      );

      if (mounted) {
        setState(() => _paletteGenerator = generator);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Color _limitBackgroundLuminance(Color color, {double maxLuminance = 0.3}) {
    final luminance = color.computeLuminance();
    if (luminance <= maxLuminance) return color;

    final blendFactor = ((luminance - maxLuminance) / (1 - maxLuminance)).clamp(
      0.0,
      0.82,
    );
    return Color.lerp(color, Colors.black, blendFactor) ?? color;
  }

  String _buildSubtitle({
    required String? artistName,
    required String? albumName,
    bool includeAlbum = true,
  }) {
    final artist = artistName?.trim() ?? '';
    final album = albumName?.trim() ?? '';

    if (!includeAlbum) {
      return artist;
    }
    if (artist.isNotEmpty && album.isNotEmpty) {
      return '$artist · $album';
    }
    if (artist.isNotEmpty) return artist;
    if (album.isNotEmpty) return album;
    return '';
  }

  Future<void> _closeToMini() async {
    if (_isClosingRoute || !mounted) return;
    _isClosingRoute = true;

    if (!_showLyrics) {
      Navigator.of(context).pop();
      return;
    }

    await _lyricsController.animateBack(
      0.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOutCubic,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Widget _buildSongCover(Song song, double size) {
    final previewCover = song.previewCoverUrl?.trim();
    if (song.isPreview && previewCover != null && previewCover.isNotEmpty) {
      return Image.network(
        previewCover,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          alignment: Alignment.center,
          child: const Icon(Icons.music_note, size: 64),
        ),
      );
    }

    return CoverArtImage(
      coverArtId: song.coverArt,
      size: size,
      requestSize: 640,
      fit: BoxFit.contain,
    );
  }

  Future<void> _enqueuePreviewSong(Song song, {bool force = false}) async {
    final activeLibrary = ref.read(activeLibraryProvider);
    if (activeLibrary == null) {
      _showSnackBar('当前没有活跃音乐库');
      return;
    }

    final config = EmbedServiceConfig.fromLibraryExtensions(
      activeLibrary.extensions,
    );
    try {
      await ref
          .read(offlineDownloadServiceProvider)
          .enqueuePreviewSong(
            song: song,
            libraryId: activeLibrary.id,
            config: config,
            force: force,
          );
      _showSnackBar(force ? '已重新添加到离线下载队列' : '已添加到离线下载队列');
    } catch (e) {
      if (e.toString().contains('已在离线队列中') && !force) {
        _showForceRedownloadDialog(song);
      } else {
        _showSnackBar('添加失败: $e');
      }
    }
  }

  void _showForceRedownloadDialog(Song song) {
    if (!mounted) return;
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('歌曲已存在'),
        content: Text('「${song.title}」已在离线队列中，是否重新下载？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('重新下载'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        _enqueuePreviewSong(song, force: true);
      }
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final currentSong = playerState.currentSong;
    final lyricsAsync = ref.watch(currentLyricsProvider);

    // 监听歌曲变化更新背景色
    ref.listen(playerProvider.select((s) => s.currentSong), (previous, next) {
      if (next?.id != previous?.id ||
          next?.coverArt != previous?.coverArt ||
          next?.previewCoverUrl != previous?.previewCoverUrl) {
        _updatePalette(next);
      }
    });

    if (currentSong == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('正在播放')),
        body: const Center(child: Text('暂无播放内容')),
      );
    }

    // 构建背景渐变
    // 调色板未加载时，使用与迷你播放器相同的 surfaceContainer 颜色，
    // 避免 Hero 飞行期间出现颜色跳变（黑色闪烁）。
    // 调色板加载后，AnimatedContainer 会平滑过渡到主题渐变色。
    final miniPlayerBgColor = Theme.of(context).colorScheme.surfaceContainer;
    final Color backgroundColor;
    final Color scaffoldBackgroundColor;

    if (_paletteGenerator?.dominantColor?.color != null) {
      backgroundColor = _limitBackgroundLuminance(
        _paletteGenerator!.dominantColor!.color,
        maxLuminance: 0.32,
      );
      scaffoldBackgroundColor = _limitBackgroundLuminance(
        Theme.of(context).scaffoldBackgroundColor,
        maxLuminance: 0.2,
      );
    } else {
      backgroundColor = miniPlayerBgColor;
      scaffoldBackgroundColor = miniPlayerBgColor;
    }
    const primaryTextColor = Colors.white;
    final secondaryTextColor = Colors.white.withValues(alpha: 0.78);
    const lyricsActivePrimaryColor = Colors.white;
    const lyricsActiveSecondaryColor = Colors.white;
    final lyricsInactivePrimaryColor = Colors.white.withValues(alpha: 0.64);
    final lyricsInactiveSecondaryColor = Colors.white.withValues(alpha: 0.5);
    final artistName = currentSong.artist?.trim();
    final albumName = currentSong.album?.trim();
    final subtitle = _buildSubtitle(
      artistName: artistName,
      albumName: albumName,
      includeAlbum: true,
    );
    final hasSubtitle = subtitle.isNotEmpty;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: PopScope<void>(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          await _closeToMini();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // 背景 Hero
              Positioned.fill(
                child: Hero(
                  tag: 'player-background',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          backgroundColor.withValues(alpha: 0.85),
                          scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // 内容
              SafeArea(
                child: FadeTransition(
                  opacity: ModalRoute.of(context)!.animation!,
                  child: Column(
                    children: [
                      // 顶部操作栏
                      FadeTransition(
                        opacity: _topBarAnimation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: IconTheme(
                            data: Theme.of(
                              context,
                            ).iconTheme.copyWith(color: primaryTextColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  onPressed: _closeToMini,
                                ),
                                Text(
                                  '正在播放',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(color: primaryTextColor),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {
                                    if (currentSong.isPreview) {
                                      showSongOptionsSheet(
                                        context: context,
                                        song: currentSong,
                                        mode: SongOptionsSheetMode.offlineOnly,
                                        extraActions: [
                                          SongOptionsExtraAction(
                                            icon: Icons.download_outlined,
                                            title: '添加到离线下载队列',
                                            onPressed: () async {
                                              await _enqueuePreviewSong(
                                                currentSong,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    } else {
                                      showSongOptionsSheet(
                                        context: context,
                                        song: currentSong,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 中间内容区域
                      Expanded(
                        child: _buildMiddleContent(
                          currentSong: currentSong,
                          lyricsAsync: lyricsAsync,
                          hasSubtitle: hasSubtitle,
                          subtitle: subtitle,
                          primaryTextColor: primaryTextColor,
                          secondaryTextColor: secondaryTextColor,
                          lyricsActivePrimaryColor: lyricsActivePrimaryColor,
                          lyricsActiveSecondaryColor:
                              lyricsActiveSecondaryColor,
                          lyricsInactivePrimaryColor:
                              lyricsInactivePrimaryColor,
                          lyricsInactiveSecondaryColor:
                              lyricsInactiveSecondaryColor,
                        ),
                      ),

                      // 底部固定控制栏
                      FadeTransition(
                        opacity: _controlsAnimation,
                        child: SlideTransition(
                          position: _controlsAnimation.drive(
                            Tween<Offset>(
                              begin: const Offset(0, 0.2),
                              end: Offset.zero,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 进度条
                                const ProgressBar(),

                                const SizedBox(height: 24),

                                // 播放控制按钮
                                PlaybackControls(currentSong: currentSong),

                                const SizedBox(height: 8),

                                // 底部操作按钮
                                FadeTransition(
                                  opacity: _bottomBarAnimation,
                                  child: SizedBox(
                                    width: 160,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 歌词按钮
                                        IconButton(
                                          icon: Icon(
                                            Icons.lyrics,
                                            color: _showLyrics
                                                ? Colors.white
                                                : Colors.white.withValues(
                                                    alpha: 0.72,
                                                  ),
                                          ),
                                          onPressed: () {
                                            final nextShowLyrics = !_showLyrics;
                                            setState(() {
                                              _showLyrics = nextShowLyrics;
                                            });
                                            if (nextShowLyrics) {
                                              _lyricsController.forward();
                                            } else {
                                              _lyricsController.reverse();
                                            }
                                          },
                                        ),

                                        // 播放队列按钮
                                        IconButton(
                                          icon: Icon(
                                            Icons.queue_music,
                                            color: Colors.white.withValues(
                                              alpha: 0.78,
                                            ),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  const PlayQueueSheet(),
                                              isScrollControlled: true,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // 音质指示
                                const SizedBox(height: 4),
                                _buildQualityIndicator(ref),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleContent({
    required Song currentSong,
    required AsyncValue<Lyrics?> lyricsAsync,
    required bool hasSubtitle,
    required String subtitle,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required Color lyricsActivePrimaryColor,
    required Color lyricsActiveSecondaryColor,
    required Color lyricsInactivePrimaryColor,
    required Color lyricsInactiveSecondaryColor,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPadding = 24.0;
        final maxCoverByWidth = (constraints.maxWidth - horizontalPadding * 2)
            .clamp(0.0, 320.0);
        final maxCoverByHeight = (constraints.maxHeight * 0.62).clamp(
          0.0,
          360.0,
        );
        final baseCoverSize = maxCoverByWidth < maxCoverByHeight
            ? maxCoverByWidth
            : maxCoverByHeight;
        final bTopSpace = (constraints.maxHeight - baseCoverSize - 140).clamp(
          18.0,
          96.0,
        );
        const cTopSpace = 8.0;
        const bCoverGap = 24.0;
        const cCoverGap = 8.0;

        final titleStyleFrom =
            Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ) ??
            TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            );
        final titleStyleTo =
            Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ) ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            );
        final subtitleStyleFrom =
            Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: secondaryTextColor) ??
            TextStyle(fontSize: 16, color: secondaryTextColor);
        final subtitleStyleTo =
            Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: secondaryTextColor) ??
            TextStyle(fontSize: 12, color: secondaryTextColor);

        return AnimatedBuilder(
          animation: _lyricsProgress,
          builder: (context, _) {
            final t = _lyricsProgress.value;
            final topSpace = bTopSpace + (cTopSpace - bTopSpace) * t;
            final coverSize = baseCoverSize * (1 - t);
            final coverGap = bCoverGap + (cCoverGap - bCoverGap) * t;
            final titleStyle =
                TextStyle.lerp(titleStyleFrom, titleStyleTo, t) ?? titleStyleTo;
            final subtitleStyle =
                TextStyle.lerp(subtitleStyleFrom, subtitleStyleTo, t) ??
                subtitleStyleTo;
            final shouldBuildLyrics = _showLyrics || t > 0.001;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: topSpace),
                      if (coverSize > 0.1)
                        Opacity(
                          opacity: 1 - t,
                          child: Hero(
                            tag: 'player-cover',
                            createRectTween: playerLinearRectTween,
                            child: Container(
                              width: coverSize,
                              height: coverSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: _buildSongCover(currentSong, coverSize),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: coverGap),
                      Hero(
                        tag: 'player-title',
                        createRectTween: playerLinearRectTween,
                        flightShuttleBuilder: playerTextFlightShuttleBuilder,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            currentSong.title,
                            style: titleStyle,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (hasSubtitle) ...[
                        const SizedBox(height: 4),
                        Hero(
                          tag: 'player-subtitle',
                          createRectTween: playerLinearRectTween,
                          flightShuttleBuilder: playerTextFlightShuttleBuilder,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              subtitle,
                              style: subtitleStyle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Expanded(
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: t,
                            child: shouldBuildLyrics
                                ? _buildLyricsView(
                                    lyricsAsync,
                                    activePrimaryColor:
                                        lyricsActivePrimaryColor,
                                    activeSecondaryColor:
                                        lyricsActiveSecondaryColor,
                                    inactivePrimaryColor:
                                        lyricsInactivePrimaryColor,
                                    inactiveSecondaryColor:
                                        lyricsInactiveSecondaryColor,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildQualityIndicator(WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final song = playerState.currentSong;
    final rawBitRate = playerState.currentBitRateKbps > 0
        ? playerState.currentBitRateKbps
        : ((song?.bitRate ?? 0) >= 10000
              ? ((song?.bitRate ?? 0) ~/ 1000)
              : (song?.bitRate ?? 0));
    final bitRateText = rawBitRate > 0 ? '${rawBitRate}Kbps' : '未知码率';

    if (song?.isPreview == true) {
      final qualityLabel = song?.previewQualityLabel?.trim();
      final text =
          '试听·${qualityLabel == null || qualityLabel.isEmpty ? '未知音质' : qualityLabel}·$bitRateText';
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.headphones,
            size: 12,
            color: Colors.white.withValues(alpha: 0.76),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.76),
            ),
          ),
        ],
      );
    }

    final AudioQualityLevel quality =
        playerState.currentQuality ?? ref.watch(effectiveQualityProvider);
    final source = playerState.playbackSource ?? PlaybackSource.stream;
    final networkType = ref.watch(currentNetworkTypeProvider).valueOrNull;
    final qualityLabel = switch (quality) {
      AudioQualityLevel.original => '原始无损',
      AudioQualityLevel.high => '高品质',
      AudioQualityLevel.standard => '标准',
      AudioQualityLevel.dataSaver => '流量节省',
    };

    String text;
    IconData icon;
    Color? color;

    switch (source) {
      case PlaybackSource.downloaded:
        text = '本地已下载·$qualityLabel·$bitRateText';
        icon = Icons.offline_pin;
        color = Colors.green;
        break;
      case PlaybackSource.cached:
        text = '本地缓存·$qualityLabel·$bitRateText';
        icon = Icons.check_circle_outline;
        color = Colors.blue;
        break;
      case PlaybackSource.stream:
        final netName = switch (networkType) {
          NetworkType.wifi => 'Wi-Fi',
          NetworkType.mobile => '移动数据',
          NetworkType.none => '无网络',
          null => '未知网络',
        };
        text = '$netName·$qualityLabel·$bitRateText';
        icon = networkType == NetworkType.none
            ? Icons.offline_pin
            : Icons.cloud_queue;
        color = networkType == NetworkType.none ? Colors.orange : null;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 12,
          color: color ?? Colors.white.withValues(alpha: 0.76),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10,
            color: color ?? Colors.white.withValues(alpha: 0.76),
          ),
        ),
      ],
    );
  }

  Widget _buildLyricsView(
    AsyncValue<Lyrics?> lyricsAsync, {
    required Color activePrimaryColor,
    required Color activeSecondaryColor,
    required Color inactivePrimaryColor,
    required Color inactiveSecondaryColor,
  }) {
    return lyricsAsync.when(
      data: (lyrics) {
        if (lyrics == null || lyrics.isEmpty) {
          return Center(
            child: Text('暂无歌词', style: TextStyle(color: activePrimaryColor)),
          );
        }
        final bestLyrics = lyrics.getBest();
        if (bestLyrics == null) {
          return Center(
            child: Text('暂无歌词', style: TextStyle(color: activePrimaryColor)),
          );
        }
        return SyncedLyricsView(
          lyrics: bestLyrics,
          activePrimaryColor: activePrimaryColor,
          activeSecondaryColor: activeSecondaryColor,
          inactivePrimaryColor: inactivePrimaryColor,
          inactiveSecondaryColor: inactiveSecondaryColor,
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (err, stack) => Center(
        child: Text('加载歌词失败', style: TextStyle(color: activePrimaryColor)),
      ),
    );
  }
}

/// 进度条组件
class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({super.key});

  @override
  ConsumerState<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends ConsumerState<ProgressBar>
    with SingleTickerProviderStateMixin {
  double? _dragValue;
  late final AnimationController _loadingOpacityController;
  late final Animation<double> _loadingOpacity;
  bool _isLoadingPulseActive = false;

  @override
  void initState() {
    super.initState();
    _loadingOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _loadingOpacity = Tween<double>(begin: 0.95, end: 0.42).animate(
      CurvedAnimation(
        parent: _loadingOpacityController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _loadingOpacityController.dispose();
    super.dispose();
  }

  void _syncLoadingPulse(bool shouldPulse) {
    if (shouldPulse == _isLoadingPulseActive) return;
    _isLoadingPulseActive = shouldPulse;
    if (shouldPulse) {
      _loadingOpacityController.repeat(reverse: true);
    } else {
      _loadingOpacityController.stop();
      _loadingOpacityController.value = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final position = playerState.position;
    final duration = playerState.duration;
    final buffered = playerState.bufferedPosition;
    final isLoading =
        playerState.processingState == ProcessingState.loading ||
        playerState.processingState == ProcessingState.buffering;
    _syncLoadingPulse(isLoading);

    // 确保 value 在有效范围内 (0 到 max)
    final maxMilliseconds = duration.inMilliseconds > 0
        ? duration.inMilliseconds.toDouble()
        : 1.0;
    final currentMilliseconds = position.inMilliseconds.toDouble();
    final bufferedMilliseconds = buffered.inMilliseconds.toDouble();

    // 如果正在拖动，使用拖动值，否则使用当前播放进度
    // 限制在 0 到 max 之间
    final sliderValue = (_dragValue ?? currentMilliseconds).clamp(
      0.0,
      maxMilliseconds,
    );
    final bufferedFraction = (bufferedMilliseconds / maxMilliseconds).clamp(
      0.0,
      1.0,
    );
    final displayPosition = _dragValue != null
        ? Duration(milliseconds: _dragValue!.toInt())
        : position;
    final timeTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Colors.white.withValues(alpha: 0.78),
    );

    return Column(
      children: [
        AnimatedBuilder(
          animation: _loadingOpacity,
          builder: (context, child) {
            final opacity = isLoading ? _loadingOpacity.value : 1.0;
            return Opacity(opacity: opacity, child: child);
          },
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              trackShape: _BufferedTrackShape(
                bufferedFraction: bufferedFraction,
              ),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: sliderValue,
              max: maxMilliseconds,
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
              },
              onChangeEnd: (value) {
                ref
                    .read(playerProvider.notifier)
                    .seek(Duration(milliseconds: value.toInt()));
                setState(() {
                  _dragValue = null;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(displayPosition), style: timeTextStyle),
              Text(_formatDuration(duration), style: timeTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    // 处理负数情况（虽然进度条一般不会由负数，但 robust 一点）
    if (duration.isNegative) return "0:00";
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }
}

/// 自定义 Slider 轨道形状：inactive → buffer → active 三层绘制
class _BufferedTrackShape extends SliderTrackShape {
  final double bufferedFraction;

  const _BufferedTrackShape({required this.bufferedFraction});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 3;
    final trackLeft = offset.dx + 14; // thumb radius
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 28;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    final canvas = context.canvas;
    final trackHeight = sliderTheme.trackHeight ?? 3;
    final radius = Radius.circular(trackHeight / 2);

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // 1) 底层：inactive 轨道（暗色，全宽）
    final inactiveRect = RRect.fromRectAndRadius(trackRect, radius);
    final inactivePaint = Paint()..color = Colors.white.withValues(alpha: 0.15);
    canvas.drawRRect(inactiveRect, inactivePaint);

    // 2) 中层：buffer 缓冲进度（半透明白色）
    if (bufferedFraction > 0) {
      final bufferedWidth = trackRect.width * bufferedFraction;
      final bufferedRRect = RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        trackRect.left + bufferedWidth,
        trackRect.bottom,
        radius,
      );
      final bufferedPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.38);
      canvas.drawRRect(bufferedRRect, bufferedPaint);
    }

    // 3) 顶层：active 轨道（已播放部分，主题色）
    final activeRight = thumbCenter.dx;
    if (activeRight > trackRect.left) {
      final activeRRect = RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        activeRight,
        trackRect.bottom,
        radius,
      );
      final activeColor = sliderTheme.activeTrackColor ?? Colors.white;
      final activePaint = Paint()..color = activeColor;
      canvas.drawRRect(activeRRect, activePaint);
    }
  }
}

/// 播放控制按钮
class PlaybackControls extends ConsumerWidget {
  final Song currentSong;

  const PlaybackControls({super.key, required this.currentSong});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final inactiveControlColor = Colors.white.withValues(alpha: 0.78);
    final playbackMode = playerState.shuffleEnabled
        ? PlaybackMode.shuffle
        : (playerState.loopMode == LoopMode.one
              ? PlaybackMode.repeatOne
              : PlaybackMode.repeatAll);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 播放模式按钮（三态）
        IconButton(
          icon: Icon(_getPlaybackModeIcon(playbackMode), color: Colors.white),
          onPressed: () {
            ref.read(playerProvider.notifier).cyclePlaybackMode();
          },
        ),

        const SizedBox(width: 12),

        // 上一首按钮
        IconButton(
          iconSize: 36,
          icon: Icon(Icons.skip_previous, color: inactiveControlColor),
          onPressed: playerState.hasPrevious
              ? () {
                  ref.read(playerProvider.notifier).previous();
                }
              : null,
        ),

        const SizedBox(width: 12),

        // 播放/暂停按钮（大）
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            iconSize: 48,
            icon: Icon(
              playerState.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              ref.read(playerProvider.notifier).togglePlayPause();
            },
          ),
        ),

        const SizedBox(width: 12),

        // 下一首按钮
        IconButton(
          iconSize: 36,
          icon: Icon(Icons.skip_next, color: inactiveControlColor),
          onPressed: playerState.hasNext
              ? () {
                  ref.read(playerProvider.notifier).next();
                }
              : null,
        ),

        const SizedBox(width: 12),

        // 收藏按钮
        IconButton(
          icon: Icon(
            currentSong.starred ? Icons.favorite : Icons.favorite_border,
            color: currentSong.starred ? Colors.red : inactiveControlColor,
          ),
          onPressed: () {
            ref.read(playerProvider.notifier).toggleFavorite();
          },
        ),
      ],
    );
  }

  IconData _getPlaybackModeIcon(PlaybackMode mode) {
    return switch (mode) {
      PlaybackMode.shuffle => Icons.shuffle,
      PlaybackMode.repeatAll => Icons.repeat,
      PlaybackMode.repeatOne => Icons.repeat_one,
    };
  }
}
