import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../widgets/cover_art_image.dart';
import 'artist_detail_page.dart';

/// 歌手列表页
class ArtistListPage extends ConsumerWidget {
  const ArtistListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistsAsync = ref.watch(allArtistsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('所有歌手'),
      ),
      body: artistsAsync.when(
        data: (artists) {
          if (artists.isEmpty) {
            return const Center(child: Text('暂无歌手'));
          }

          return ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return ListTile(
                leading: CircleAvatar(
                  child: CoverArtImage(
                    coverArtId: artist.coverArt,
                    size: 40,
                  ),
                ),
                title: Text(artist.name),
                subtitle: artist.albumCount != null
                    ? Text('${artist.albumCount} 张专辑')
                    : null,
                trailing: const Icon(Icons.chevron_right),
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('加载失败: $error'),
            ],
          ),
        ),
      ),
    );
  }
}
