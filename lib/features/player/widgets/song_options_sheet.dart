import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../../widgets/echo_artwork.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';
import '../../library/pages/song_metadata_edit_page.dart';

class SongOptionsExtraAction {
  const SongOptionsExtraAction({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final bool isDestructive;
  final FutureOr<void> Function() onPressed;
}

enum SongOptionsSheetMode { full, offlineOnly }

Future<void> showSongOptionsSheet({
  required BuildContext context,
  required Song song,
  bool useRootNavigator = true,
  List<SongOptionsExtraAction> extraActions = const <SongOptionsExtraAction>[],
  SongOptionsSheetMode mode = SongOptionsSheetMode.full,
  EchoMediaVisuals? mediaVisuals,
}) async {
  await showEchoBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    builder: (_) {
      final sheet = _SongOptionsSheet(
        hostContext: context,
        song: song,
        extraActions: extraActions,
        mode: mode,
      );
      if (mediaVisuals == null) return sheet;
      return EchoMediaColorScope(
        visuals: mediaVisuals,
        role: EchoMediaSurfaceRole.panel,
        child: sheet,
      );
    },
  );
}

class _SongOptionsSheet extends ConsumerWidget {
  const _SongOptionsSheet({
    required this.hostContext,
    required this.song,
    required this.extraActions,
    required this.mode,
  });

  static const _logTag = 'METADATA_EDIT';

  final BuildContext hostContext;
  final Song song;
  final List<SongOptionsExtraAction> extraActions;
  final SongOptionsSheetMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSongId = ref.watch(
      playerProvider.select((state) => state.currentSong?.id),
    );
    final isCurrentSong = currentSongId != null && currentSongId == song.id;
    final artistName = song.artist?.trim().isNotEmpty == true
        ? song.artist!.trim()
        : '未知歌手';
    final albumName = song.album?.trim().isNotEmpty == true
        ? song.album!.trim()
        : '未知专辑';
    final canOpenArtist = song.artistId?.trim().isNotEmpty == true;
    final canOpenAlbum = song.albumId?.trim().isNotEmpty == true;
    final libraryId = ref.watch(
      authStateProvider.select((state) => state.currentLibrary?.id ?? ''),
    );
    final canDownload = libraryId.isNotEmpty;
    final embedConfig = ref.watch(activeEmbedServiceConfigProvider);
    final canDownloadPreview =
        canDownload && embedConfig.isEnabledAndConfigured;
    final canEditMetadata =
        embedConfig.isEnabledAndConfigured &&
        !song.isPreview &&
        (song.path?.trim().isNotEmpty ?? false);

    final actions = <Widget>[];
    if (mode == SongOptionsSheetMode.offlineOnly) {
      for (final action in extraActions) {
        actions.add(
          _SongOptionRow(
            icon: action.icon,
            title: action.title,
            destructive: action.isDestructive,
            onPressed: () => unawaited(
              _closeAndRun(context, () async => action.onPressed()),
            ),
          ),
        );
      }
      if (extraActions.isEmpty) {
        actions.add(
          _SongOptionRow(
            icon: AppIcons.info,
            title: canDownload ? '暂无可用操作' : '当前不可操作',
            onPressed: null,
          ),
        );
      }
    } else if (song.isPreview) {
      final previewSource = song.previewSource?.trim();
      actions.addAll(<Widget>[
        if (!isCurrentSong)
          _SongOptionRow(
            icon: AppIcons.queueAdd,
            title: '下一曲播放',
            onPressed: () => unawaited(
              _closeAndRun(context, () async {
                await ref.read(playerProvider.notifier).playNext(song);
                _showMessage('已添加试听歌曲到下一曲');
              }),
            ),
          ),
        _SongOptionRow(
          icon: AppIcons.downloadOutline,
          title: '添加到离线下载队列',
          onPressed: !canDownloadPreview
              ? null
              : () => unawaited(
                  _closeAndRun(context, () async {
                    try {
                      await ref
                          .read(offlineDownloadServiceProvider)
                          .enqueuePreviewSong(
                            song: song,
                            libraryId: libraryId,
                            config: embedConfig,
                          );
                      _showMessage('已添加「${song.title}」到离线下载队列');
                    } catch (error) {
                      NetworkErrorNotifier.show('添加试听歌曲失败: $error');
                    }
                  }),
                ),
        ),
        _SongOptionRow(
          icon: AppIcons.cloud,
          title: previewSource == null || previewSource.isEmpty
              ? '远程试听'
              : '远程试听 · $previewSource',
          onPressed: null,
        ),
      ]);
    } else {
      actions.addAll(<Widget>[
        _SongOptionRow(
          icon: song.starred ? AppIcons.heart : AppIcons.heartOutline,
          title: song.starred ? '取消红心' : '红心',
          selected: song.starred,
          onPressed: () => unawaited(
            _closeAndRun(context, () async {
              final newStarred = await ref
                  .read(playerProvider.notifier)
                  .toggleSongFavorite(song);
              if (newStarred == null) {
                NetworkErrorNotifier.show('操作失败');
                return;
              }
              _showMessage(newStarred ? '已添加红心' : '已取消红心');
            }),
          ),
        ),
        _SongOptionRow(
          icon: AppIcons.playlistAdd,
          title: '添加到歌单',
          onPressed: () => unawaited(
            _closeAndRun(context, () async {
              if (!hostContext.mounted) return;
              await showEchoBottomSheet<void>(
                context: hostContext,
                useRootNavigator: true,
                isScrollControlled: true,
                builder: (_) =>
                    _AddToPlaylistSheet(hostContext: hostContext, song: song),
              );
            }),
          ),
        ),
        _SongOptionRow(
          icon: AppIcons.downloadOutline,
          title: '下载',
          onPressed: !canDownload
              ? null
              : () => unawaited(
                  _closeAndRun(context, () async {
                    await ref
                        .read(downloadServiceProvider)
                        .enqueue(song, libraryId: libraryId);
                    _showMessage('已添加「${song.title}」到下载队列');
                  }),
                ),
        ),
        if (!isCurrentSong)
          _SongOptionRow(
            icon: AppIcons.queueAdd,
            title: '下一曲播放',
            onPressed: () => unawaited(
              _closeAndRun(context, () async {
                await ref.read(playerProvider.notifier).playNext(song);
                _showMessage('已添加到下一曲');
              }),
            ),
          ),
        _SongOptionRow(
          icon: AppIcons.profile,
          title: '歌手：$artistName',
          onPressed: !canOpenArtist
              ? null
              : () => unawaited(
                  _closeAndRun(context, () async {
                    await Navigator.of(hostContext).push<void>(
                      EchoPageRoute<void>(
                        context: hostContext,
                        builder: (_) =>
                            ArtistDetailPage(artistId: song.artistId!),
                      ),
                    );
                  }),
                ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: artistName));
            ToastNotifier.show('已复制歌手: $artistName');
          },
        ),
        _SongOptionRow(
          icon: AppIcons.albumOutline,
          title: '专辑：$albumName',
          onPressed: !canOpenAlbum
              ? null
              : () => unawaited(
                  _closeAndRun(context, () async {
                    await Navigator.of(hostContext).push<void>(
                      EchoPageRoute<void>(
                        context: hostContext,
                        builder: (_) => AlbumDetailPage(albumId: song.albumId!),
                      ),
                    );
                  }),
                ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: albumName));
            ToastNotifier.show('已复制专辑: $albumName');
          },
        ),
        if (canEditMetadata)
          _SongOptionRow(
            icon: AppIcons.editNote,
            title: '修改元数据',
            onPressed: () {
              Logger.infoWithTag(
                _logTag,
                'enter editor from options songId=${song.id} '
                'title="${song.title.trim()}" '
                'artist="${(song.artist ?? '').trim()}" '
                'album="${(song.album ?? '').trim()}" '
                'path="${(song.path ?? '').trim()}" '
                'albumId="${(song.albumId ?? '').trim()}" '
                'artistId="${(song.artistId ?? '').trim()}"',
              );
              unawaited(
                _closeAndRun(context, () async {
                  if (!hostContext.mounted) return;
                  await Navigator.of(hostContext).push<bool>(
                    EchoPageRoute<bool>(
                      context: hostContext,
                      builder: (_) => SongMetadataEditPage(song: song),
                    ),
                  );
                }),
              );
            },
          ),
      ]);
    }

    if (mode != SongOptionsSheetMode.offlineOnly && extraActions.isNotEmpty) {
      actions.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
          child: const EchoDivider(),
        ),
      );
      for (final action in extraActions) {
        actions.add(
          _SongOptionRow(
            icon: action.icon,
            title: action.title,
            destructive: action.isDestructive,
            onPressed: () => unawaited(
              _closeAndRun(context, () async => action.onPressed()),
            ),
          ),
        );
      }
    }

    return EchoBottomSheet(
      title: mode == SongOptionsSheetMode.offlineOnly
          ? '离线曲目操作'
          : song.isPreview
          ? '试听歌曲操作'
          : '歌曲操作',
      padding: EdgeInsets.fromLTRB(
        context.echoSpacing.md,
        0,
        context.echoSpacing.md,
        context.echoSpacing.md,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.74,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _SongSummary(
                song: song,
                artistName: artistName,
                albumName: albumName,
                onCopyTitle: () {
                  Clipboard.setData(ClipboardData(text: song.title));
                  ToastNotifier.show('已复制歌曲名: ${song.title}');
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
                child: const EchoDivider(),
              ),
              ...actions,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _closeAndRun(
    BuildContext sheetContext,
    Future<void> Function() action,
  ) async {
    Navigator.of(sheetContext).pop();
    await Future<void>.delayed(Duration.zero);
    if (!hostContext.mounted) return;
    await action();
  }

  void _showMessage(String message) {
    if (!hostContext.mounted) return;
    showEchoMessage(hostContext, message);
  }
}

class _SongSummary extends StatelessWidget {
  const _SongSummary({
    required this.song,
    required this.artistName,
    required this.albumName,
    required this.onCopyTitle,
  });

  final Song song;
  final String artistName;
  final String albumName;
  final VoidCallback onCopyTitle;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: '${song.title}，$artistName，$albumName，长按复制歌曲名',
      onLongPress: onCopyTitle,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: EchoArtwork(
                coverArtId: song.artworkReference,
                semanticLabel: '${song.title} 封面',
                size: context.echoInteraction.minimumTouchTarget,
                requestSize: 192,
                borderRadius: context.echoRadii.detail,
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    song.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.echoTypography.title,
                  ),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    '$artistName · $albumName',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.echoTypography.metadata,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SongOptionRow extends StatelessWidget {
  const _SongOptionRow({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.onLongPress,
    this.destructive = false,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool destructive;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final enabled = onPressed != null || onLongPress != null;
    final accent = destructive ? colors.error : colors.accent;
    final foreground = enabled
        ? destructive
              ? colors.error
              : colors.ink
        : colors.onDisabled;

    return EchoPressable(
      semanticLabel: <String>[
        title,
        if (selected) '已选中',
        if (!enabled) '不可用',
      ].join('，'),
      selected: selected,
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: Size(double.infinity, context.echoInteraction.songRowHeight),
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.1)
              : enabled
              ? Colors.transparent
              : colors.raised.withValues(alpha: 0.55),
          borderRadius: context.echoRadii.control,
        ),
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
                    icon,
                    size: 22,
                    color: enabled ? accent : colors.onDisabled,
                  ),
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.echoTypography.title.copyWith(
                    color: foreground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddToPlaylistSheet extends ConsumerWidget {
  const _AddToPlaylistSheet({required this.hostContext, required this.song});

  final BuildContext hostContext;
  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final loadFailed = ref.watch(playlistsLoadFailedProvider);

    return EchoBottomSheet(
      title: '添加到歌单',
      subtitle: song.title,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.62,
        ),
        child: playlistsAsync.when(
          data: (playlists) {
            if (playlists.isEmpty) {
              return EchoEmptyState(
                title: loadFailed ? '歌单加载失败' : '暂无歌单',
                description: loadFailed
                    ? '请检查网络或服务器状态后重试。'
                    : '创建歌单后，即可将这首歌曲加入收藏。',
                icon: loadFailed ? AppIcons.cloudOff : AppIcons.playlist,
                actionLabel: loadFailed ? '重试' : null,
                onAction: loadFailed
                    ? () => ref.invalidate(playlistsProvider)
                    : null,
                padding: EdgeInsets.all(context.echoSpacing.lg),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: playlists.length,
              separatorBuilder: (context, index) => EchoDivider(
                inset:
                    context.echoInteraction.minimumTouchTarget +
                    context.echoSpacing.sm,
              ),
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return _PlaylistRow(
                  name: playlist.name,
                  songCount: playlist.songCount,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final repository = ref.read(playlistRepositoryProvider);
                    if (repository == null) {
                      NetworkErrorNotifier.show('未选择音乐库');
                      return;
                    }

                    try {
                      await ref.read(ensureActiveAddressProvider.future);
                      await repository.updatePlaylist(
                        playlistId: playlist.id,
                        songIdsToAdd: <String>[song.id],
                      );
                      ref.invalidate(playlistsProvider);
                      ref.invalidate(playlistDetailProvider(playlist.id));
                      if (hostContext.mounted) {
                        showEchoMessage(
                          hostContext,
                          '已添加到歌单「${playlist.name}」',
                        );
                      }
                    } catch (_) {
                      NetworkErrorNotifier.show('网络异常，添加失败');
                    }
                  },
                );
              },
            );
          },
          loading: () => const _PlaylistLoading(),
          error: (error, stackTrace) => EchoErrorState(
            title: '歌单加载失败',
            description: '请检查网络或服务器状态后重试。',
            actionLabel: '重试',
            onAction: () => ref.invalidate(playlistsProvider),
            padding: EdgeInsets.all(context.echoSpacing.lg),
          ),
        ),
      ),
    );
  }
}

class _PlaylistRow extends StatelessWidget {
  const _PlaylistRow({
    required this.name,
    required this.songCount,
    required this.onPressed,
  });

  final String name;
  final int songCount;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: '$name，$songCount 首歌曲',
      onPressed: () => unawaited(onPressed()),
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(
                  AppIcons.playlist,
                  size: 22,
                  color: context.echoColors.accent,
                ),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.echoTypography.title,
                  ),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text('$songCount 首', style: context.echoTypography.metadata),
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

class _PlaylistLoading extends StatelessWidget {
  const _PlaylistLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var index = 0; index < 3; index += 1) ...<Widget>[
            Row(
              children: <Widget>[
                const EchoSkeleton.circle(size: 48),
                SizedBox(width: context.echoSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      EchoSkeleton.line(width: 180, height: 16),
                      SizedBox(height: 8),
                      EchoSkeleton.line(width: 72, height: 12),
                    ],
                  ),
                ),
              ],
            ),
            if (index < 2) SizedBox(height: context.echoSpacing.sm),
          ],
        ],
      ),
    );
  }
}
