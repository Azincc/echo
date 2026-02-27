import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/album.dart';
import '../../../providers/music_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/album_options_sheet.dart';
import 'album_detail_page.dart';
import '../../../widgets/error_placeholder.dart';

/// 专辑列表页 - A-Z 分组 Grid (通过 List 模拟)
class AlbumListPage extends ConsumerWidget {
  const AlbumListPage({super.key});

  List<AzItem<List<Album>>> _buildAlbumRows(List<Album> albums) {
    final azAlbumRows = <AzItem<List<Album>>>[];
    // 1. Convert to AzItems temporarily to sort and extract tags
    List<AzItem<Album>> tempItems = albums.map((album) {
      String tag = PinyinUtils.getFirstChar(album.name);
      String pinyin = PinyinUtils.getPinyin(album.name);
      return AzItem(data: album, tag: tag, namePinyin: pinyin);
    }).toList();

    SuspensionUtil.sortListBySuspensionTag(tempItems);

    // 2. Group by Tag
    Map<String, List<Album>> grouped = {};
    for (var item in tempItems) {
      grouped.putIfAbsent(item.tag, () => []).add(item.data);
    }

    // 3. Chunk into rows (2 items per row)
    grouped.forEach((tag, groupAlbums) {
      for (int i = 0; i < groupAlbums.length; i += 2) {
        // Take 2 items
        final chunk = groupAlbums.sublist(
          i,
          i + 2 > groupAlbums.length ? groupAlbums.length : i + 2,
        );

        // Create AzItem for the row
        // Use the tag from the group
        // Name pinyin can be the pinyin of the first item
        String pinyin = PinyinUtils.getPinyin(chunk.first.name);
        azAlbumRows.add(AzItem(data: chunk, tag: tag, namePinyin: pinyin));
      }
    });

    // Sort rows? They are already added in tag order and then list order.
    // But AzListView expects them sorted?
    // Yes, they are in tag order.
    SuspensionUtil.setShowSuspensionStatus(azAlbumRows);
    return azAlbumRows;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(allAlbumsProvider);
    final loadFailed = ref.watch(allAlbumsLoadFailedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('所有专辑')),
      body: albumsAsync.when(
        data: (albums) {
          if (albums.isEmpty) {
            return Center(child: Text(loadFailed ? '网络异常，专辑加载失败' : '暂无专辑'));
          }

          final azAlbumRows = _buildAlbumRows(albums);

          return AzListView(
            data: azAlbumRows,
            itemCount: azAlbumRows.length,
            itemBuilder: (context, index) {
              final item = azAlbumRows[index];
              final rowAlbums = item.data;

              // Build row
              return Column(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 40, // Extra padding for IndexBar
                      top: 6,
                      bottom: 6,
                    ),
                    child: Row(
                      children: [
                        for (int i = 0; i < rowAlbums.length; i++) ...[
                          Expanded(
                            child: _buildAlbumItem(context, ref, rowAlbums[i]),
                          ),
                          if (i < rowAlbums.length - 1 || rowAlbums.length == 1)
                            const SizedBox(width: 12),
                        ],
                        // If only 1 item, add Spacer to keep alignment
                        if (rowAlbums.length == 1)
                          const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              );
            },
            indexBarData: SuspensionUtil.getTagIndexList(azAlbumRows),
            indexBarOptions: const IndexBarOptions(
              needRebuild: true,
              ignoreDragCancel: true,
              downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
              downItemDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              indexHintAlignment: Alignment.centerRight,
              indexHintOffset: Offset(-20, 0),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const ErrorPlaceholder(message: '专辑列表加载失败，请检查网络后重试'),
      ),
    );
  }

  Widget _buildAlbumItem(BuildContext context, WidgetRef ref, Album album) {
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
  }
}
