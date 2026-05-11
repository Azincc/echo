import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/network_error_notifier.dart';
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
import '../../../widgets/music_chrome.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import 'album_list_page.dart';
import 'artist_list_page.dart';
import 'playlist_detail_page.dart';
import 'song_list_page.dart';
import 'starred_page.dart';
import '../utils/library_sorting.dart';
import '../widgets/playlist_manage_dialogs.dart';
import '../../../widgets/skeleton_templates.dart';
import '../widgets/playlist_options_sheet.dart';

/// 我的页面 - Tab 2
class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  PlaylistSortOption _playlistSortOption = PlaylistSortOption.defaultOrder;

  Widget _buildLibraryRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final resolvedIconColor = iconColor ?? theme.colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: resolvedIconColor.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.2 : 0.12,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: resolvedIconColor, size: 23),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null && subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 12), trailing],
            ],
          ),
        ),
      ),
    );
  }

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已创建歌单「${formResult.name}」')));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已更新歌单「${formResult.name}」')));
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已删除歌单「${playlist.name}」')));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已添加 ${songs.length} 首歌曲到下载队列')));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已添加 ${songs.length} 首到播放列表')));
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
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: MusicChrome.maxContentWidth,
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                children: [
                  MusicPageHeader(
                    padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                    title: '资料库',
                    subtitle: '收藏、歌单和全部音乐都在这里',
                    leading: MusicIconButton(
                      icon: AppIcons.menu,
                      tooltip: '菜单',
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const MusicSectionHeader(title: '收藏'),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.favorite,
                    title: '收藏歌曲',
                    trailing: starredAsync.when(
                      data: (starred) => Text('${starred.songs.length} 首'),
                      loading: () => const SizedBox.shrink(),
                      error: (error, stack) => const SizedBox.shrink(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StarredPage(initialTab: StarredTab.songs),
                        ),
                      );
                    },
                  ),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.album,
                    title: '收藏专辑',
                    trailing: starredAsync.when(
                      data: (starred) => Text('${starred.albums.length} 张'),
                      loading: () => const SizedBox.shrink(),
                      error: (error, stack) => const SizedBox.shrink(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StarredPage(initialTab: StarredTab.albums),
                        ),
                      );
                    },
                  ),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.person,
                    title: '收藏歌手',
                    trailing: starredAsync.when(
                      data: (starred) => Text('${starred.artists.length} 位'),
                      loading: () => const SizedBox.shrink(),
                      error: (error, stack) => const SizedBox.shrink(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StarredPage(initialTab: StarredTab.artists),
                        ),
                      );
                    },
                  ),
                  MusicSectionHeader(
                    title: '我的歌单',
                    subtitle: '自建和同步的播放列表',
                    actions: [
                      PopupMenuButton<PlaylistSortOption>(
                        tooltip: '歌单排序：${_playlistSortOption.label}',
                        icon: const Icon(AppIcons.sort),
                        initialValue: _playlistSortOption,
                        onSelected: (option) {
                          if (option == _playlistSortOption) return;
                          setState(() {
                            _playlistSortOption = option;
                          });
                        },
                        itemBuilder: (context) => selectablePlaylistSortOptions
                            .map(
                              (option) =>
                                  CheckedPopupMenuItem<PlaylistSortOption>(
                                    value: option,
                                    checked: option == _playlistSortOption,
                                    child: Text(option.label),
                                  ),
                            )
                            .toList(),
                      ),
                      MusicIconButton(
                        onPressed: () => _createPlaylist(context, ref),
                        icon: AppIcons.add,
                        tooltip: '新建歌单',
                      ),
                    ],
                  ),
                  playlistsAsync.when(
                    data: (playlists) {
                      if (playlists.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              playlistsLoadFailed ? '网络异常，歌单加载失败' : '暂无歌单',
                            ),
                          ),
                        );
                      }
                      final sortedPlaylists = sortPlaylists(
                        playlists,
                        _playlistSortOption,
                      );
                      return Column(
                        children: sortedPlaylists.map((playlist) {
                          return _buildLibraryRow(
                            context,
                            icon: AppIcons.queue_music_rounded,
                            title: playlist.name,
                            subtitle: '${playlist.songCount} 首',
                            trailing: IconButton(
                              tooltip: '歌单操作',
                              icon: const Icon(AppIcons.more_horiz),
                              onPressed: () async {
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylistDetailPage(
                                    playlistId: playlist.id,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                    loading: () =>
                        const ListTileSkeleton(count: 3, hasIcon: true),
                    error: (error, stack) => const Padding(
                      padding: EdgeInsets.all(24),
                      child: ErrorPlaceholder(message: '歌单加载失败，请检查网络后重试'),
                    ),
                  ),
                  const MusicSectionHeader(
                    title: '音乐库浏览',
                    subtitle: '按不同维度进入完整资料库',
                  ),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.music_note,
                    title: '全部歌曲',
                    trailing: const Icon(AppIcons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SongListPage(),
                        ),
                      );
                    },
                  ),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.album,
                    title: '按专辑浏览',
                    trailing: const Icon(AppIcons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlbumListPage(),
                        ),
                      );
                    },
                  ),
                  _buildLibraryRow(
                    context,
                    icon: AppIcons.person,
                    title: '按歌手浏览',
                    trailing: const Icon(AppIcons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArtistListPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
