import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/artist.dart';
import '../../../providers/music_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../../../widgets/cover_art_image.dart';
import 'artist_detail_page.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/skeleton_templates.dart';

/// 歌手列表页 - A-Z 排序
class ArtistListPage extends ConsumerStatefulWidget {
  const ArtistListPage({super.key});

  @override
  ConsumerState<ArtistListPage> createState() => _ArtistListPageState();
}

class _ArtistListPageState extends ConsumerState<ArtistListPage> {
  List<AzItem<Artist>> _azArtists = [];
  bool _isLoaded = false;

  void _processArtists(List<Artist> artists) {
    if (_isLoaded) return;

    _azArtists = artists.map((artist) {
      String tag = PinyinUtils.getFirstChar(artist.name);
      String pinyin = PinyinUtils.getPinyin(artist.name);
      return AzItem(data: artist, tag: tag, namePinyin: pinyin);
    }).toList();

    SuspensionUtil.sortListBySuspensionTag(_azArtists);
    SuspensionUtil.setShowSuspensionStatus(_azArtists);

    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final artistsAsync = ref.watch(allArtistsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('所有歌手')),
      body: artistsAsync.when(
        data: (artists) {
          if (artists.isEmpty) {
            return const Center(child: Text('暂无歌手'));
          }

          if (!_isLoaded || _azArtists.length != artists.length) {
            _processArtists(artists);
          }

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: AzListView(
                data: _azArtists,
                itemCount: _azArtists.length,
                itemBuilder: (context, index) {
                  final item = _azArtists[index];
                  final artist = item.data;

                  // Suspension Header (Sticky Header) not explicitly needed if valid tags automatically show up?
                  // AzListView usually handles it if we provide suspensionWidget.
                  // But default item builder is just the item.
                  // If we want the section header, we should provide it.

                  return Column(
                    children: [
                      // Optional: Section Header if isShowSuspension is true
                      if (item.isShowSuspension)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.getSuspensionTag(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ListTile(
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
                              builder: (context) =>
                                  ArtistDetailPage(artistId: artist.id),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
                // Index Bar setup
                indexBarData: SuspensionUtil.getTagIndexList(_azArtists),
                indexBarOptions: IndexBarOptions(
                  needRebuild: true,
                  ignoreDragCancel: true,
                  downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
                  downItemDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  indexHintWidth: 120 / 2,
                  indexHintHeight: 100 / 2,
                  indexHintDecoration: BoxDecoration(
                    image: null,
                    color: Colors.grey[700],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  indexHintAlignment: Alignment.centerRight,
                  indexHintChildAlignment: Alignment(-0.25, 0.0),
                  indexHintOffset: Offset(-20, 0),
                ),
              ),
            ),
          );
        },
        loading: () => const ListTileSkeleton(count: 8, isCircleAvatar: true),
        error: (error, stack) =>
            const ErrorPlaceholder(message: '歌手列表加载失败，请检查网络后重试'),
      ),
    );
  }
}
