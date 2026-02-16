import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/player_provider.dart';
import 'song_options_sheet.dart';

/// 播放队列底部弹窗
class PlayQueueSheet extends ConsumerWidget {
  const PlayQueueSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final queue = playerState.queue;
    final currentIndex = playerState.currentIndex;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // 拖动条
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // 标题栏
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '播放队列',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${queue.length} 首',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // 队列列表
              Expanded(
                child: queue.isEmpty
                    ? const Center(child: Text('队列为空'))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: queue.length,
                        itemBuilder: (context, index) {
                          final song = queue[index];
                          final isPlaying = index == currentIndex;
                          void openSongMenu() {
                            showSongOptionsSheet(
                              context: context,
                              song: song,
                              extraActions: [
                                SongOptionsExtraAction(
                                  icon: Icons.remove_circle_outline,
                                  title: '从队列移除',
                                  isDestructive: true,
                                  onPressed: () {
                                    ref
                                        .read(playerProvider.notifier)
                                        .removeFromQueue(index);
                                  },
                                ),
                              ],
                            );
                          }

                          return ListTile(
                            leading: isPlaying
                                ? Icon(
                                    Icons.play_arrow,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    child: Text('${index + 1}'),
                                  ),
                            title: Text(
                              song.title,
                              style: TextStyle(
                                color: isPlaying
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                                fontWeight: isPlaying ? FontWeight.bold : null,
                              ),
                            ),
                            subtitle: song.artist != null
                                ? Text(song.artist!)
                                : null,
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: openSongMenu,
                            ),
                            onTap: () {
                              ref
                                  .read(playerProvider.notifier)
                                  .skipToQueueItem(index);
                              Navigator.pop(context);
                            },
                            onLongPress: openSongMenu,
                          );
                        },
                      ),
              ),

              // 底部操作栏
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        ref.read(playerProvider.notifier).clearQueue();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear_all),
                      label: const Text('清空队列'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
