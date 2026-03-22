import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/music_repository.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/album_options_sheet.dart';
import 'album_detail_page.dart';
import 'artist_detail_page.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/skeleton_templates.dart';
import '../../../widgets/visible_remote_retry_scope.dart';

enum StarredTab { songs, albums, artists }

/// 收藏夹页面
class StarredPage extends ConsumerWidget {
  final StarredTab initialTab;

  const StarredPage({super.key, this.initialTab = StarredTab.songs});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(starredProvider);
    await ref.read(starredProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starredAsync = ref.watch(starredProvider);
    final loadFailed = ref.watch(starredLoadFailedProvider);

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'starred_page',
      shouldRetry: (ref) => loadFailed || starredAsync.hasError,
      onRetry: (ref) => ref.invalidate(starredProvider),
      child: DefaultTabController(
        length: 3,
        initialIndex: initialTab.index,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('收藏夹'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '歌曲'),
                Tab(text: '专辑'),
                Tab(text: '歌手'),
              ],
            ),
          ),
          body: starredAsync.when(
            data: (starred) => Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: TabBarView(
                  children: [
                    _buildSongsTab(context, ref, starred),
                    _buildAlbumsTab(context, ref, starred),
                    _buildArtistsTab(context, ref, starred),
                  ],
                ),
              ),
            ),
            loading: () => const ListTileSkeleton(count: 6),
            error: (error, stack) => ErrorPlaceholder(
              message: '收藏加载失败，请检查网络后重试',
              onRetry: () => ref.invalidate(starredProvider),
            ),
          ),
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
      return RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: _buildEmptyScrollable(
          icon: Icons.favorite_border,
          text: '暂无收藏歌曲',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.music_note),
                const SizedBox(width: 8),
                Text(
                  '歌曲 (${songs.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () =>
                      ref.read(playerProvider.notifier).playQueue(songs),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('播放全部'),
                ),
              ],
            ),
          ),
          ...songs.asMap().entries.map((entry) {
            final index = entry.key;
            final song = entry.value;
            return SongListItem(
              song: song,
              index: index,
              variant: SongListItemVariant.standard,
              onTap: () {
                ref
                    .read(playerProvider.notifier)
                    .playQueue(songs, startIndex: index);
              },
              onLongPress: () {
                showSongOptionsSheet(context: context, song: song);
              },
            );
          }),
        ],
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
      return RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: _buildEmptyScrollable(
          icon: Icons.album_outlined,
          text: '暂无收藏专辑',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumDetailPage(albumId: album.id),
                ),
              );
            },
            onLongPress: () {
              showAlbumOptionsSheet(context: context, ref: ref, album: album);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CoverArtImage(
                            coverArtId: album.coverArt,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (album.starred)
                        Positioned(
                          left: 6,
                          bottom: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              size: 14,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  album.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (album.artist != null)
                  Text(
                    album.artist!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildArtistsTab(
    BuildContext context,
    WidgetRef ref,
    StarredResult starred,
  ) {
    final artists = starred.artists;
    if (artists.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: _buildEmptyScrollable(
          icon: Icons.person_outline,
          text: '暂无收藏歌手',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: CircleAvatar(
              child: artist.coverArt != null
                  ? ClipOval(
                      child: CoverArtImage(
                        coverArtId: artist.coverArt,
                        size: 40,
                      ),
                    )
                  : const Icon(Icons.person),
            ),
            title: Text(artist.name),
            subtitle: Text('${artist.albumCount} 张专辑'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistDetailPage(artistId: artist.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyScrollable({required IconData icon, required String text}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 160),
        Icon(icon, size: 64, color: Colors.grey),
        const SizedBox(height: 16),
        Center(child: Text(text)),
      ],
    );
  }
}
