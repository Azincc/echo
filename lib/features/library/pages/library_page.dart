import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/playlist.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../../widgets/main_scaffold.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import 'album_list_page.dart';
import 'artist_list_page.dart';
import 'playlist_detail_page.dart';
import 'song_list_page.dart';
import 'starred_page.dart';
import '../utils/library_sorting.dart';
import '../widgets/playlist_manage_dialogs.dart';
import '../widgets/playlist_options_sheet.dart';

/// 我的页面 - Tab 2
class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  PlaylistSortOption _playlistSortOption = PlaylistSortOption.defaultOrder;

  Future<void> _createPlaylist(BuildContext context, WidgetRef ref) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final formResult = await showPlaylistFormDialog(
      context: context,
      title: '新建歌单',
      confirmText: '创建',
    );
    if (formResult == null) return;

    try {
      await ref.read(ensureActiveAddressProvider.future);
      final created = await repository.createPlaylist(name: formResult.name);
      if (created == null) {
        NetworkErrorNotifier.show('创建歌单失败');
        return;
      }

      if (formResult.comment.isNotEmpty || formResult.isPublic) {
        await repository.updatePlaylist(
          playlistId: created.id,
          comment: formResult.comment,
          public: formResult.isPublic,
        );
        ref.invalidate(playlistDetailProvider(created.id));
      }

      ref.invalidate(playlistsProvider);
      if (context.mounted) {
        ToastNotifier.show(
          '已创建歌单「${formResult.name}」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，创建失败');
    }
  }

  Future<void> _editPlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final formResult = await showPlaylistFormDialog(
      context: context,
      title: '修改歌单',
      confirmText: '保存',
      initialName: playlist.name,
      initialComment: playlist.comment ?? '',
      initialPublic: playlist.public,
    );
    if (formResult == null) return;

    final currentComment = (playlist.comment ?? '').trim();
    if (formResult.name == playlist.name &&
        formResult.comment == currentComment &&
        formResult.isPublic == playlist.public) {
      return;
    }

    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.updatePlaylist(
        playlistId: playlist.id,
        name: formResult.name,
        comment: formResult.comment,
        public: formResult.isPublic,
      );
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlist.id));
      if (context.mounted) {
        ToastNotifier.show(
          '已更新歌单「${formResult.name}」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，修改失败');
    }
  }

  Future<void> _deletePlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final confirmed = await showDeletePlaylistConfirmDialog(
      context: context,
      playlistName: playlist.name,
    );
    if (!confirmed) return;

    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.deletePlaylist(playlist.id);
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlist.id));
      if (context.mounted) {
        ToastNotifier.show(
          '已删除歌单「${playlist.name}」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，删除失败');
    }
  }

  Future<void> _onPlaylistMenuSelected(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
    PlaylistOptionsAction action,
  ) async {
    switch (action) {
      case PlaylistOptionsAction.download:
        await _downloadPlaylist(context, ref, playlist);
        return;
      case PlaylistOptionsAction.addToQueue:
        await _addPlaylistToQueue(context, ref, playlist);
        return;
      case PlaylistOptionsAction.edit:
        await _editPlaylist(context, ref, playlist);
        return;
      case PlaylistOptionsAction.delete:
        await _deletePlaylist(context, ref, playlist);
        return;
    }
  }

  Future<List<Song>?> _loadPlaylistSongs(
    WidgetRef ref,
    Playlist playlist,
  ) async {
    if (playlist.songCount <= 0) {
      NetworkErrorNotifier.show('歌单暂无可用歌曲');
      return null;
    }

    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return null;
    }

    try {
      await ref.read(ensureActiveAddressProvider.future);
      final detail = await repository.getPlaylist(playlist.id);
      final songs = detail?.songs ?? const <Song>[];
      if (songs.isEmpty) {
        NetworkErrorNotifier.show('歌单暂无可用歌曲');
        return null;
      }
      return songs;
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，歌单加载失败');
      return null;
    }
  }

  Future<void> _downloadPlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final libraryId = ref.read(authStateProvider).currentLibrary?.id ?? '';
    if (libraryId.isEmpty) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final songs = await _loadPlaylistSongs(ref, playlist);
    if (songs == null || songs.isEmpty) return;

    await ref
        .read(downloadServiceProvider)
        .enqueueBatch(songs, libraryId: libraryId);
    if (context.mounted) {
      ToastNotifier.show(
        '已添加 ${songs.length} 首歌曲到下载队列',
        kind: EchoMessageKind.success,
      );
    }
  }

  Future<void> _addPlaylistToQueue(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final songs = await _loadPlaylistSongs(ref, playlist);
    if (songs == null || songs.isEmpty) return;

    ref.read(playerProvider.notifier).addAllToQueue(songs);
    if (context.mounted) {
      ToastNotifier.show(
        '已添加 ${songs.length} 首到播放列表',
        kind: EchoMessageKind.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final playlistsLoadFailed = ref.watch(playlistsLoadFailedProvider);
    final starredAsync = ref.watch(starredProvider);
    final starredLoadFailed = ref.watch(starredLoadFailedProvider);
    final hasActiveLibrary = ref.watch(
      authStateProvider.select((s) => (s.currentLibrary?.id ?? '').isNotEmpty),
    );

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'library_page',
      shouldRetry: (ref) =>
          playlistsLoadFailed ||
          starredLoadFailed ||
          playlistsAsync.hasError ||
          starredAsync.hasError,
      onRetry: (ref) {
        ref.invalidate(playlistsProvider);
        ref.invalidate(starredProvider);
      },
      child: EchoScaffold(
        topBar: EchoTopBar(
          title: '资料库',
          subtitle: '收藏、歌单与完整曲库',
          leading: shouldShowPageDrawerTrigger(context)
              ? EchoIconButton(
                  icon: AppIcons.menu,
                  label: '打开应用菜单',
                  onPressed: openEchoAppDrawer,
                )
              : null,
        ),
        body: EchoRefreshView(
          onRefresh: () async {
            ref.invalidate(playlistsProvider);
            ref.invalidate(starredProvider);
            await Future.wait<void>(<Future<void>>[
              ref.read(playlistsProvider.future).then((_) {}),
              ref.read(starredProvider.future).then((_) {}),
            ]);
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  context.echoSpacing.md,
                  context.echoSpacing.sm,
                  context.echoSpacing.md,
                  context.echoSpacing.xxl + context.echoShellBottomObstruction,
                ),
                children: <Widget>[
                  const EchoSectionHeader(title: '收藏'),
                  starredAsync.when(
                    data: (starred) => Column(
                      children: <Widget>[
                        _LibraryDestinationRow(
                          icon: AppIcons.heart,
                          title: '收藏歌曲',
                          detail: '${starred.songs.length} 首',
                          onPressed: () => _push(
                            context,
                            const StarredPage(initialTab: StarredTab.songs),
                          ),
                        ),
                        _LibraryDestinationRow(
                          icon: AppIcons.album,
                          title: '收藏专辑',
                          detail: '${starred.albums.length} 张',
                          onPressed: () => _push(
                            context,
                            const StarredPage(initialTab: StarredTab.albums),
                          ),
                        ),
                        _LibraryDestinationRow(
                          icon: AppIcons.profile,
                          title: '收藏歌手',
                          detail: '${starred.artists.length} 位',
                          onPressed: () => _push(
                            context,
                            const StarredPage(initialTab: StarredTab.artists),
                          ),
                        ),
                      ],
                    ),
                    loading: () => const _LibraryRowsSkeleton(count: 3),
                    error: (_, _) => EchoErrorState(
                      title: '收藏加载失败',
                      description: '无法读取收藏内容，请检查网络后重试。',
                      actionLabel: '重试',
                      onAction: () => ref.invalidate(starredProvider),
                      padding: const EdgeInsets.all(24),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.lg),
                  EchoSectionHeader(
                    title: '我的歌单',
                    actionLabel: _playlistSortOption.label,
                    onAction: () => _showPlaylistSortSheet(context),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: EchoButton.ghost(
                      label: '新建歌单',
                      leadingIcon: AppIcons.add,
                      onPressed: () => _createPlaylist(context, ref),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  playlistsAsync.when(
                    data: (playlists) {
                      if (playlists.isEmpty) {
                        return EchoEmptyState(
                          title: playlistsLoadFailed ? '歌单暂时不可用' : '还没有歌单',
                          description: playlistsLoadFailed
                              ? '网络连接恢复后重试。'
                              : '创建歌单，把想连续听的音乐整理在一起。',
                          icon: playlistsLoadFailed
                              ? AppIcons.cloudOff
                              : AppIcons.playlist,
                          actionLabel: playlistsLoadFailed ? '重试' : '新建歌单',
                          onAction: playlistsLoadFailed
                              ? () => ref.invalidate(playlistsProvider)
                              : () => _createPlaylist(context, ref),
                          padding: const EdgeInsets.all(24),
                        );
                      }

                      final sortedPlaylists = sortPlaylists(
                        playlists,
                        _playlistSortOption,
                      );
                      return Column(
                        children: <Widget>[
                          for (final playlist in sortedPlaylists)
                            _PlaylistRow(
                              playlist: playlist,
                              onPressed: () => _push(
                                context,
                                PlaylistDetailPage(playlistId: playlist.id),
                              ),
                              onMore: () async {
                                final action = await showPlaylistOptionsSheet(
                                  context: context,
                                  playlist: playlist,
                                  canDownload: hasActiveLibrary,
                                  hasSongs: playlist.songCount > 0,
                                );
                                if (action == null || !context.mounted) return;
                                await _onPlaylistMenuSelected(
                                  context,
                                  ref,
                                  playlist,
                                  action,
                                );
                              },
                            ),
                        ],
                      );
                    },
                    loading: () => const _LibraryRowsSkeleton(count: 3),
                    error: (_, _) => EchoErrorState(
                      title: '歌单加载失败',
                      description: '无法读取歌单，请检查网络后重试。',
                      actionLabel: '重试',
                      onAction: () => ref.invalidate(playlistsProvider),
                      padding: const EdgeInsets.all(24),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xl),
                  const EchoSectionHeader(title: '浏览完整曲库'),
                  _LibraryDestinationRow(
                    icon: AppIcons.music,
                    title: '全部歌曲',
                    detail: '按标题、歌手或专辑排序',
                    onPressed: () => _push(context, const SongListPage()),
                  ),
                  _LibraryDestinationRow(
                    icon: AppIcons.albumOutline,
                    title: '按专辑浏览',
                    detail: '查看封面与发行信息',
                    onPressed: () => _push(context, const AlbumListPage()),
                  ),
                  _LibraryDestinationRow(
                    icon: AppIcons.profile,
                    title: '按歌手浏览',
                    detail: '从歌手进入专辑与热门曲目',
                    onPressed: () => _push(context, const ArtistListPage()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget page) {
    Navigator.of(
      context,
    ).push<void>(EchoPageRoute<void>(context: context, builder: (_) => page));
  }

  Future<void> _showPlaylistSortSheet(BuildContext context) async {
    final selected = await showEchoBottomSheet<PlaylistSortOption>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '歌单排序',
        subtitle: '当前：${_playlistSortOption.label}',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final option in selectablePlaylistSortOptions)
              EchoActionRow(
                icon: option == _playlistSortOption
                    ? AppIcons.radioSelected
                    : AppIcons.radio,
                title: option.label,
                selected: option == _playlistSortOption,
                onPressed: () => Navigator.of(sheetContext).pop(option),
              ),
          ],
        ),
      ),
    );
    if (selected == null || selected == _playlistSortOption || !mounted) {
      return;
    }
    setState(() => _playlistSortOption = selected);
  }
}

class _LibraryDestinationRow extends StatelessWidget {
  const _LibraryDestinationRow({
    required this.icon,
    required this.title,
    required this.detail,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String detail;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: '$title，$detail',
      onPressed: onPressed,
      minimumSize: const Size(double.infinity, 72),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.echoSpacing.xs,
          vertical: context.echoSpacing.xs,
        ),
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(icon, size: 24, color: context.echoColors.accent),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    detail,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Icon(
              AppIcons.chevronRight,
              size: 20,
              color: context.echoColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  const _PlaylistRow({
    required this.playlist,
    required this.onPressed,
    required this.onMore,
  });

  final Playlist playlist;
  final VoidCallback onPressed;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: EchoPressable(
            semanticLabel: '${playlist.name}，${playlist.songCount} 首',
            onPressed: onPressed,
            minimumSize: const Size(double.infinity, 72),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.echoSpacing.xs,
                vertical: context.echoSpacing.xs,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox.square(
                    dimension: context.echoInteraction.minimumTouchTarget,
                    child: Center(
                      child: Icon(
                        AppIcons.playlist,
                        size: 24,
                        color: context.echoColors.accent,
                      ),
                    ),
                  ),
                  SizedBox(width: context.echoSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          playlist.name,
                          style: context.echoTypography.title,
                        ),
                        SizedBox(height: context.echoSpacing.xxs),
                        Text(
                          '${playlist.songCount} 首 · ${playlist.durationString}',
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
        EchoIconButton(
          icon: AppIcons.more,
          label: '${playlist.name} 的歌单操作',
          onPressed: onMore,
        ),
      ],
    );
  }
}

class _LibraryRowsSkeleton extends StatelessWidget {
  const _LibraryRowsSkeleton({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
          child: Row(
            children: <Widget>[
              const EchoSkeleton.circle(size: 48),
              SizedBox(width: context.echoSpacing.sm),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EchoSkeleton.line(width: 180),
                    SizedBox(height: 8),
                    EchoSkeleton.line(width: 96, height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
