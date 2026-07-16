import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/playback_stats_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../widgets/echo_settings_components.dart';

class PlaybackStatsPage extends ConsumerWidget {
  const PlaybackStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(playbackStatsProvider);
    final hasRemoteLoadFailed =
        ref.watch(allSongsLoadFailedProvider) ||
        ref.watch(allAlbumsLoadFailedProvider) ||
        ref.watch(allArtistsLoadFailedProvider) ||
        ref.watch(starredLoadFailedProvider) ||
        ref.watch(recentAlbumsLoadFailedProvider) ||
        ref.watch(frequentAlbumsLoadFailedProvider);

    return VisibleRemoteRetryScope(
      debugLabel: 'playback_stats_page',
      shouldRetry: (ref) => hasRemoteLoadFailed || statsAsync.hasError,
      onRetry: _invalidateStats,
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '统计信息',
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.refresh,
              label: '刷新统计',
              onPressed: () => _refreshStats(ref),
            ),
          ],
        ),
        body: statsAsync.when(
          loading: () => const _StatsLoadingView(),
          error: (error, stackTrace) => EchoErrorState(
            title: '统计加载失败',
            description: '无法汇总曲库、播放和缓存数据。请检查网络后重试。',
            actionLabel: '重试',
            onAction: () => _invalidateStats(ref),
          ),
          data: (stats) => EchoRefreshView(
            onRefresh: () => _refreshStats(ref),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1040),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    context.echoSpacing.md,
                    context.echoSpacing.lg,
                    context.echoSpacing.md,
                    context.echoSpacing.xxl +
                        context.echoShellBottomObstruction,
                  ),
                  children: <Widget>[
                    if (hasRemoteLoadFailed) ...<Widget>[
                      _StatsLoadNotice(onRetry: () => _refreshStats(ref)),
                      SizedBox(height: context.echoSpacing.lg),
                    ],
                    _MetricSection(
                      title: '播放总览',
                      description: '按服务器曲目中的播放次数估算。',
                      raised: true,
                      items: <_MetricItem>[
                        _MetricItem(
                          icon: AppIcons.equalizer,
                          label: '总播放次数',
                          value: _formatInteger(stats.totalPlayCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.musicFilled,
                          label: '有播放记录歌曲',
                          value: _formatInteger(stats.playedSongsCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.timer,
                          label: '估算累计播放时长',
                          value: _formatDuration(
                            stats.estimatedPlayedDurationSeconds,
                          ),
                        ),
                        _MetricItem(
                          icon: AppIcons.chart,
                          label: '平均每首播放次数',
                          value: stats.averagePlayCountPerSong.toStringAsFixed(
                            2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    _MetricSection(
                      title: '曲库总览',
                      items: <_MetricItem>[
                        _MetricItem(
                          icon: AppIcons.music,
                          label: '歌曲总数',
                          value: _formatInteger(stats.totalSongs),
                        ),
                        _MetricItem(
                          icon: AppIcons.albumOutline,
                          label: '专辑总数',
                          value: _formatInteger(stats.totalAlbums),
                        ),
                        _MetricItem(
                          icon: AppIcons.people,
                          label: '歌手总数',
                          value: _formatInteger(stats.totalArtists),
                        ),
                        _MetricItem(
                          icon: AppIcons.time,
                          label: '曲库总时长',
                          value: _formatDuration(
                            stats.totalSongDurationSeconds,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    _MetricSection(
                      title: '收藏统计',
                      items: <_MetricItem>[
                        _MetricItem(
                          icon: AppIcons.heartOutline,
                          label: '收藏歌曲',
                          value: _formatInteger(stats.starredSongCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.bookmark,
                          label: '收藏专辑',
                          value: _formatInteger(stats.starredAlbumCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.people,
                          label: '收藏歌手',
                          value: _formatInteger(stats.starredArtistCount),
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    _MetricSection(
                      title: '缓存效率',
                      description: '缓存命中与保护数据按当前音乐库统计。',
                      items: <_MetricItem>[
                        _MetricItem(
                          icon: AppIcons.storage,
                          label: '缓存条目',
                          value: _formatInteger(stats.cacheEntryCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.musicFilled,
                          label: '缓存歌曲',
                          value: _formatInteger(stats.cacheSongCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.sdCard,
                          label: '缓存大小',
                          value: _formatBytes(stats.cacheTotalBytes),
                        ),
                        _MetricItem(
                          icon: AppIcons.shield,
                          label: '受保护缓存条目',
                          value: _formatInteger(stats.cacheProtectedEntryCount),
                          detail: '播放次数 ≥ $cacheProtectionThreshold',
                        ),
                        _MetricItem(
                          icon: AppIcons.playCircleOutline,
                          label: '缓存命中次数',
                          value: _formatInteger(stats.cachePlayCount),
                        ),
                        _MetricItem(
                          icon: AppIcons.signal,
                          label: '移动网络节省流量',
                          value: _formatBytes(stats.cacheSavedTrafficBytes),
                          detail: '仅统计移动网络缓存命中',
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSettingsSection(
                      title: '最多播放歌曲',
                      description: '按歌曲累计播放次数排序。',
                      children: <Widget>[_TopSongsList(items: stats.topSongs)],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSettingsSection(
                      title: '最多播放歌手',
                      description: '将同名歌手的歌曲播放次数合并统计。',
                      children: <Widget>[
                        _TopArtistsList(items: stats.topArtists),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSettingsSection(
                      title: '最多播放专辑',
                      description: '按专辑内歌曲累计播放次数排序。',
                      children: <Widget>[
                        _TopAlbumsList(items: stats.topAlbums),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSettingsSection(
                      title: '最近播放专辑',
                      children: <Widget>[
                        _AlbumCollection(
                          albums: stats.recentAlbums,
                          emptyMessage: '暂无最近播放专辑',
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSettingsSection(
                      title: '常听专辑',
                      children: <Widget>[
                        _AlbumCollection(
                          albums: stats.frequentAlbums,
                          emptyMessage: '暂无常听专辑',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void _invalidateStats(WidgetRef ref) {
    ref.invalidate(allSongsProvider);
    ref.invalidate(allAlbumsProvider);
    ref.invalidate(allArtistsProvider);
    ref.invalidate(starredProvider);
    ref.invalidate(recentAlbumsProvider);
    ref.invalidate(frequentAlbumsProvider);
    ref.invalidate(playbackStatsProvider);
  }

  static Future<void> _refreshStats(WidgetRef ref) async {
    _invalidateStats(ref);
    await ref.read(playbackStatsProvider.future);
  }
}

class _MetricSection extends StatelessWidget {
  const _MetricSection({
    required this.title,
    required this.items,
    this.description,
    this.raised = false,
  });

  final String title;
  final String? description;
  final List<_MetricItem> items;
  final bool raised;

  @override
  Widget build(BuildContext context) {
    final metrics = LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(context).scale(1);
        final columns = constraints.maxWidth >= 720 && scale <= 1.3 ? 2 : 1;
        final gap = context.echoSpacing.md;
        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: context.echoSpacing.xs,
          children: <Widget>[
            for (final item in items)
              SizedBox(
                width: itemWidth,
                child: EchoMetricBlock(
                  icon: item.icon,
                  label: item.label,
                  value: item.value,
                  detail: item.detail,
                ),
              ),
          ],
        );
      },
    );

    return EchoSettingsSection(
      title: title,
      description: description,
      children: <Widget>[
        if (raised)
          EchoSurface(
            level: EchoSurfaceLevel.raised,
            borderColor: context.echoColors.controlBoundary,
            padding: EdgeInsets.symmetric(
              horizontal: context.echoSpacing.md,
              vertical: context.echoSpacing.xs,
            ),
            child: metrics,
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.echoSpacing.xs),
            child: metrics,
          ),
      ],
    );
  }
}

class _TopSongsList extends StatelessWidget {
  const _TopSongsList({required this.items});

  final List<SongPlayStat> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _InlineEmpty(message: '暂无歌曲播放记录');
    }
    return Column(
      children: <Widget>[
        for (var index = 0; index < items.length; index++)
          _RankedRow(
            rank: index + 1,
            coverArtId: items[index].song.coverArt,
            title: items[index].song.title,
            subtitle: _buildSongSubtitle(items[index]),
            value: '${_formatInteger(items[index].playCount)} 次',
          ),
      ],
    );
  }
}

class _TopArtistsList extends StatelessWidget {
  const _TopArtistsList({required this.items});

  final List<ArtistPlayStat> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _InlineEmpty(message: '暂无歌手播放记录');
    }
    return Column(
      children: <Widget>[
        for (var index = 0; index < items.length; index++)
          _RankedRow(
            rank: index + 1,
            icon: AppIcons.people,
            title: items[index].artistName,
            subtitle: '${_formatInteger(items[index].songCount)} 首歌曲',
            value: '${_formatInteger(items[index].playCount)} 次',
          ),
      ],
    );
  }
}

class _TopAlbumsList extends StatelessWidget {
  const _TopAlbumsList({required this.items});

  final List<AlbumPlayStat> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _InlineEmpty(message: '暂无专辑播放记录');
    }
    return Column(
      children: <Widget>[
        for (var index = 0; index < items.length; index++)
          _RankedRow(
            rank: index + 1,
            coverArtId: items[index].coverArtId,
            title: items[index].albumName,
            subtitle:
                '${items[index].artistName ?? '未知歌手'} · '
                '${_formatInteger(items[index].songCount)} 首歌曲',
            value: '${_formatInteger(items[index].playCount)} 次',
          ),
      ],
    );
  }
}

class _RankedRow extends StatelessWidget {
  const _RankedRow({
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.value,
    this.coverArtId,
    this.icon,
  });

  final int rank;
  final String title;
  final String subtitle;
  final String value;
  final String? coverArtId;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '第 $rank 名，$title，$subtitle，$value',
      child: ExcludeSemantics(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.3;
              final leading = Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    child: Text(
                      '$rank',
                      textAlign: TextAlign.center,
                      style: context.echoTypography.label.copyWith(
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: context.echoSpacing.xs),
                  SizedBox.square(
                    dimension: 48,
                    child: coverArtId != null
                        ? ClipRRect(
                            borderRadius: context.echoRadii.detail,
                            child: CoverArtImage(
                              coverArtId: coverArtId,
                              size: 48,
                              requestSize: 192,
                              semanticLabel: '$title 封面',
                            ),
                          )
                        : Center(
                            child: Icon(
                              icon ?? AppIcons.music,
                              color: context.echoColors.accent,
                            ),
                          ),
                  ),
                ],
              );
              final details = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    subtitle,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                  if (largeText) ...<Widget>[
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      value,
                      style: context.echoTypography.label.copyWith(
                        color: context.echoColors.accent,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ],
                ],
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  leading,
                  SizedBox(width: context.echoSpacing.sm),
                  Expanded(child: details),
                  if (!largeText) ...<Widget>[
                    SizedBox(width: context.echoSpacing.sm),
                    Text(
                      value,
                      style: context.echoTypography.label.copyWith(
                        color: context.echoColors.accent,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AlbumCollection extends StatelessWidget {
  const _AlbumCollection({required this.albums, required this.emptyMessage});

  final List<Album> albums;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) return _InlineEmpty(message: emptyMessage);
    return Wrap(
      spacing: context.echoSpacing.sm,
      runSpacing: context.echoSpacing.sm,
      children: <Widget>[
        for (final album in albums.take(16))
          SizedBox(
            width: 220,
            child: Semantics(
              container: true,
              label: '${album.name}，${album.artist ?? '未知歌手'}',
              child: ExcludeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: context.echoRadii.detail,
                      child: CoverArtImage(
                        coverArtId: album.coverArt,
                        size: 48,
                        requestSize: 192,
                        semanticLabel: '${album.name} 封面',
                      ),
                    ),
                    SizedBox(width: context.echoSpacing.xs),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(album.name, style: context.echoTypography.title),
                          SizedBox(height: context.echoSpacing.xxs),
                          Text(
                            album.artist ?? '未知歌手',
                            style: context.echoTypography.metadata.copyWith(
                              color: context.echoColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InlineEmpty extends StatelessWidget {
  const _InlineEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.echoSpacing.md,
        vertical: context.echoSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(AppIcons.info, size: 20, color: context.echoColors.muted),
          SizedBox(width: context.echoSpacing.xs),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsLoadNotice extends StatelessWidget {
  const _StatsLoadNotice({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      borderColor: context.echoColors.controlBoundary,
      padding: EdgeInsets.all(context.echoSpacing.sm),
      child: Row(
        children: <Widget>[
          Icon(AppIcons.wifiOff, color: context.echoColors.warning),
          SizedBox(width: context.echoSpacing.xs),
          Expanded(
            child: Text(
              '部分远程统计加载失败，当前结果可能来自缓存。',
              style: context.echoTypography.body,
            ),
          ),
          SizedBox(width: context.echoSpacing.xs),
          EchoButton.ghost(label: '重试', onPressed: onRetry),
        ],
      ),
    );
  }
}

class _StatsLoadingView extends StatelessWidget {
  const _StatsLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        context.echoSpacing.md,
        context.echoSpacing.md,
        context.echoSpacing.md,
        context.echoSpacing.md + context.echoShellBottomObstruction,
      ),
      children: <Widget>[
        const EchoSkeleton.line(width: 180, height: 28),
        SizedBox(height: context.echoSpacing.md),
        EchoSurface(
          level: EchoSurfaceLevel.raised,
          padding: EdgeInsets.all(context.echoSpacing.md),
          child: Column(
            children: <Widget>[
              for (var index = 0; index < 4; index++) ...<Widget>[
                Row(
                  children: <Widget>[
                    const EchoSkeleton.circle(),
                    SizedBox(width: context.echoSpacing.sm),
                    const Expanded(child: EchoSkeleton.line(height: 22)),
                  ],
                ),
                SizedBox(height: context.echoSpacing.md),
              ],
            ],
          ),
        ),
        SizedBox(height: context.echoSpacing.xl),
        for (var index = 0; index < 6; index++) ...<Widget>[
          const EchoSkeleton.line(height: 20),
          SizedBox(height: context.echoSpacing.md),
        ],
      ],
    );
  }
}

class _MetricItem {
  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? detail;
}

String _buildSongSubtitle(SongPlayStat stat) {
  final artist = stat.song.artist?.trim();
  final album = stat.song.album?.trim();
  if (artist?.isNotEmpty == true && album?.isNotEmpty == true) {
    return '$artist · $album';
  }
  if (artist?.isNotEmpty == true) return artist!;
  if (album?.isNotEmpty == true) return album!;
  return '未知';
}

String _formatInteger(num value) {
  final rounded = value.round();
  final negative = rounded < 0;
  var digits = rounded.abs().toString();
  final chunks = <String>[];
  while (digits.length > 3) {
    chunks.insert(0, digits.substring(digits.length - 3));
    digits = digits.substring(0, digits.length - 3);
  }
  chunks.insert(0, digits);
  return '${negative ? '-' : ''}${chunks.join(',')}';
}

String _formatDuration(int seconds) {
  if (seconds <= 0) return '0 分';
  final hours = seconds ~/ Duration.secondsPerHour;
  final minutes =
      (seconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
  if (hours > 0) return '$hours 小时 $minutes 分';
  return '$minutes 分';
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes 字节';
  final kb = bytes / 1024;
  if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
  final mb = kb / 1024;
  if (mb < 1024) return '${mb.toStringAsFixed(1)} MB';
  final gb = mb / 1024;
  return '${gb.toStringAsFixed(2)} GB';
}
