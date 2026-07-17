import 'dart:math' as math;

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../widgets/album_options_sheet.dart';
import '../widgets/library_collection_components.dart';
import 'album_detail_page.dart';

/// Alphabetical album collection with a responsive, content-led grid.
class AlbumListPage extends ConsumerStatefulWidget {
  const AlbumListPage({super.key});

  @override
  ConsumerState<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends ConsumerState<AlbumListPage> {
  List<AzItem<List<Album>>> _albumRows = const <AzItem<List<Album>>>[];
  int _albumsSignature = 0;
  int _cachedItemsPerRow = 0;

  int _buildAlbumsSignature(List<Album> albums) {
    return Object.hashAll(
      albums.map(
        (album) => Object.hash(
          album.id,
          album.name,
          album.artist,
          album.coverArt,
          album.starred,
        ),
      ),
    );
  }

  List<AzItem<List<Album>>> _buildAlbumRows(
    List<Album> albums,
    int itemsPerRow,
  ) {
    final items = albums
        .map((album) {
          return AzItem<Album>(
            data: album,
            tag: PinyinUtils.getFirstChar(album.name),
            namePinyin: PinyinUtils.getPinyin(album.name),
          );
        })
        .toList(growable: false);
    SuspensionUtil.sortListBySuspensionTag(items);

    final grouped = <String, List<Album>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.tag, () => <Album>[]).add(item.data);
    }

    final rows = <AzItem<List<Album>>>[];
    for (final entry in grouped.entries) {
      final group = entry.value;
      for (var start = 0; start < group.length; start += itemsPerRow) {
        final end = math.min(start + itemsPerRow, group.length);
        final albumsInRow = group.sublist(start, end);
        rows.add(
          AzItem<List<Album>>(
            data: albumsInRow,
            tag: entry.key,
            namePinyin: PinyinUtils.getPinyin(albumsInRow.first.name),
          ),
        );
      }
    }
    SuspensionUtil.setShowSuspensionStatus(rows);
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final albumsAsync = ref.watch(allAlbumsProvider);
    final loadFailed = ref.watch(allAlbumsLoadFailedProvider);
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final effectiveWidth = math.min(1400.0, screenWidth);
    final targetExtent = textScale >= 1.6 ? 280.0 : 180.0;
    final itemsPerRow = math.max(1, (effectiveWidth / targetExtent).floor());
    final albumCount = albumsAsync.valueOrNull?.length;

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'album_list_page',
      shouldRetry: (ref) => loadFailed || albumsAsync.hasError,
      onRetry: (ref) => ref.invalidate(allAlbumsProvider),
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '所有专辑',
          subtitle: albumCount == null ? null : '$albumCount 张专辑',
        ),
        body: albumsAsync.when(
          data: (albums) {
            if (albums.isEmpty) {
              if (loadFailed) {
                return EchoErrorState(
                  title: '专辑加载失败',
                  description: '请检查网络或服务器状态后重试。',
                  actionLabel: '重试',
                  onAction: () => ref.invalidate(allAlbumsProvider),
                );
              }
              return const EchoEmptyState(
                title: '暂无专辑',
                description: '同步音乐库后，专辑会按名称分组显示在这里。',
                icon: AppIcons.albumOutline,
              );
            }

            final signature = _buildAlbumsSignature(albums);
            if (signature != _albumsSignature ||
                _cachedItemsPerRow != itemsPerRow ||
                _albumRows.isEmpty) {
              _albumRows = _buildAlbumRows(albums, itemsPerRow);
              _albumsSignature = signature;
              _cachedItemsPerRow = itemsPerRow;
            }
            final rows = _albumRows;
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: EchoAzIndexReveal(
                  builder: (context, opacity, _) => AzListView(
                    key: const ValueKey<String>('album-list-scroll'),
                    data: rows,
                    itemCount: rows.length,
                    padding: EdgeInsets.only(
                      bottom:
                          context.echoSpacing.xxl +
                          context.echoShellBottomObstruction,
                    ),
                    itemBuilder: (context, index) {
                      final item = rows[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (item.isShowSuspension)
                            EchoLibrarySectionLabel(
                              label: item.getSuspensionTag(),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              context.echoPageHorizontalPadding,
                              context.echoSpacing.xs,
                              44,
                              context.echoSpacing.sm,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                for (
                                  var slot = 0;
                                  slot < itemsPerRow;
                                  slot++
                                ) ...<Widget>[
                                  Expanded(
                                    child: slot < item.data.length
                                        ? EchoAlbumTile(
                                            album: item.data[slot],
                                            allowFullText: textScale >= 1.6,
                                            onPressed: () => _openAlbum(
                                              context,
                                              item.data[slot],
                                            ),
                                            onLongPress: () =>
                                                showAlbumOptionsSheet(
                                                  context: context,
                                                  ref: ref,
                                                  album: item.data[slot],
                                                ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                  if (slot < itemsPerRow - 1)
                                    SizedBox(width: context.echoSpacing.sm),
                                ],
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    indexBarData: SuspensionUtil.getTagIndexList(rows),
                    indexBarWidth: 24,
                    indexBarMargin: EdgeInsetsDirectional.only(
                      end: context.echoSpacing.xxs,
                    ),
                    indexBarOptions: echoIndexBarOptions(
                      context,
                      opacity: opacity,
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const EchoAlbumGridSkeleton(),
          error: (error, stackTrace) => EchoErrorState(
            title: '专辑加载失败',
            description: '请检查网络或服务器状态后重试。',
            actionLabel: '重试',
            onAction: () => ref.invalidate(allAlbumsProvider),
          ),
        ),
      ),
    );
  }

  void _openAlbum(BuildContext context, Album album) {
    Navigator.of(context).push<void>(
      EchoPageRoute<void>(
        context: context,
        builder: (_) => AlbumDetailPage(albumId: album.id),
      ),
    );
  }
}
