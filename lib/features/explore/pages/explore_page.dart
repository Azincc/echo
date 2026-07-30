import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/embed_service_config.dart';
import '../../../data/models/song.dart';
import '../../../data/repositories/music_repository.dart';
import '../../../providers/explore_provider.dart';
import '../../../providers/gd_music_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/main_scaffold.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/explore_widgets.dart';

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
  final Set<String> _submittingDownloadKeys = <String>{};
  final Set<String> _queuedDownloadKeys = <String>{};

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
    _showMessage('已刷新搜索结果', kind: EchoMessageKind.success);
  }

  Future<void> _playPreview(Song song) async {
    final source = song.previewSource?.trim() ?? '';
    final trackId = song.previewTrackId?.trim() ?? '';
    if (source.isEmpty || trackId.isEmpty) {
      _showMessage('试听歌曲数据不完整，无法播放', kind: EchoMessageKind.error);
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
      _showMessage('试听播放失败: $e', kind: EchoMessageKind.error);
    } finally {
      if (mounted) {
        setState(() {
          _resolvingSongId = null;
        });
      }
    }
  }

  void _showPreviewActions(Song song) {
    unawaited(showSongOptionsSheet(context: context, song: song));
  }

  Future<void> _enqueuePreview(Song song, {bool force = false}) async {
    final downloadKey = _previewDownloadKey(song);
    if (_submittingDownloadKeys.contains(downloadKey) ||
        (!force && _queuedDownloadKeys.contains(downloadKey))) {
      return;
    }

    final activeLibrary = ref.read(activeLibraryProvider);
    if (activeLibrary == null) {
      _showMessage('当前没有活跃音乐库', kind: EchoMessageKind.warning);
      return;
    }

    final config = EmbedServiceConfig.fromLibraryExtensions(
      activeLibrary.extensions,
    );
    setState(() => _submittingDownloadKeys.add(downloadKey));
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
      if (mounted) {
        setState(() => _queuedDownloadKeys.add(downloadKey));
      }
      _showMessage(
        force ? '已重新添加到离线下载队列' : '已添加到离线下载队列',
        kind: EchoMessageKind.success,
      );
    } catch (e) {
      Logger.errorWithTag(
        _logTag,
        'enqueue single failed source=${song.previewSource} track=${song.previewTrackId} title="${song.title}"',
        e,
      );
      if (e.toString().contains('已在离线队列中') && !force) {
        if (mounted) {
          setState(() => _queuedDownloadKeys.add(downloadKey));
        }
        _showForceRedownloadDialog(song);
      } else {
        _showMessage('下载失败: $e', kind: EchoMessageKind.error);
      }
    } finally {
      if (mounted) {
        setState(() => _submittingDownloadKeys.remove(downloadKey));
      }
    }
  }

  void _showForceRedownloadDialog(Song song) {
    if (!mounted) return;
    showEchoBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '歌曲已存在',
        subtitle: '「${song.title}」已在离线下载队列中。',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '重新下载会替换队列中的现有任务。',
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
            SizedBox(height: context.echoSpacing.lg),
            EchoButton.primary(
              label: '重新下载',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
            SizedBox(height: context.echoSpacing.xs),
            EchoButton.ghost(
              label: '取消',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(false),
            ),
          ],
        ),
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
      _showMessage('没有选中的歌曲', kind: EchoMessageKind.warning);
      return;
    }

    final activeLibrary = ref.read(activeLibraryProvider);
    if (activeLibrary == null) {
      _showMessage('当前没有活跃音乐库', kind: EchoMessageKind.warning);
      return;
    }

    final confirm = await _confirmDownload(
      title: '下载选中歌曲',
      description: '将选中的 ${selected.length} 首歌曲加入离线下载队列。',
      confirmLabel: '确认下载',
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
    final messageKind = failed == 0
        ? EchoMessageKind.success
        : success == 0
        ? EchoMessageKind.error
        : EchoMessageKind.warning;
    _showMessage(
      '批量下载完成：成功 $success，已存在 $duplicated，失败 $failed$detail',
      kind: messageKind,
    );
  }

  void _showMessage(
    String message, {
    EchoMessageKind kind = EchoMessageKind.info,
  }) {
    if (!mounted) return;
    ToastNotifier.show(message, kind: kind);
  }

  Future<void> _downloadAllOnPage() async {
    final remoteState = ref.read(exploreRemoteSearchProvider);
    final songs = remoteState.songs;
    if (songs.isEmpty) {
      _showMessage('当前页面没有歌曲', kind: EchoMessageKind.warning);
      return;
    }

    final confirm = await _confirmDownload(
      title: '下载本页所有歌曲',
      description: '将本页 ${songs.length} 首歌曲全部加入离线下载队列。',
      confirmLabel: '全部下载',
    );

    if (confirm != true) return;

    // Reuse the batch download logic
    setState(() {
      _selectedSongIds.addAll(songs.map((s) => s.id));
    });
    await _enqueueSelectedSongs(songs);
  }

  Future<bool> _confirmDownload({
    required String title,
    required String description,
    required String confirmLabel,
  }) async {
    if (!mounted) return false;
    final result = await showEchoBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: title,
        subtitle: description,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            EchoButton.primary(
              label: confirmLabel,
              expand: true,
              leadingIcon: AppIcons.downloadOutline,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
            SizedBox(height: context.echoSpacing.xs),
            EchoButton.ghost(
              label: '取消',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(false),
            ),
          ],
        ),
      ),
    );
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim();
    final searchMode = ref.watch(exploreSearchModeProvider);
    final searchType = ref.watch(exploreSearchTypeProvider);
    final remoteSource = ref.watch(exploreRemoteSourceProvider);
    final localSearchAsync =
        searchMode == ExploreSearchMode.local && query.isNotEmpty
        ? ref.watch(searchProvider(query))
        : null;
    final localSearchLoadFailed =
        searchMode == ExploreSearchMode.local && query.isNotEmpty
        ? ref.watch(searchLoadFailedProvider(query))
        : false;
    final remoteState = ref.watch(exploreRemoteSearchProvider);

    return VisibleRemoteRetryScope(
      branchIndex: exploreBranchIndex,
      debugLabel: 'explore_page',
      shouldRetry: (ref) {
        if (query.isEmpty) return false;
        if (searchMode == ExploreSearchMode.local) {
          return localSearchLoadFailed ||
              ref.read(searchProvider(query)).hasError;
        }
        return remoteState.query.isNotEmpty &&
            remoteState.error != null &&
            !remoteState.isLoading;
      },
      onRetry: (ref) {
        if (query.isEmpty) return;
        if (searchMode == ExploreSearchMode.local) {
          ref.invalidate(searchProvider(query));
          return;
        }
        ref.read(exploreRemoteSearchProvider.notifier).loadNextPage();
      },
      child: Scaffold(
        backgroundColor: context.echoColors.canvas,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              EchoPageHeader(
                title: '探索',
                leading: shouldShowPageDrawerTrigger(context)
                    ? EchoIconButton(
                        icon: AppIcons.menu,
                        label: '打开应用菜单',
                        onPressed: openEchoAppDrawer,
                      )
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EchoIconButton(
                      icon: AppIcons.refresh,
                      label: '刷新搜索结果',
                      onPressed: query.isEmpty ? null : _refreshSearchResults,
                    ),
                    EchoIconButton(
                      icon: AppIcons.more,
                      label: '切换搜索范围和远程来源',
                      onPressed: () => _showSearchOptions(
                        searchMode: searchMode,
                        remoteSource: remoteSource,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoPageHorizontalPadding,
                  0,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchController,
                      builder: (context, value, child) {
                        return EchoTextField(
                          controller: _searchController,
                          label: _searchTypeLabel(searchType),
                          hintText: _hintText(),
                          leadingIcon: AppIcons.search,
                          textInputAction: TextInputAction.search,
                          onChanged: (_) => setState(() {}),
                          onSubmitted: _submitQuery,
                          trailing: value.text.isEmpty
                              ? null
                              : EchoIconButton(
                                  icon: AppIcons.close,
                                  label: '清空探索搜索',
                                  onPressed: _clearQuery,
                                ),
                        );
                      },
                    ),
                    SizedBox(height: context.echoSpacing.sm),
                    ExploreModeControl(
                      icon: searchMode == ExploreSearchMode.local
                          ? AppIcons.library
                          : AppIcons.cloud,
                      title: searchMode == ExploreSearchMode.local
                          ? '音乐库搜索'
                          : '远程搜索',
                      description: searchMode == ExploreSearchMode.local
                          ? '在当前音乐库中查找歌曲'
                          : '当前来源：$remoteSource',
                      onPressed: () => _showSearchOptions(
                        searchMode: searchMode,
                        remoteSource: remoteSource,
                      ),
                    ),
                    if (searchMode == ExploreSearchMode.remote) ...<Widget>[
                      SizedBox(height: context.echoSpacing.sm),
                      Wrap(
                        spacing: context.echoSpacing.xs,
                        runSpacing: context.echoSpacing.xs,
                        children: <Widget>[
                          for (final type in ExploreSearchType.values.where(
                            (type) => type != ExploreSearchType.playlist,
                          ))
                            ExploreFilterOption<ExploreSearchType>(
                              value: type,
                              label: _searchTypeLabel(type),
                              selected: type == searchType,
                              onSelected: _selectSearchType,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: query.isEmpty
                    ? _withBottomObstruction(
                        const EchoEmptyState(
                          title: '输入关键词，探索音乐',
                          description: '可以搜索当前音乐库，也可以切换远程来源试听并加入离线下载。',
                          icon: AppIcons.discover,
                        ),
                      )
                    : searchMode == ExploreSearchMode.local
                    ? _buildLocalResults(
                        localSearchAsync,
                        loadFailed: localSearchLoadFailed,
                      )
                    : _buildRemoteResults(remoteState),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _isSelectionMode
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: context.echoShellBottomObstruction,
                ),
                child: SafeArea(
                  top: false,
                  bottom: context.echoShellBottomObstruction == 0,
                  child: ExploreSelectionBar(
                    selectedCount: _selectedSongIds.length,
                    downloading: _isBatchDownloading,
                    onCancel: () => setState(_selectedSongIds.clear),
                    onDownload: () {
                      final current = ref.read(exploreRemoteSearchProvider);
                      _enqueueSelectedSongs(current.songs);
                    },
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _clearQuery() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selectedSongIds.clear();
    });
    ref.read(exploreRemoteSearchProvider.notifier).reset();
  }

  void _selectSearchType(ExploreSearchType type) {
    ref.read(exploreSearchTypeProvider.notifier).state = type;
    if (type == ExploreSearchType.playlist) {
      ref.read(exploreRemoteSourceProvider.notifier).state = 'netease';
    }
    setState(_selectedSongIds.clear);
    if (_query.isEmpty) return;
    final source = ref.read(exploreRemoteSourceProvider);
    ref
        .read(exploreRemoteSearchProvider.notifier)
        .search(keyword: _query, source: source, type: type);
  }

  void _setSearchMode(ExploreSearchMode mode) {
    ref.read(exploreSearchModeProvider.notifier).state = mode;
    setState(_selectedSongIds.clear);
    if (mode == ExploreSearchMode.local) {
      ref.read(exploreRemoteSearchProvider.notifier).reset();
      if (_query.isNotEmpty) setState(() {});
      return;
    }
    if (_query.isEmpty) return;
    final source = ref.read(exploreRemoteSourceProvider);
    final type = ref.read(exploreSearchTypeProvider);
    ref
        .read(exploreRemoteSearchProvider.notifier)
        .search(keyword: _query, source: source, type: type);
  }

  void _setRemoteSource(String source) {
    ref.read(exploreRemoteSourceProvider.notifier).state = source;
    ref.read(exploreSearchModeProvider.notifier).state =
        ExploreSearchMode.remote;
    setState(_selectedSongIds.clear);
    if (_query.isEmpty) return;
    final type = ref.read(exploreSearchTypeProvider);
    ref
        .read(exploreRemoteSearchProvider.notifier)
        .search(keyword: _query, source: source, type: type);
  }

  Future<void> _showSearchOptions({
    required ExploreSearchMode searchMode,
    required String remoteSource,
  }) async {
    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '搜索范围与来源',
        subtitle: '本地搜索使用当前音乐库；远程结果可以试听或加入离线下载。',
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.62,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                EchoActionRow(
                  icon: AppIcons.library,
                  title: '搜索音乐库',
                  subtitle: '当前 Navidrome / Subsonic 音乐库',
                  selected: searchMode == ExploreSearchMode.local,
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _setSearchMode(ExploreSearchMode.local);
                  },
                ),
                EchoActionRow(
                  icon: AppIcons.cloud,
                  title: '搜索远程源',
                  subtitle: '试听结果并按需加入离线下载',
                  selected: searchMode == ExploreSearchMode.remote,
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _setSearchMode(ExploreSearchMode.remote);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.echoSpacing.xs,
                  ),
                  child: const EchoDivider(),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '远程来源',
                    style: context.echoTypography.label.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ),
                SizedBox(height: context.echoSpacing.xs),
                for (final source in const <String>[
                  'netease',
                  'kuwo',
                  'joox',
                  'bilibili',
                ])
                  EchoActionRow(
                    icon: AppIcons.headphones,
                    title: source,
                    selected:
                        searchMode == ExploreSearchMode.remote &&
                        remoteSource == source,
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _setRemoteSource(source);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocalResults(
    AsyncValue<SearchResult>? localSearchAsync, {
    required bool loadFailed,
  }) {
    if (localSearchAsync == null) {
      return _withBottomObstruction(
        const EchoEmptyState(
          title: '音乐库暂无匹配歌曲',
          description: '尝试更短的关键词，或切换到远程搜索。',
          icon: AppIcons.fileSearch,
        ),
      );
    }
    return localSearchAsync.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      data: (result) {
        if (result.songs.isEmpty) {
          if (loadFailed) {
            return _withBottomObstruction(
              EchoErrorState(
                title: '音乐库搜索失败',
                description: '请检查网络或当前线路后重试。',
                actionLabel: '重试',
                onAction: () => ref.invalidate(searchProvider(_query)),
              ),
            );
          }
          return _withBottomObstruction(
            const EchoEmptyState(
              title: '音乐库暂无匹配歌曲',
              description: '尝试更短的关键词，或切换到远程搜索。',
              icon: AppIcons.fileSearch,
            ),
          );
        }
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                context.echoPageHorizontalPadding,
                context.echoSpacing.xs,
                context.echoPageHorizontalPadding,
                context.echoSpacing.xxl + context.echoShellBottomObstruction,
              ),
              itemCount: result.songs.length,
              itemBuilder: (context, index) {
                final song = result.songs[index];
                return ExploreLibrarySongRow(
                  song: song,
                  onPressed: () {
                    ref
                        .read(playerProvider.notifier)
                        .playQueue(result.songs, startIndex: index);
                  },
                );
              },
            ),
          ),
        );
      },
      loading: () =>
          _withBottomObstruction(const ExploreResultsLoading(count: 5)),
      error: (error, stackTrace) => _withBottomObstruction(
        EchoErrorState(
          title: '音乐库搜索失败',
          description: '请检查网络或当前线路后重试。',
          actionLabel: '重试',
          onAction: () => ref.invalidate(searchProvider(_query)),
        ),
      ),
    );
  }

  Widget _buildRemoteResults(ExploreRemoteState remoteState) {
    if (remoteState.songs.isEmpty &&
        remoteState.isLoading &&
        remoteState.error == null) {
      return _withBottomObstruction(const ExploreResultsLoading());
    }
    if (remoteState.songs.isEmpty &&
        !remoteState.isLoading &&
        remoteState.error == null) {
      return _withBottomObstruction(
        const EchoEmptyState(
          title: '远程源暂无匹配歌曲',
          description: '尝试更换关键词、搜索类型或远程来源。',
          icon: AppIcons.cloudOff,
        ),
      );
    }

    final hasFooter = remoteState.isLoading || remoteState.error != null;
    final itemCount = remoteState.songs.length + (hasFooter ? 1 : 0);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: <Widget>[
            if (remoteState.songs.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xs,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xs,
                ),
                child: EchoSectionHeader(
                  title: '远程结果',
                  description:
                      '${remoteState.songs.length} 首 · ${remoteState.source}',
                  actionLabel: '下载本页',
                  onAction: _isBatchDownloading ? null : _downloadAllOnPage,
                ),
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(
                  context.echoPageHorizontalPadding,
                  0,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xxl + context.echoShellBottomObstruction,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index >= remoteState.songs.length) {
                    return ExplorePaginationState(
                      error: remoteState.error,
                      loading: remoteState.isLoading,
                      onRetry: () {
                        ref
                            .read(exploreRemoteSearchProvider.notifier)
                            .loadNextPage();
                      },
                    );
                  }

                  final song = remoteState.songs[index];
                  final downloadKey = _previewDownloadKey(song);
                  final isResolving = _resolvingSongId == song.id;
                  final isSelected = _selectedSongIds.contains(song.id);
                  return ExploreRemoteSongRow(
                    song: song,
                    selected: isSelected,
                    selectionMode: _isSelectionMode,
                    resolving: isResolving,
                    downloadState: _submittingDownloadKeys.contains(downloadKey)
                        ? ExploreRemoteDownloadState.submitting
                        : _queuedDownloadKeys.contains(downloadKey)
                        ? ExploreRemoteDownloadState.queued
                        : ExploreRemoteDownloadState.idle,
                    onPressed: _isSelectionMode
                        ? () => _toggleSelection(song.id)
                        : () => _playPreview(song),
                    onLongPress: () {
                      setState(() => _selectedSongIds.add(song.id));
                    },
                    onToggleSelected: () => _toggleSelection(song.id),
                    onMorePressed: () => _showPreviewActions(song),
                    onDownload: () => _enqueuePreview(song),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _withBottomObstruction(Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.echoShellBottomObstruction),
      child: child,
    );
  }

  void _toggleSelection(String songId) {
    setState(() {
      if (_selectedSongIds.contains(songId)) {
        _selectedSongIds.remove(songId);
      } else {
        _selectedSongIds.add(songId);
      }
    });
  }
}

String _previewDownloadKey(Song song) {
  final source = song.previewSource?.trim() ?? '';
  final trackId = song.previewTrackId?.trim() ?? '';
  return source.isNotEmpty && trackId.isNotEmpty ? '$source:$trackId' : song.id;
}
