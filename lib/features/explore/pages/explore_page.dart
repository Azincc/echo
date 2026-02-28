import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../../data/models/embed_service_config.dart';
import '../../../data/models/song.dart';
import '../../../providers/explore_provider.dart';
import '../../../providers/gd_music_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/main_scaffold.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  static const _logTag = 'EXPLORE';
  final _searchController = TextEditingController();
  String _query = '';
  String? _resolvingSongId;
  int _previewPage = 1;
  bool _isBatchDownloading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitQuery(String value) {
    setState(() {
      _query = value.trim();
      _previewPage = 1;
    });
  }

  String _modeLabel(ExplorePreviewSearchMode mode) {
    switch (mode) {
      case ExplorePreviewSearchMode.song:
        return '关键词';
      case ExplorePreviewSearchMode.artist:
        return '歌手';
      case ExplorePreviewSearchMode.album:
        return '专辑';
    }
  }

  ExplorePreviewQuery _buildPreviewQuery({
    required String query,
    required String source,
    required ExplorePreviewSearchMode mode,
  }) {
    return ExplorePreviewQuery(
      keyword: query,
      source: source,
      mode: mode,
      page: _previewPage,
      count: explorePreviewPageSize,
    );
  }

  void _refreshSearchResults(String query, ExplorePreviewQuery? previewQuery) {
    if (query.isEmpty) return;
    // Use invalidate instead of refresh for autoDispose.family providers.
    // invalidate fully destroys the provider state so the next ref.watch()
    // in build() will re-create the provider and issue a fresh remote request.
    ref.invalidate(searchProvider(query));
    if (previewQuery != null) {
      ref.invalidate(explorePreviewSongsProvider(previewQuery));
    }
    setState(() {}); // Ensure rebuild picks up invalidated providers
    _showSnackBar('已刷新搜索结果');
  }

  Future<void> _playPreview(Song song) async {
    final source = song.previewSource?.trim() ?? '';
    final trackId = song.previewTrackId?.trim() ?? '';
    if (source.isEmpty || trackId.isEmpty) {
      _showSnackBar('试听歌曲数据不完整，无法播放');
      return;
    }
    Logger.infoWithTag(
      _logTag,
      'playPreview start source=$source track=$trackId title="${song.title}"',
    );

    setState(() {
      _resolvingSongId = song.id;
    });

    try {
      final gdClient = ref.read(gdMusicApiClientProvider);
      final resolved = await gdClient.resolveSongUrl(
        source: source,
        trackId: trackId,
      );

      String? coverUrl = song.previewCoverUrl;
      final picId = song.previewPicId;
      if ((coverUrl == null || coverUrl.isEmpty) &&
          picId != null &&
          picId.isNotEmpty) {
        coverUrl = await gdClient.resolveCoverUrl(source: source, picId: picId);
      }

      final playSong = song.copyWith(
        isPreview: true,
        previewStreamUrl: resolved.url,
        previewCoverUrl: coverUrl,
        previewQualityLabel: resolved.qualityLabel,
        previewRequestHeaders: resolved.requiredHeaders,
        bitRate: resolved.bitRateKbps,
        suffix: resolved.suffix ?? song.suffix,
      );

      await ref.read(playerProvider.notifier).playPreviewSong(playSong);
      Logger.infoWithTag(
        _logTag,
        'playPreview queued to player source=$source track=$trackId title="${song.title}"',
      );
    } catch (e) {
      Logger.errorWithTag(
        _logTag,
        'playPreview failed source=$source track=$trackId title="${song.title}"',
        e,
      );
      _showSnackBar('试听播放失败: $e');
    } finally {
      if (mounted) {
        setState(() {
          _resolvingSongId = null;
        });
      }
    }
  }

  Future<void> _enqueuePreview(Song song, {bool force = false}) async {
    final activeLibrary = ref.read(activeLibraryProvider);
    if (activeLibrary == null) {
      _showSnackBar('当前没有活跃音乐库');
      return;
    }

    final config = EmbedServiceConfig.fromLibraryExtensions(
      activeLibrary.extensions,
    );
    try {
      Logger.infoWithTag(
        _logTag,
        'enqueue single start source=${song.previewSource} track=${song.previewTrackId} title="${song.title}" force=$force',
      );
      await ref
          .read(offlineDownloadServiceProvider)
          .enqueuePreviewSong(
            song: song,
            libraryId: activeLibrary.id,
            config: config,
            force: force,
          );
      Logger.infoWithTag(
        _logTag,
        'enqueue single success source=${song.previewSource} track=${song.previewTrackId}',
      );
      _showSnackBar(force ? '已重新添加到离线下载队列' : '已添加到离线下载队列');
    } catch (e) {
      Logger.errorWithTag(
        _logTag,
        'enqueue single failed source=${song.previewSource} track=${song.previewTrackId} title="${song.title}"',
        e,
      );
      if (e.toString().contains('已在离线队列中') && !force) {
        _showForceRedownloadDialog(song);
      } else {
        _showSnackBar('下载失败: $e');
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
        _enqueuePreview(song, force: true);
      }
    });
  }

  Future<void> _enqueueCurrentPageSongs(List<Song> songs) async {
    if (songs.isEmpty) {
      _showSnackBar('当前页没有可下载歌曲');
      return;
    }

    final activeLibrary = ref.read(activeLibraryProvider);
    if (activeLibrary == null) {
      _showSnackBar('当前没有活跃音乐库');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('下载本页歌曲'),
        content: Text('确认将当前页 ${songs.length} 首歌曲加入离线下载队列？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认下载'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final config = EmbedServiceConfig.fromLibraryExtensions(
      activeLibrary.extensions,
    );
    final service = ref.read(offlineDownloadServiceProvider);
    Logger.infoWithTag(
      _logTag,
      'batch enqueue start page=$_previewPage count=${songs.length} '
      'first="${songs.first.title}" last="${songs.last.title}"',
    );

    setState(() {
      _isBatchDownloading = true;
    });

    var success = 0;
    var duplicated = 0;
    var failed = 0;
    final failedDetails = <String>[];

    try {
      for (final song in songs) {
        try {
          await service.enqueuePreviewSong(
            song: song,
            libraryId: activeLibrary.id,
            config: config,
          );
          success++;
        } catch (e) {
          final source = song.previewSource ?? '';
          final trackId = song.previewTrackId ?? '';
          final errText = e.toString();
          if (e.toString().contains('已在离线队列中')) {
            duplicated++;
            Logger.warnWithTag(
              _logTag,
              'batch enqueue duplicated source=$source track=$trackId title="${song.title}"',
            );
          } else {
            failed++;
            Logger.errorWithTag(
              _logTag,
              'batch enqueue failed source=$source track=$trackId title="${song.title}"',
              e,
            );
            if (failedDetails.length < 3) {
              failedDetails.add('${song.title}: $errText');
            }
          }
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isBatchDownloading = false;
        });
      }
    }

    Logger.infoWithTag(
      _logTag,
      'batch enqueue end page=$_previewPage success=$success duplicated=$duplicated failed=$failed',
    );
    final detail = failedDetails.isEmpty ? '' : '\n${failedDetails.join('\n')}';
    _showSnackBar('本页下载完成：成功 $success，已存在 $duplicated，失败 $failed$detail');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim();
    final previewSource = ref.watch(explorePreviewSourceProvider);
    final previewMode = ref.watch(explorePreviewModeProvider);

    final localSearchAsync = query.isEmpty
        ? null
        : ref.watch(searchProvider(query));
    final previewQuery = query.isEmpty
        ? null
        : _buildPreviewQuery(
            query: query,
            source: previewSource,
            mode: previewMode,
          );
    final previewSongsAsync = previewQuery == null
        ? null
        : ref.watch(explorePreviewSongsProvider(previewQuery));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('探索'),
        actions: [
          IconButton(
            tooltip: '刷新搜索结果',
            onPressed: query.isEmpty
                ? null
                : () => _refreshSearchResults(query, previewQuery),
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            initialValue: previewSource,
            tooltip: '试听源',
            onSelected: (value) {
              ref.read(explorePreviewSourceProvider.notifier).state = value;
              setState(() {
                _previewPage = 1;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'netease', child: Text('试听源: netease')),
              PopupMenuItem(value: 'kuwo', child: Text('试听源: kuwo')),
              PopupMenuItem(value: 'joox', child: Text('试听源: joox')),
              PopupMenuItem(value: 'bilibili', child: Text('试听源: bilibili')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: '搜索歌曲（音乐库 + 试听）',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _query = '';
                            _previewPage = 1;
                          });
                        },
                      ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: _submitQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ExplorePreviewSearchMode.values.map((mode) {
                final selected = mode == previewMode;
                return ChoiceChip(
                  label: Text(_modeLabel(mode)),
                  selected: selected,
                  onSelected: (_) {
                    ref.read(explorePreviewModeProvider.notifier).state = mode;
                    setState(() {
                      _previewPage = 1;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                previewMode == ExplorePreviewSearchMode.album
                    ? '专辑模式使用 source_album 搜索，每页 30 条'
                    : '每页 30 条，支持刷新与分页',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          if (query.isEmpty)
            const Expanded(child: Center(child: Text('输入关键词，探索音乐库与试听歌曲')))
          else
            Expanded(
              child: ListView(
                children: [
                  _SectionTitle(icon: Icons.library_music, title: '音乐库（正常歌曲）'),
                  if (localSearchAsync == null)
                    const SizedBox.shrink()
                  else
                    localSearchAsync.when(
                      skipLoadingOnReload: false,
                      skipLoadingOnRefresh: false,
                      data: (result) {
                        if (result.songs.isEmpty) {
                          return const ListTile(title: Text('音乐库暂无匹配歌曲'));
                        }
                        return Column(
                          children: result.songs.map((song) {
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CoverArtImage(
                                  coverArtId: song.coverArt,
                                  size: 50,
                                ),
                              ),
                              title: Text(
                                song.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '${song.artist ?? '未知歌手'}${song.album == null ? '' : ' · ${song.album}'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _badge(context, '正常'),
                                  const SizedBox(width: 8),
                                  Text(song.durationString),
                                ],
                              ),
                              onTap: () {
                                final songs = result.songs;
                                ref
                                    .read(playerProvider.notifier)
                                    .playQueue(
                                      songs,
                                      startIndex: songs.indexOf(song),
                                    );
                              },
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (error, _) =>
                          const ListTile(title: Text('音乐库搜索失败，请检查网络')),
                    ),
                  const SizedBox(height: 8),
                  _SectionTitle(icon: Icons.headphones, title: '在线试听'),
                  if (previewSongsAsync == null)
                    const SizedBox.shrink()
                  else
                    previewSongsAsync.when(
                      skipLoadingOnReload: false,
                      skipLoadingOnRefresh: false,
                      data: (songs) {
                        final canPrev = _previewPage > 1;
                        final canNext = songs.length >= explorePreviewPageSize;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '模式: ${_modeLabel(previewMode)} · 源: $previewSource · 第 $_previewPage 页',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () => _refreshSearchResults(
                                          query,
                                          previewQuery,
                                        ),
                                        icon: const Icon(Icons.refresh),
                                        label: const Text('刷新'),
                                      ),
                                      FilledButton.icon(
                                        onPressed: _isBatchDownloading
                                            ? null
                                            : () => _enqueueCurrentPageSongs(
                                                songs,
                                              ),
                                        icon: _isBatchDownloading
                                            ? const SizedBox(
                                                width: 14,
                                                height: 14,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : const Icon(
                                                Icons
                                                    .download_for_offline_outlined,
                                              ),
                                        label: Text(
                                          _isBatchDownloading
                                              ? '下载中...'
                                              : '下载本页全部',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (songs.isEmpty)
                              const ListTile(title: Text('试听源暂无匹配歌曲'))
                            else
                              Column(
                                children: songs.map((song) {
                                  final isResolving =
                                      _resolvingSongId == song.id;
                                  return ListTile(
                                    leading:
                                        song.previewCoverUrl != null &&
                                            song.previewCoverUrl!.isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              song.previewCoverUrl!,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            child: Icon(Icons.music_note),
                                          ),
                                    title: Text(
                                      song.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${song.artist ?? '未知歌手'}${song.album == null ? '' : ' · ${song.album}'}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: isResolving
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _badge(context, '试听'),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.download_outlined,
                                                ),
                                                tooltip: '添加到离线下载队列',
                                                onPressed: () {
                                                  _enqueuePreview(song);
                                                },
                                              ),
                                            ],
                                          ),
                                    onTap: () => _playPreview(song),
                                  );
                                }).toList(),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    tooltip: '上一页',
                                    onPressed: canPrev
                                        ? () {
                                            setState(() {
                                              _previewPage--;
                                            });
                                          }
                                        : null,
                                    icon: const Icon(Icons.chevron_left),
                                  ),
                                  Text(
                                    '第 $_previewPage 页 · 本页 ${songs.length} 首',
                                  ),
                                  IconButton(
                                    tooltip: '下一页',
                                    onPressed: canNext
                                        ? () {
                                            setState(() {
                                              _previewPage++;
                                            });
                                          }
                                        : null,
                                    icon: const Icon(Icons.chevron_right),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('加载试听结果中...'),
                            SizedBox(height: 12),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                      error: (error, _) => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('试听搜索失败，请检查网络'),
                            const SizedBox(height: 8),
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _refreshSearchResults(query, previewQuery),
                              icon: const Icon(Icons.refresh),
                              label: const Text('重试'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _badge(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
