import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/playlist.dart';

enum PlaylistOptionsAction { download, addToQueue, edit, delete }

Future<PlaylistOptionsAction?> showPlaylistOptionsSheet({
  required BuildContext context,
  required Playlist playlist,
  bool canDownload = true,
  bool hasSongs = true,
  bool useRootNavigator = true,
}) async {
  return showEchoBottomSheet<PlaylistOptionsAction>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
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
    return EchoBottomSheet(
      title: playlist.name,
      subtitle: '${playlist.songCount} 首 · ${playlist.durationString}',
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EchoActionRow(
              icon: AppIcons.downloadOutline,
              title: '下载歌单',
              subtitle: canDownload ? null : '请先选择音乐库',
              onPressed: hasSongs && canDownload
                  ? () => Navigator.of(
                      context,
                    ).pop(PlaylistOptionsAction.download)
                  : null,
            ),
            EchoActionRow(
              icon: AppIcons.queueAdd,
              title: '添加到播放列表',
              subtitle: hasSongs ? null : '歌单中暂无歌曲',
              onPressed: hasSongs
                  ? () => Navigator.of(
                      context,
                    ).pop(PlaylistOptionsAction.addToQueue)
                  : null,
            ),
            EchoActionRow(
              icon: AppIcons.edit,
              title: '修改歌单',
              onPressed: () =>
                  Navigator.of(context).pop(PlaylistOptionsAction.edit),
            ),
            EchoActionRow(
              icon: AppIcons.delete,
              title: '删除歌单',
              destructive: true,
              onPressed: () =>
                  Navigator.of(context).pop(PlaylistOptionsAction.delete),
            ),
          ],
        ),
      ),
    );
  }
}
