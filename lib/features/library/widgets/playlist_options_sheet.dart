import 'package:flutter/material.dart';

import '../../../data/models/playlist.dart';

enum PlaylistOptionsAction { download, addToQueue, edit, delete }

Future<PlaylistOptionsAction?> showPlaylistOptionsSheet({
  required BuildContext context,
  required Playlist playlist,
  bool canDownload = true,
  bool hasSongs = true,
  bool useRootNavigator = true,
}) async {
  return showModalBottomSheet<PlaylistOptionsAction>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _PlaylistOptionsSheet(
      playlist: playlist,
      canDownload: canDownload,
      hasSongs: hasSongs,
    ),
  );
}

class _PlaylistOptionsSheet extends StatelessWidget {
  final Playlist playlist;
  final bool canDownload;
  final bool hasSongs;

  const _PlaylistOptionsSheet({
    required this.playlist,
    required this.canDownload,
    required this.hasSongs,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                dense: true,
                title: Text(
                  playlist.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${playlist.songCount} 首 · ${playlist.durationString}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(height: 1),
              _buildActionTile(
                context: context,
                icon: Icons.download_outlined,
                title: '下载歌单',
                enabled: hasSongs && canDownload,
                onTap: () =>
                    Navigator.of(context).pop(PlaylistOptionsAction.download),
              ),
              _buildActionTile(
                context: context,
                icon: Icons.queue_music_outlined,
                title: '添加到播放列表',
                enabled: hasSongs,
                onTap: () =>
                    Navigator.of(context).pop(PlaylistOptionsAction.addToQueue),
              ),
              _buildActionTile(
                context: context,
                icon: Icons.edit_outlined,
                title: '修改歌单',
                onTap: () =>
                    Navigator.of(context).pop(PlaylistOptionsAction.edit),
              ),
              _buildActionTile(
                context: context,
                icon: Icons.delete_outline,
                title: '删除歌单',
                iconColor: Theme.of(context).colorScheme.error,
                textColor: Theme.of(context).colorScheme.error,
                onTap: () =>
                    Navigator.of(context).pop(PlaylistOptionsAction.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? iconColor,
    Color? textColor,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    final disabledColor = Theme.of(
      context,
    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

    return ListTile(
      enabled: enabled,
      leading: Icon(icon, color: enabled ? iconColor : disabledColor),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: enabled ? textColor : disabledColor),
      ),
      onTap: enabled && onTap != null ? onTap : null,
    );
  }
}
