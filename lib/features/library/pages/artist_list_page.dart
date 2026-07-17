import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/artist.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../widgets/library_collection_components.dart';
import 'artist_detail_page.dart';

/// Alphabetical artist collection with stable A-Z navigation.
class ArtistListPage extends ConsumerStatefulWidget {
  const ArtistListPage({super.key});

  @override
  ConsumerState<ArtistListPage> createState() => _ArtistListPageState();
}

class _ArtistListPageState extends ConsumerState<ArtistListPage> {
  List<AzItem<Artist>> _azArtists = const <AzItem<Artist>>[];
  int _artistsSignature = 0;

  int _buildSignature(List<Artist> artists) {
    return Object.hashAll(
      artists.map(
        (artist) => Object.hash(
          artist.id,
          artist.name,
          artist.coverArt,
          artist.albumCount,
          artist.starred,
        ),
      ),
    );
  }

  void _processArtists(List<Artist> artists, int signature) {
    final items = artists
        .map((artist) {
          return AzItem<Artist>(
            data: artist,
            tag: PinyinUtils.getFirstChar(artist.name),
            namePinyin: PinyinUtils.getPinyin(artist.name),
          );
        })
        .toList(growable: false);
    SuspensionUtil.sortListBySuspensionTag(items);
    SuspensionUtil.setShowSuspensionStatus(items);
    _azArtists = items;
    _artistsSignature = signature;
  }

  @override
  Widget build(BuildContext context) {
    final artistsAsync = ref.watch(allArtistsProvider);
    final loadFailed = ref.watch(allArtistsLoadFailedProvider);
    final artistCount = artistsAsync.valueOrNull?.length;

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'artist_list_page',
      shouldRetry: (ref) => loadFailed || artistsAsync.hasError,
      onRetry: (ref) => ref.invalidate(allArtistsProvider),
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '所有歌手',
          subtitle: artistCount == null ? null : '$artistCount 位歌手',
        ),
        body: artistsAsync.when(
          data: (artists) {
            if (artists.isEmpty) {
              if (loadFailed) {
                return EchoErrorState(
                  title: '歌手列表加载失败',
                  description: '请检查网络或服务器状态后重试。',
                  actionLabel: '重试',
                  onAction: () => ref.invalidate(allArtistsProvider),
                );
              }
              return const EchoEmptyState(
                title: '暂无歌手',
                description: '同步音乐库后，歌手会按名称分组显示在这里。',
                icon: AppIcons.profile,
              );
            }

            final signature = _buildSignature(artists);
            if (signature != _artistsSignature ||
                _azArtists.length != artists.length) {
              _processArtists(artists, signature);
            }

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: EchoAzIndexReveal(
                  builder: (context, opacity, _) => AzListView(
                    key: const ValueKey<String>('artist-list-scroll'),
                    data: _azArtists,
                    itemCount: _azArtists.length,
                    padding: EdgeInsets.only(
                      bottom:
                          context.echoSpacing.xxl +
                          context.echoShellBottomObstruction,
                    ),
                    itemBuilder: (context, index) {
                      final item = _azArtists[index];
                      final artist = item.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (item.isShowSuspension)
                            EchoLibrarySectionLabel(
                              label: item.getSuspensionTag(),
                            ),
                          EchoArtistRow(
                            artist: artist,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                              context.echoPageHorizontalPadding,
                              context.echoSpacing.xs,
                              44,
                              context.echoSpacing.xs,
                            ),
                            onPressed: () => Navigator.of(context).push<void>(
                              EchoPageRoute<void>(
                                context: context,
                                builder: (_) =>
                                    ArtistDetailPage(artistId: artist.id),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    indexBarData: SuspensionUtil.getTagIndexList(_azArtists),
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
          loading: () => const EchoMediaListSkeleton(circle: true),
          error: (error, stackTrace) => EchoErrorState(
            title: '歌手列表加载失败',
            description: '请检查网络或服务器状态后重试。',
            actionLabel: '重试',
            onAction: () => ref.invalidate(allArtistsProvider),
          ),
        ),
      ),
    );
  }
}
