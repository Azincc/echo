import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/main_scaffold.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../library/pages/album_detail_page.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/discover_media_widgets.dart';
import 'search_page.dart';

/// 音乐流首页 - Tab 1
class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  Future<void> _refresh() async {
    await Future.wait<Object?>(<Future<Object?>>[
      ref.refresh(randomSongsProvider.future),
      ref.refresh(newestAlbumsProvider.future),
      ref.refresh(recentAlbumsProvider.future),
      ref.refresh(frequentAlbumsProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final randomSongsLoadFailed = ref.watch(randomSongsLoadFailedProvider);
    final newestAlbumsLoadFailed = ref.watch(newestAlbumsLoadFailedProvider);
    final recentAlbumsLoadFailed = ref.watch(recentAlbumsLoadFailedProvider);
    final frequentAlbumsLoadFailed = ref.watch(
      frequentAlbumsLoadFailedProvider,
    );

    return VisibleRemoteRetryScope(
      branchIndex: discoverBranchIndex,
      debugLabel: 'discover_page',
      shouldRetry: (ref) =>
          randomSongsLoadFailed ||
          newestAlbumsLoadFailed ||
          recentAlbumsLoadFailed ||
          frequentAlbumsLoadFailed ||
          ref.read(randomSongsProvider).hasError ||
          ref.read(newestAlbumsProvider).hasError ||
          ref.read(recentAlbumsProvider).hasError ||
          ref.read(frequentAlbumsProvider).hasError,
      onRetry: (ref) {
        ref.invalidate(randomSongsProvider);
        ref.invalidate(newestAlbumsProvider);
        ref.invalidate(recentAlbumsProvider);
        ref.invalidate(frequentAlbumsProvider);
      },
      child: Scaffold(
        backgroundColor: context.echoColors.canvas,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              EchoPageHeader(
                title: '音乐流',
                leading: shouldShowPageDrawerTrigger(context)
                    ? EchoIconButton(
                        icon: AppIcons.menu,
                        label: '打开应用菜单',
                        onPressed: openEchoAppDrawer,
                      )
                    : null,
                trailing: EchoIconButton(
                  icon: AppIcons.search,
                  label: '搜索音乐库',
                  onPressed: () {
                    Navigator.of(context).push<void>(
                      EchoPageRoute<void>(
                        context: context,
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: EchoRefreshView(
                  onRefresh: _refresh,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: ListView(
                        cacheExtent: 1500,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          context.echoPageHorizontalPadding,
                          context.echoSpacing.xs,
                          context.echoPageHorizontalPadding,
                          context.echoSpacing.xxl +
                              context.echoShellBottomObstruction,
                        ),
                        children: <Widget>[
                          const EchoSectionHeader(
                            title: '最近播放',
                            description: '重新打开最近听过的专辑。',
                          ),
                          SizedBox(height: context.echoSpacing.sm),
                          const RecentAlbumsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const RandomSongsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoSectionHeader(
                            title: '最近入库',
                            description: '刚加入音乐库的专辑。',
                          ),
                          SizedBox(height: context.echoSpacing.sm),
                          const NewestAlbumsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoSectionHeader(
                            title: '常听专辑',
                            description: '你最近反复回到的声音。',
                          ),
                          SizedBox(height: context.echoSpacing.sm),
                          const FrequentAlbumsSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RandomSongsSection extends ConsumerStatefulWidget {
  const RandomSongsSection({super.key});

  @override
  ConsumerState<RandomSongsSection> createState() => _RandomSongsSectionState();
}

class _RandomSongsSectionState extends ConsumerState<RandomSongsSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final randomSongsAsync = ref.watch(randomSongsProvider);
    final loadFailed = ref.watch(randomSongsLoadFailedProvider);
    final loadedSongs = randomSongsAsync.valueOrNull;
    final content = randomSongsAsync.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (songs) {
        if (songs.isEmpty) {
          return DiscoverSectionMessage(
            title: loadFailed ? '随心听暂时不可用' : '还没有可播放的歌曲',
            description: loadFailed
                ? '请检查网络或当前线路，然后重试。'
                : '音乐库中有歌曲后，这里会准备一组随心选择。',
            icon: loadFailed ? AppIcons.cloudOff : AppIcons.music,
            onRetry: loadFailed
                ? () => ref.invalidate(randomSongsProvider)
                : null,
          );
        }

        final displayCount = _expanded
            ? songs.length
            : (songs.length > 6 ? 6 : songs.length);
        final visibleSongs = songs.take(displayCount).toList(growable: false);

        return LayoutBuilder(
          builder: (context, constraints) {
            final textScale = MediaQuery.textScalerOf(context).scale(1);
            final columns = textScale > 1.3 || constraints.maxWidth < 720
                ? 1
                : 2;
            final gap = context.echoSpacing.md;
            final itemWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: gap,
                  runSpacing: context.echoSpacing.xxs,
                  children: <Widget>[
                    for (var index = 0; index < visibleSongs.length; index++)
                      SizedBox(
                        width: itemWidth,
                        child: DiscoverSongTile(
                          song: visibleSongs[index],
                          onPressed: () {
                            ref
                                .read(playerProvider.notifier)
                                .playQueue(songs, startIndex: index);
                          },
                          onOpenActions: () => showSongOptionsSheet(
                            context: context,
                            song: visibleSongs[index],
                          ),
                        ),
                      ),
                  ],
                ),
                if (songs.length > 6) ...<Widget>[
                  SizedBox(height: context.echoSpacing.xs),
                  EchoButton.ghost(
                    label: _expanded ? '收起' : '更多歌曲',
                    leadingIcon: _expanded
                        ? AppIcons.chevronUp
                        : AppIcons.chevronDown,
                    onPressed: () => setState(() => _expanded = !_expanded),
                  ),
                ],
              ],
            );
          },
        );
      },
      loading: () => const DiscoverSongLoading(),
      error: (error, stackTrace) => DiscoverSectionMessage(
        title: '随心听加载失败',
        description: '请检查网络或切换线路后重试。',
        icon: AppIcons.cloudOff,
        onRetry: () => ref.invalidate(randomSongsProvider),
      ),
    );

    return DecoratedBox(
      key: const Key('discover-random-mix'),
      decoration: BoxDecoration(
        color: context.echoColors.surface,
        borderRadius: context.echoRadii.surface,
        border: Border.all(color: context.echoColors.divider),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.echoSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EchoSectionHeader(
              title: '随心听',
              description: '从音乐库随机挑选，点一首即可开始。',
              trailing: EchoButton.primary(
                label: '立即播放',
                semanticLabel: '播放随心听',
                leadingIcon: AppIcons.shuffle,
                onPressed: loadedSongs == null || loadedSongs.isEmpty
                    ? null
                    : () => ref
                          .read(playerProvider.notifier)
                          .playQueue(loadedSongs),
              ),
            ),
            SizedBox(height: context.echoSpacing.md),
            content,
          ],
        ),
      ),
    );
  }
}

class RecentAlbumsSection extends ConsumerWidget {
  const RecentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(recentAlbumsProvider);
    final loadFailed = ref.watch(recentAlbumsLoadFailedProvider);
    return _AlbumAsyncSection(
      albumsAsync: albumsAsync,
      loadFailed: loadFailed,
      emptyTitle: '暂无最近播放',
      emptyDescription: '播放过的专辑会出现在这里，方便再次打开。',
      errorTitle: '最近播放加载失败',
      onRetry: () => ref.invalidate(recentAlbumsProvider),
      layout: _AlbumSectionLayout.recentSpotlight,
    );
  }
}

class FrequentAlbumsSection extends ConsumerWidget {
  const FrequentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(frequentAlbumsProvider);
    final loadFailed = ref.watch(frequentAlbumsLoadFailedProvider);
    return _AlbumAsyncSection(
      albumsAsync: albumsAsync,
      loadFailed: loadFailed,
      emptyTitle: '暂无常听专辑',
      emptyDescription: '持续聆听后，这里会整理经常播放的专辑。',
      errorTitle: '常听专辑加载失败',
      onRetry: () => ref.invalidate(frequentAlbumsProvider),
      layout: _AlbumSectionLayout.frequentShelf,
    );
  }
}

class NewestAlbumsSection extends ConsumerWidget {
  const NewestAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(newestAlbumsProvider);
    final loadFailed = ref.watch(newestAlbumsLoadFailedProvider);
    return _AlbumAsyncSection(
      albumsAsync: albumsAsync,
      loadFailed: loadFailed,
      emptyTitle: '暂无最近入库',
      emptyDescription: '新加入音乐库的专辑会按时间显示在这里。',
      errorTitle: '最近入库加载失败',
      onRetry: () => ref.invalidate(newestAlbumsProvider),
      layout: _AlbumSectionLayout.standardRail,
    );
  }
}

enum _AlbumSectionLayout { recentSpotlight, standardRail, frequentShelf }

class _AlbumAsyncSection extends StatelessWidget {
  const _AlbumAsyncSection({
    required this.albumsAsync,
    required this.loadFailed,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.errorTitle,
    required this.onRetry,
    required this.layout,
  });

  final AsyncValue<List<Album>> albumsAsync;
  final bool loadFailed;
  final String emptyTitle;
  final String emptyDescription;
  final String errorTitle;
  final VoidCallback onRetry;
  final _AlbumSectionLayout layout;

  @override
  Widget build(BuildContext context) {
    return albumsAsync.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (albums) {
        if (albums.isEmpty) {
          return DiscoverSectionMessage(
            title: loadFailed ? errorTitle : emptyTitle,
            description: loadFailed ? '请检查网络或当前线路，然后重试。' : emptyDescription,
            icon: loadFailed ? AppIcons.cloudOff : AppIcons.albumOutline,
            onRetry: loadFailed ? onRetry : null,
          );
        }
        return switch (layout) {
          _AlbumSectionLayout.recentSpotlight => DiscoverRecentAlbumRail(
            albums: albums,
            onAlbumPressed: (album) => _openAlbum(context, album.id),
          ),
          _AlbumSectionLayout.standardRail => DiscoverAlbumRail(
            albums: albums,
            onAlbumPressed: (album) => _openAlbum(context, album.id),
          ),
          _AlbumSectionLayout.frequentShelf => DiscoverFrequentAlbumShelf(
            albums: albums,
            onAlbumPressed: (album) => _openAlbum(context, album.id),
          ),
        };
      },
      loading: () => switch (layout) {
        _AlbumSectionLayout.recentSpotlight =>
          const DiscoverRecentAlbumLoading(),
        _AlbumSectionLayout.standardRail => const DiscoverAlbumLoading(),
        _AlbumSectionLayout.frequentShelf =>
          const DiscoverFrequentAlbumLoading(),
      },
      error: (error, stackTrace) => DiscoverSectionMessage(
        title: errorTitle,
        description: '请检查网络或切换线路后重试。',
        icon: AppIcons.cloudOff,
        onRetry: onRetry,
      ),
    );
  }

  void _openAlbum(BuildContext context, String albumId) {
    Navigator.of(context).push<void>(
      EchoPageRoute<void>(
        context: context,
        builder: (context) => AlbumDetailPage(albumId: albumId),
      ),
    );
  }
}
