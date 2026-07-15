import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/song.dart';
import '../../../providers/palette_provider.dart';
import '../../../providers/player_provider.dart';
import 'song_options_sheet.dart';

Future<void> showPlayQueueSheet({
  required BuildContext context,
  bool useRootNavigator = true,
}) {
  return showEchoBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    builder: (_) => const PlayQueueSheet(),
  );
}

/// Playback queue bound to the production player provider.
class PlayQueueSheet extends ConsumerWidget {
  const PlayQueueSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueSnapshot = ref.watch(
      playerProvider.select(
        (state) => (
          currentSong: state.currentSong,
          queue: state.queue,
          currentIndex: state.currentIndex,
        ),
      ),
    );
    final visuals = ref.watch(resolvedCurrentSongMediaVisualsProvider);
    final playerState = PlayerState(
      currentSong: queueSnapshot.currentSong,
      queue: queueSnapshot.queue,
      currentIndex: queueSnapshot.currentIndex,
    );

    return PlayQueueSheetView(
      playerState: playerState,
      mediaVisuals: visuals,
      onSelect: (index) async {
        final player = ref.read(playerProvider.notifier);
        Navigator.of(context).pop();
        await Future<void>.delayed(Duration.zero);
        unawaited(player.skipToQueueItem(index));
      },
      onClear: () async {
        await ref.read(playerProvider.notifier).clearQueue();
        if (context.mounted) Navigator.of(context).pop();
      },
      onOpenSongActions: (rowContext, index, song) {
        return showSongOptionsSheet(
          context: rowContext,
          song: song,
          extraActions: <SongOptionsExtraAction>[
            SongOptionsExtraAction(
              icon: AppIcons.removeCircle,
              title: '从队列移除',
              isDestructive: true,
              onPressed: () {
                ref.read(playerProvider.notifier).removeFromQueue(index);
              },
            ),
          ],
        );
      },
    );
  }
}

typedef QueueSongAction =
    Future<void> Function(BuildContext context, int index, Song song);

/// Provider-free queue surface for deterministic gesture and a11y tests.
@visibleForTesting
class PlayQueueSheetView extends StatelessWidget {
  const PlayQueueSheetView({
    super.key,
    required this.playerState,
    required this.onSelect,
    required this.onClear,
    required this.onOpenSongActions,
    this.mediaVisuals,
    this.albumColor,
  });

  final PlayerState playerState;
  final EchoMediaVisuals? mediaVisuals;

  /// Compatibility seed for provider-free tests and older call sites.
  final Color? albumColor;
  final Future<void> Function(int index) onSelect;
  final Future<void> Function() onClear;
  final QueueSongAction onOpenSongActions;

  @override
  Widget build(BuildContext context) {
    final queue = playerState.queue;
    final currentIndex = playerState.currentIndex;
    final topRadius = BorderRadius.only(
      topLeft: context.echoRadii.scene.topLeft,
      topRight: context.echoRadii.scene.topRight,
    );
    final visuals =
        mediaVisuals ??
        EchoMediaVisuals.fallback(
          seed: albumColor ?? EchoColors.contentTintFallback,
        );

    return EchoMediaColorScope(
      visuals: visuals,
      role: EchoMediaSurfaceRole.panel,
      child: DraggableScrollableSheet(
        initialChildSize: 0.72,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Semantics(
            container: true,
            scopesRoute: true,
            namesRoute: true,
            explicitChildNodes: true,
            label: '播放队列',
            child: EchoSurface(
              level: EchoSurfaceLevel.modal,
              color: context.echoColors.surface,
              borderRadius: topRadius,
              clipBehavior: Clip.antiAlias,
              child: SafeArea(
                top: false,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: context.echoSpacing.xs),
                    Center(
                      child: ExcludeSemantics(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.echoColors.divider,
                            borderRadius: context.echoRadii.pill,
                          ),
                          child: const SizedBox(width: 36, height: 4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        context.echoSpacing.md,
                        context.echoSpacing.sm,
                        context.echoSpacing.xs,
                        context.echoSpacing.sm,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Semantics(
                                  header: true,
                                  child: Text(
                                    '播放队列',
                                    style: context.echoTypography.headline,
                                  ),
                                ),
                                SizedBox(height: context.echoSpacing.xxs),
                                Text(
                                  '${queue.length} 首曲目',
                                  style: context.echoTypography.metadata,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: context.echoSpacing.sm),
                          EchoIconButton(
                            icon: AppIcons.close,
                            label: '关闭播放队列',
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                        ],
                      ),
                    ),
                    const EchoDivider(),
                    Expanded(
                      child: queue.isEmpty
                          ? const EchoEmptyState(
                              title: '队列为空',
                              description: '开始播放一首歌曲后，接下来的曲目会出现在这里。',
                              icon: AppIcons.queue,
                            )
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: queue.length,
                              separatorBuilder: (context, index) => EchoDivider(
                                inset:
                                    context.echoInteraction.minimumTouchTarget +
                                    context.echoSpacing.lg,
                                endInset: context.echoSpacing.md,
                              ),
                              itemBuilder: (context, index) {
                                final song = queue[index];
                                return _QueueSongRow(
                                  index: index,
                                  song: song,
                                  isPlaying: index == currentIndex,
                                  onPressed: () => unawaited(onSelect(index)),
                                  onOpenActions: () => unawaited(
                                    onOpenSongActions(context, index, song),
                                  ),
                                );
                              },
                            ),
                    ),
                    const EchoDivider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.echoSpacing.md,
                        context.echoSpacing.xs,
                        context.echoSpacing.md,
                        context.echoSpacing.sm,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: EchoButton.ghost(
                          label: '清空后续队列',
                          semanticLabel: '清空后续播放队列，保留当前曲目',
                          leadingIcon: AppIcons.clearAll,
                          onPressed: queue.isEmpty
                              ? null
                              : () => unawaited(onClear()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QueueSongRow extends StatelessWidget {
  const _QueueSongRow({
    required this.index,
    required this.song,
    required this.isPlaying,
    required this.onPressed,
    required this.onOpenActions,
  });

  final int index;
  final Song song;
  final bool isPlaying;
  final VoidCallback onPressed;
  final VoidCallback onOpenActions;

  @override
  Widget build(BuildContext context) {
    final artist = song.artist?.trim() ?? '';
    final colors = context.echoColors;
    final titleColor = isPlaying ? colors.accent : colors.ink;
    final semanticLabel = <String>[
      '第 ${index + 1} 首',
      song.title,
      if (artist.isNotEmpty) artist,
      if (isPlaying) '当前播放',
    ].join('，');

    return ColoredBox(
      color: isPlaying
          ? colors.accent.withValues(alpha: 0.1)
          : Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: EchoPressable(
              semanticLabel: semanticLabel,
              selected: isPlaying,
              onPressed: onPressed,
              onLongPress: onOpenActions,
              minimumSize: Size(
                double.infinity,
                context.echoInteraction.expandedSongRowHeight,
              ),
              borderRadius: BorderRadius.zero,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  context.echoSpacing.md,
                  context.echoSpacing.xs,
                  0,
                  context.echoSpacing.xs,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox.square(
                      dimension: context.echoInteraction.minimumTouchTarget,
                      child: Center(
                        child: isPlaying
                            ? Icon(
                                AppIcons.equalizer,
                                size: 22,
                                color: colors.accent,
                              )
                            : DecoratedBox(
                                decoration: BoxDecoration(
                                  color: colors.raised,
                                  borderRadius: context.echoRadii.pill,
                                ),
                                child: SizedBox.square(
                                  dimension: 32,
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: context.echoTypography.metadata,
                                    ),
                                  ),
                                ),
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
                            song.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.echoTypography.title.copyWith(
                              color: titleColor,
                            ),
                          ),
                          if (artist.isNotEmpty) ...<Widget>[
                            SizedBox(height: context.echoSpacing.xxs),
                            Text(
                              artist,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.echoTypography.metadata,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(end: context.echoSpacing.xs),
            child: EchoIconButton(
              icon: AppIcons.more,
              label: '${song.title} 操作',
              onPressed: onOpenActions,
            ),
          ),
        ],
      ),
    );
  }
}
