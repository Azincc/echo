import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/repositories/music_repository.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/album_options_sheet.dart';
import '../widgets/library_collection_components.dart';
import 'album_detail_page.dart';
import 'artist_detail_page.dart';

enum StarredTab { songs, albums, artists }

class StarredPage extends ConsumerWidget {
  const StarredPage({super.key, this.initialTab = StarredTab.songs});

  final StarredTab initialTab;

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(starredProvider);
    await ref.read(starredProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starredAsync = ref.watch(starredProvider);
    final loadFailed = ref.watch(starredLoadFailedProvider);
    final value = starredAsync.valueOrNull;
    final total = value == null
        ? null
        : value.songs.length + value.albums.length + value.artists.length;

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'starred_page',
      shouldRetry: (ref) => loadFailed || starredAsync.hasError,
      onRetry: (ref) => ref.invalidate(starredProvider),
      child: DefaultTabController(
        length: StarredTab.values.length,
        initialIndex: initialTab.index,
        child: Builder(
          builder: (tabContext) {
            final controller = DefaultTabController.of(tabContext);
            return EchoScaffold(
              topBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  EchoTopBar.back(
                    context: tabContext,
                    title: '收藏夹',
                    subtitle: total == null ? null : '$total 项收藏',
                  ),
                  _StarredTabStrip(controller: controller),
                  const EchoDivider(),
                ],
              ),
              body: starredAsync.when(
                data: (starred) {
                  final empty =
                      starred.songs.isEmpty &&
                      starred.albums.isEmpty &&
                      starred.artists.isEmpty;
                  if (loadFailed && empty) {
                    return EchoErrorState(
                      title: '收藏加载失败',
                      description: '请检查网络或服务器状态后重试。',
                      actionLabel: '重试',
                      onAction: () => ref.invalidate(starredProvider),
                    );
                  }
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: TabBarView(
                        controller: controller,
                        children: <Widget>[
                          _buildSongsTab(tabContext, ref, starred),
                          _buildAlbumsTab(tabContext, ref, starred),
                          _buildArtistsTab(tabContext, ref, starred),
                        ],
                      ),
                    ),
                  );
                },
                loading: () => const EchoMediaListSkeleton(count: 7),
                error: (error, stackTrace) => EchoErrorState(
                  title: '收藏加载失败',
                  description: '请检查网络或服务器状态后重试。',
                  actionLabel: '重试',
                  onAction: () => ref.invalidate(starredProvider),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSongsTab(
    BuildContext context,
    WidgetRef ref,
    StarredResult starred,
  ) {
    final songs = starred.songs;
    if (songs.isEmpty) {
      return _refreshableEmpty(
        context: context,
        ref: ref,
        title: '暂无收藏歌曲',
        description: '在歌曲操作中点亮红心后，会显示在这里。',
        icon: AppIcons.heartOutline,
      );
    }

    return EchoRefreshView(
      onRefresh: () => _refresh(ref),
      child: ListView.builder(
        key: const ValueKey<String>('starred-songs-scroll'),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: context.echoSpacing.xxl + context.echoShellBottomObstruction,
        ),
        itemCount: songs.length + 1,
        itemBuilder: (context, listIndex) {
          if (listIndex == 0) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                context.echoPageHorizontalPadding,
                context.echoSpacing.sm,
                context.echoPageHorizontalPadding,
                context.echoSpacing.xs,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: context.echoSpacing.sm,
                runSpacing: context.echoSpacing.xs,
                children: <Widget>[
                  Text(
                    '歌曲 (${songs.length})',
                    style: context.echoTypography.headline,
                  ),
                  EchoButton.ghost(
                    label: '播放全部',
                    leadingIcon: AppIcons.play,
                    onPressed: () =>
                        ref.read(playerProvider.notifier).playQueue(songs),
                  ),
                ],
              ),
            );
          }

          final index = listIndex - 1;
          final song = songs[index];
          return SongListItem(
            song: song,
            index: index,
            variant: SongListItemVariant.standard,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.echoPageHorizontalPadding,
              vertical: context.echoSpacing.xs,
            ),
            onTap: () => ref
                .read(playerProvider.notifier)
                .playQueue(songs, startIndex: index),
            onLongPress: () =>
                showSongOptionsSheet(context: context, song: song),
          );
        },
      ),
    );
  }

  Widget _buildAlbumsTab(
    BuildContext context,
    WidgetRef ref,
    StarredResult starred,
  ) {
    final albums = starred.albums;
    if (albums.isEmpty) {
      return _refreshableEmpty(
        context: context,
        ref: ref,
        title: '暂无收藏专辑',
        description: '长按专辑并点亮收藏后，会显示在这里。',
        icon: AppIcons.albumOutline,
      );
    }

    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final largeText = textScale >= 1.6;
    final content = largeText
        ? ListView.builder(
            key: const ValueKey<String>('starred-albums-list-scroll'),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom:
                  context.echoSpacing.xxl + context.echoShellBottomObstruction,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return EchoAlbumRow(
                album: album,
                onPressed: () => _openAlbum(context, album.id),
                onLongPress: () => showAlbumOptionsSheet(
                  context: context,
                  ref: ref,
                  album: album,
                ),
              );
            },
          )
        : GridView.builder(
            key: const ValueKey<String>('starred-albums-grid-scroll'),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.echoPageHorizontalPadding,
              context.echoSpacing.md,
              context.echoPageHorizontalPadding,
              context.echoSpacing.xxl + context.echoShellBottomObstruction,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 220 + 76 * textScale,
              crossAxisSpacing: context.echoSpacing.sm,
              mainAxisSpacing: context.echoSpacing.md,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return EchoAlbumTile(
                album: album,
                onPressed: () => _openAlbum(context, album.id),
                onLongPress: () => showAlbumOptionsSheet(
                  context: context,
                  ref: ref,
                  album: album,
                ),
              );
            },
          );

    return EchoRefreshView(onRefresh: () => _refresh(ref), child: content);
  }

  Widget _buildArtistsTab(
    BuildContext context,
    WidgetRef ref,
    StarredResult starred,
  ) {
    final artists = starred.artists;
    if (artists.isEmpty) {
      return _refreshableEmpty(
        context: context,
        ref: ref,
        title: '暂无收藏歌手',
        description: '收藏的歌手会集中显示在这里。',
        icon: AppIcons.profile,
      );
    }

    return EchoRefreshView(
      onRefresh: () => _refresh(ref),
      child: ListView.builder(
        key: const ValueKey<String>('starred-artists-scroll'),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: context.echoSpacing.xxl + context.echoShellBottomObstruction,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return EchoArtistRow(
            artist: artist,
            onPressed: () => Navigator.of(context).push<void>(
              EchoPageRoute<void>(
                context: context,
                builder: (_) => ArtistDetailPage(artistId: artist.id),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _refreshableEmpty({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return EchoRefreshView(
      onRefresh: () => _refresh(ref),
      child: CustomScrollView(
        key: const ValueKey<String>('starred-empty-scroll'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: context.echoShellBottomObstruction,
            ),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: EchoEmptyState(
                title: title,
                description: description,
                icon: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openAlbum(BuildContext context, String albumId) {
    Navigator.of(context).push<void>(
      EchoPageRoute<void>(
        context: context,
        builder: (_) => AlbumDetailPage(albumId: albumId),
      ),
    );
  }
}

class _StarredTabStrip extends StatefulWidget {
  const _StarredTabStrip({required this.controller});

  final TabController controller;

  @override
  State<_StarredTabStrip> createState() => _StarredTabStripState();
}

class _StarredTabStripState extends State<_StarredTabStrip> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant _StarredTabStrip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) return;
    oldWidget.controller.removeListener(_handleControllerChanged);
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const labels = <String>['歌曲', '专辑', '歌手'];
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.echoPageHorizontalPadding,
        0,
        context.echoPageHorizontalPadding,
        context.echoSpacing.sm,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.echoColors.raised,
          borderRadius: context.echoRadii.control,
        ),
        child: Row(
          children: <Widget>[
            for (var index = 0; index < labels.length; index++)
              Expanded(
                child: EchoPressable(
                  semanticLabel: '${labels[index]}收藏',
                  selected: widget.controller.index == index,
                  onPressed: () => widget.controller.animateTo(
                    index,
                    duration: context.echoMotion.resolve(
                      context,
                      context.echoMotion.state,
                    ),
                    curve: context.echoMotion.easeOut,
                  ),
                  minimumSize: Size(
                    double.infinity,
                    context.echoInteraction.minimumTouchTarget,
                  ),
                  borderRadius: context.echoRadii.control,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: widget.controller.index == index
                          ? context.echoColors.accent.withValues(alpha: 0.14)
                          : Colors.transparent,
                      borderRadius: context.echoRadii.control,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.echoSpacing.xs,
                        ),
                        child: Text(
                          labels[index],
                          style: context.echoTypography.label.copyWith(
                            color: widget.controller.index == index
                                ? context.echoColors.accent
                                : context.echoColors.muted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
