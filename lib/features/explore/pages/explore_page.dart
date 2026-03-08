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
import '../../../data/repositories/music_repository.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/main_scaffold.dart';
import '../../../widgets/skeleton_templates.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  static const _logTag = 'EXPLORE';
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  String _query = '';
  String? _resolvingSongId;
  bool _isBatchDownloading = false;

  // Selection mode
  final Set<String> _selectedSongIds = {};
  bool get _isSelectionMode => _selectedSongIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final mode = ref.read(exploreSearchModeProvider);
    if (mode != ExploreSearchMode.remote) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(exploreRemoteSearchProvider.notifier).loadNextPage();
    }
  }

  void _submitQuery(String value) {
    final q = value.trim();
    setState(() {
      _query = q;
      _selectedSongIds.clear();
    });

    final mode = ref.read(exploreSearchModeProvider);
    if (mode == ExploreSearchMode.remote && q.isNotEmpty) {
      final source = ref.read(exploreRemoteSourceProvider);
      final type = ref.read(exploreSearchTypeProvider);
      ref
          .read(exploreRemoteSearchProvider.notifier)
          .search(keyword: q, source: source, type: type);
    }
  }

  String _searchTypeLabel(ExploreSearchType type) {
    switch (type) {
      case ExploreSearchType.song:
        return '关键词';
      case ExploreSearchType.artist:
        return '歌手';
      case ExploreSearchType.album:
        return '专辑';
      case ExploreSearchType.playlist:
        return '歌单ID';
    }
  }

  String _hintText() {
    final mode = ref.read(exploreSearchModeProvider);
    final type = ref.read(exploreSearchTypeProvider);
    if (mode == ExploreSearchMode.local) return '搜索音乐库';
    if (type == ExploreSearchType.playlist) return '输入网易云歌单ID';
    final source = ref.read(exploreRemoteSourceProvider);
    return '搜索远程源 ($source)';
  }

  void _refreshSearchResults() {
    if (_query.isEmpty) return;
    final mode = ref.read(exploreSearchModeProvider);
    if (mode == ExploreSearchMode.local) {
      ref.invalidate(searchProvider(_query));
      setState(() {});
    } else {
      final source = ref.read(exploreRemoteSourceProvider);
      final type = ref.read(exploreSearchTypeProvider);
      ref
          .read(exploreRemoteSearchProvider.notifier)
          .search(keyword: _query, source: source, type: type);
    }
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

  Future<void> _enqueueSelectedSongs(List<Song> allSongs) async {
    final selected = allSongs
        .where((s) => _selectedSongIds.contains(s.id))
        .toList();
    if (selected.isEmpty) {
      _showSnackBar('没有选中的歌曲');
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
        title: const Text('下载选中歌曲'),
        content: Text('确认将选中的 ${selected.length} 首歌曲加入离线下载队列？'),
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
      'batch enqueue start count=${selected.length} '
      'first="${selected.first.title}" last="${selected.last.title}"',
    );

    setState(() {
      _isBatchDownloading = true;
    });

    var success = 0;
    var duplicated = 0;
    var failed = 0;
    final failedDetails = <String>[];

    try {
      for (final song in selected) {
        try {
          await service.enqueuePreviewSong(
            song: song,
            libraryId: activeLibrary.id,
            config: config,
          );
          success++;
        } catch (e) {
          final errText = e.toString();
          if (errText.contains('已在离线队列中')) {
            duplicated++;
          } else {
            failed++;
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
          _selectedSongIds.clear();
        });
      }
    }

    Logger.infoWithTag(
      _logTag,
      'batch enqueue end success=$success duplicated=$duplicated failed=$failed',
    );
    final detail = failedDetails.isEmpty ? '' : '\n${failedDetails.join('\n')}';
    _showSnackBar('批量下载完成：成功 $success，已存在 $duplicated，失败 $failed$detail');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _downloadAllOnPage() async {
    final remoteState = ref.read(exploreRemoteSearchProvider);
    final songs = remoteState.songs;
    if (songs.isEmpty) {
      _showSnackBar('当前页面没有歌曲');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('下载本页所有歌曲'),
        content: Text('确认将本页 ${songs.length} 首歌曲全部加入离线下载队列？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('全部下载'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Reuse the batch download logic
    setState(() {
      _selectedSongIds.addAll(songs.map((s) => s.id));
    });
    await _enqueueSelectedSongs(songs);
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim();
    final searchMode = ref.watch(exploreSearchModeProvider);
    final searchType = ref.watch(exploreSearchTypeProvider);
    final remoteSource = ref.watch(exploreRemoteSourceProvider);

    // Local search
    final localSearchAsync =
        (searchMode == ExploreSearchMode.local && query.isNotEmpty)
        ? ref.watch(searchProvider(query))
        : null;

    // Remote search state
    final remoteState = ref.watch(exploreRemoteSearchProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('探索'),
        actions: [
          // ── Download all on page (remote mode with results) ──
          if (searchMode == ExploreSearchMode.remote)
            Builder(
              builder: (context) {
                final hasResults = ref
                    .watch(exploreRemoteSearchProvider)
                    .songs
                    .isNotEmpty;
                return IconButton(
                  tooltip: '下载本页所有',
                  onPressed: hasResults && !_isBatchDownloading
                      ? _downloadAllOnPage
                      : null,
                  icon: const Icon(Icons.download_for_offline_outlined),
                );
              },
            ),
          IconButton(
            tooltip: '刷新',
            onPressed: query.isEmpty ? null : _refreshSearchResults,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            tooltip: '菜单',
            onSelected: (value) {
              if (value == 'local') {
                ref.read(exploreSearchModeProvider.notifier).state =
                    ExploreSearchMode.local;
                ref.read(exploreRemoteSearchProvider.notifier).reset();
                setState(() {
                  _selectedSongIds.clear();
                });
                if (_query.isNotEmpty) {
                  // Trigger local search rebuild
                  setState(() {});
                }
              } else if (value == 'remote') {
                ref.read(exploreSearchModeProvider.notifier).state =
                    ExploreSearchMode.remote;
                setState(() {
                  _selectedSongIds.clear();
                });
                if (_query.isNotEmpty) {
                  final source = ref.read(exploreRemoteSourceProvider);
                  final type = ref.read(exploreSearchTypeProvider);
                  ref
                      .read(exploreRemoteSearchProvider.notifier)
                      .search(keyword: _query, source: source, type: type);
                }
              } else if (value.startsWith('source:')) {
                final source = value.substring(7);
                ref.read(exploreRemoteSourceProvider.notifier).state = source;
                ref.read(exploreSearchModeProvider.notifier).state =
                    ExploreSearchMode.remote;
                setState(() {
                  _selectedSongIds.clear();
                });
                if (_query.isNotEmpty) {
                  final type = ref.read(exploreSearchTypeProvider);
                  ref
                      .read(exploreRemoteSearchProvider.notifier)
                      .search(keyword: _query, source: source, type: type);
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'local',
                child: Row(
                  children: [
                    Icon(
                      Icons.library_music,
                      size: 20,
                      color: searchMode == ExploreSearchMode.local
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('搜索音乐库'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'remote',
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_outlined,
                      size: 20,
                      color: searchMode == ExploreSearchMode.remote
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const Text('搜索远程源'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                enabled: false,
                child: Text(
                  '切换远程源',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ...['netease', 'kuwo', 'joox', 'bilibili'].map(
                (s) => PopupMenuItem(
                  value: 'source:$s',
                  child: Row(
                    children: [
                      if (remoteSource == s)
                        Icon(
                          Icons.check,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      else
                        const SizedBox(width: 18),
                      const SizedBox(width: 8),
                      Text(s),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // ── Search bar ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: _hintText(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _query = '';
                                _selectedSongIds.clear();
                              });
                              ref
                                  .read(exploreRemoteSearchProvider.notifier)
                                  .reset();
                            },
                          ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                  onSubmitted: _submitQuery,
                ),
              ),

              // ── Mode indicator ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: Row(
                  children: [
                    Icon(
                      searchMode == ExploreSearchMode.local
                          ? Icons.library_music
                          : Icons.cloud_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      searchMode == ExploreSearchMode.local
                          ? '音乐库搜索'
                          : '远程搜索 · $remoteSource',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Search type chips (remote mode only) ──
              if (searchMode == ExploreSearchMode.remote)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ExploreSearchType.values
                        .where(
                          (t) => t != ExploreSearchType.playlist,
                        ) // 暂时隐藏歌单ID
                        .map((type) {
                          final selected = type == searchType;
                          return ChoiceChip(
                            label: Text(_searchTypeLabel(type)),
                            selected: selected,
                            onSelected: (_) {
                              ref
                                      .read(exploreSearchTypeProvider.notifier)
                                      .state =
                                  type;
                              if (type == ExploreSearchType.playlist) {
                                // Playlist only supports netease
                                ref
                                        .read(
                                          exploreRemoteSourceProvider.notifier,
                                        )
                                        .state =
                                    'netease';
                              }
                              setState(() {
                                _selectedSongIds.clear();
                              });
                              // Re-search if there's a query
                              if (_query.isNotEmpty) {
                                final source = ref.read(
                                  exploreRemoteSourceProvider,
                                );
                                ref
                                    .read(exploreRemoteSearchProvider.notifier)
                                    .search(
                                      keyword: _query,
                                      source: source,
                                      type: type,
                                    );
                              }
                            },
                          );
                        })
                        .toList(),
                  ),
                ),

              // ── Body ──
              if (query.isEmpty)
                const Expanded(child: Center(child: Text('输入关键词，探索音乐')))
              else if (searchMode == ExploreSearchMode.local)
                Expanded(child: _buildLocalResults(localSearchAsync))
              else
                Expanded(child: _buildRemoteResults(remoteState)),
            ],
          ),
        ),
      ),

      // ── Floating batch download bar ──
      bottomNavigationBar: _isSelectionMode
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedSongIds.clear();
                        });
                      },
                      child: const Text('取消选择'),
                    ),
                    const Spacer(),
                    Text('已选 ${_selectedSongIds.length} 首'),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: _isBatchDownloading
                          ? null
                          : () {
                              final remoteState = ref.read(
                                exploreRemoteSearchProvider,
                              );
                              _enqueueSelectedSongs(remoteState.songs);
                            },
                      icon: _isBatchDownloading
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.download_for_offline_outlined),
                      label: Text(_isBatchDownloading ? '下载中...' : '下载选中'),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  // ── Local search results ──
  Widget _buildLocalResults(AsyncValue<SearchResult>? localSearchAsync) {
    if (localSearchAsync == null) {
      return const Center(child: Text('音乐库暂无匹配歌曲'));
    }
    return localSearchAsync.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      data: (result) {
        if (result.songs.isEmpty) {
          return const Center(child: Text('音乐库暂无匹配歌曲'));
        }
        return ListView.builder(
          itemCount: result.songs.length,
          itemBuilder: (context, index) {
            final song = result.songs[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CoverArtImage(coverArtId: song.coverArt, size: 50),
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
                  _badge(context, '音乐库'),
                  const SizedBox(width: 8),
                  Text(song.durationString),
                ],
              ),
              onTap: () {
                final songs = result.songs;
                ref
                    .read(playerProvider.notifier)
                    .playQueue(songs, startIndex: songs.indexOf(song));
              },
            );
          },
        );
      },
      loading: () => const ListTileSkeleton(count: 5),
      error: (error, _) => const Center(child: Text('音乐库搜索失败，请检查网络')),
    );
  }

  // ── Remote search results with infinite scroll ──
  Widget _buildRemoteResults(ExploreRemoteState remoteState) {
    if (remoteState.songs.isEmpty &&
        !remoteState.isLoading &&
        remoteState.error == null) {
      return const Center(child: Text('远程源暂无匹配歌曲'));
    }

    final itemCount =
        remoteState.songs.length +
        (remoteState.isLoading || remoteState.error != null ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Footer: loading indicator or error
        if (index >= remoteState.songs.length) {
          if (remoteState.error != null) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    remoteState.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ref
                          .read(exploreRemoteSearchProvider.notifier)
                          .loadNextPage();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('重试'),
                  ),
                ],
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final song = remoteState.songs[index];
        final isResolving = _resolvingSongId == song.id;
        final isSelected = _selectedSongIds.contains(song.id);

        return ListTile(
          selected: isSelected,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          leading:
              song.previewCoverUrl != null && song.previewCoverUrl!.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(song.previewCoverUrl!),
                )
              : const CircleAvatar(child: Icon(Icons.music_note)),
          title: Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            '${song.artist ?? '未知歌手'}${song.album == null ? '' : ' · ${song.album}'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: _isSelectionMode
              ? Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _selectedSongIds.add(song.id);
                      } else {
                        _selectedSongIds.remove(song.id);
                      }
                    });
                  },
                )
              : isResolving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _badge(context, '试听'),
                    IconButton(
                      icon: const Icon(Icons.download_outlined),
                      tooltip: '添加到离线下载队列',
                      onPressed: () => _enqueuePreview(song),
                    ),
                  ],
                ),
          onTap: _isSelectionMode
              ? () {
                  setState(() {
                    if (isSelected) {
                      _selectedSongIds.remove(song.id);
                    } else {
                      _selectedSongIds.add(song.id);
                    }
                  });
                }
              : () => _playPreview(song),
          onLongPress: () {
            setState(() {
              _selectedSongIds.add(song.id);
            });
          },
        );
      },
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
