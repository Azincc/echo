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
    ref.invalidate(randomSongsProvider);
    ref.invalidate(newestAlbumsProvider);
    ref.invalidate(recentAlbumsProvider);
    ref.invalidate(frequentAlbumsProvider);
    await Future<void>.delayed(Duration.zero);
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
                          context.echoSpacing.xxl,
                        ),
                        children: <Widget>[
                          const EchoSectionHeader(title: '随机推荐'),
                          SizedBox(height: context.echoSpacing.sm),
                          const RandomSongsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoSectionHeader(title: '最近入库'),
                          SizedBox(height: context.echoSpacing.sm),
                          const NewestAlbumsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoSectionHeader(title: '最近播放'),
                          SizedBox(height: context.echoSpacing.sm),
                          const RecentAlbumsSection(),
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoSectionHeader(title: '经常听的专辑'),
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

    return randomSongsAsync.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (songs) {
        if (songs.isEmpty) {
          return DiscoverSectionMessage(
            title: loadFailed ? '随机歌曲暂时不可用' : '还没有可推荐的歌曲',
            description: loadFailed
                ? '请检查网络或当前线路，然后重试。'
                : '音乐库中有歌曲后，这里会提供一组随机选择。',
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
            final columns = textScale > 1.3 || constraints.maxWidth < 600
                ? 1
                : constraints.maxWidth < 1000
                ? 2
                : 3;
            final gap = context.echoSpacing.md;
            final itemWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: gap,
                  runSpacing: context.echoSpacing.xs,
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
        title: '随机歌曲加载失败',
        description: '请检查网络或切换线路后重试。',
        icon: AppIcons.cloudOff,
        onRetry: () => ref.invalidate(randomSongsProvider),
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
      emptyDescription: '播放过的专辑会出现在这里，方便继续聆听。',
      errorTitle: '最近播放加载失败',
      onRetry: () => ref.invalidate(recentAlbumsProvider),
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
      expandOnWide: true,
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
    );
  }
}

class _AlbumAsyncSection extends StatelessWidget {
  const _AlbumAsyncSection({
    required this.albumsAsync,
    required this.loadFailed,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.errorTitle,
    required this.onRetry,
    this.expandOnWide = false,
  });

  final AsyncValue<List<Album>> albumsAsync;
  final bool loadFailed;
  final String emptyTitle;
  final String emptyDescription;
  final String errorTitle;
  final VoidCallback onRetry;
  final bool expandOnWide;

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
        return _AlbumCollection(albums: albums, expandOnWide: expandOnWide);
      },
      loading: () => const DiscoverAlbumLoading(),
      error: (error, stackTrace) => DiscoverSectionMessage(
        title: errorTitle,
        description: '请检查网络或切换线路后重试。',
        icon: AppIcons.cloudOff,
        onRetry: onRetry,
      ),
    );
  }
}

class _AlbumCollection extends StatelessWidget {
  const _AlbumCollection({required this.albums, required this.expandOnWide});

  final List<Album> albums;
  final bool expandOnWide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        final tileWidth = constraints.maxWidth < 400 ? 132.0 : 148.0;
        final tileHeight = tileWidth + 76 + (scale - 1) * 96;
        final useGrid =
            expandOnWide &&
            constraints.maxWidth >= 600 &&
            MediaQuery.textScalerOf(context).scale(1) <= 1.3;

        if (useGrid) {
          final visibleAlbums = albums.take(6).toList(growable: false);
          final columns = constraints.maxWidth >= 1000 ? 4 : 3;
          final gap = context.echoSpacing.md;
          final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: context.echoSpacing.lg,
            children: <Widget>[
              for (final album in visibleAlbums)
                DiscoverAlbumTile(
                  album: album,
                  width: width,
                  onPressed: () => _openAlbum(context, album.id),
                ),
            ],
          );
        }

        return SizedBox(
          height: tileHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: albums.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.sm),
            itemBuilder: (context, index) {
              final album = albums[index];
              return DiscoverAlbumTile(
                album: album,
                width: tileWidth,
                onPressed: () => _openAlbum(context, album.id),
              );
            },
          ),
        );
      },
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
