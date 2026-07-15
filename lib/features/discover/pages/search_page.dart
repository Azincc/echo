import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/repositories/music_repository.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/discover_media_widgets.dart';

/// 搜索页面
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() => _query = query.trim());
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    final searchResultAsync = _query.isEmpty
        ? null
        : ref.watch(searchProvider(_query));
    final searchLoadFailed = _query.isEmpty
        ? false
        : ref.watch(searchLoadFailedProvider(_query));

    return VisibleRemoteRetryScope(
      branchIndex: discoverBranchIndex,
      debugLabel: 'search_page',
      shouldRetry: (ref) =>
          _query.isNotEmpty &&
          (searchLoadFailed || ref.read(searchProvider(_query)).hasError),
      onRetry: (ref) {
        if (_query.isNotEmpty) ref.invalidate(searchProvider(_query));
      },
      child: Scaffold(
        backgroundColor: context.echoColors.canvas,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              EchoPageHeader(
                title: '搜索',
                leading: EchoIconButton(
                  icon: AppIcons.back,
                  label: '返回音乐流',
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoPageHorizontalPadding,
                  0,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.sm,
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, child) {
                    return EchoTextField(
                      controller: _searchController,
                      label: '搜索歌曲、专辑和歌手',
                      hintText: '输入关键词',
                      leadingIcon: AppIcons.search,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _performSearch,
                      trailing: value.text.isEmpty
                          ? null
                          : EchoIconButton(
                              icon: AppIcons.close,
                              label: '清空搜索',
                              onPressed: _clearSearch,
                            ),
                    );
                  },
                ),
              ),
              Expanded(
                child: _query.isEmpty
                    ? const EchoEmptyState(
                        title: '搜索你的音乐库',
                        description: '输入歌曲、专辑或歌手名称，然后按搜索键。',
                        icon: AppIcons.search,
                      )
                    : _buildSearchResults(
                        searchResultAsync!,
                        searchLoadFailed: searchLoadFailed,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    AsyncValue<SearchResult> resultAsync, {
    required bool searchLoadFailed,
  }) {
    return resultAsync.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (result) {
        if (result.isEmpty) {
          if (searchLoadFailed) {
            return EchoErrorState(
              title: '搜索失败',
              description: '无法读取音乐库，请检查网络或当前线路后重试。',
              actionLabel: '重试',
              onAction: () => ref.invalidate(searchProvider(_query)),
            );
          }
          return EchoEmptyState(
            title: '没有找到相关结果',
            description: '“$_query”没有匹配的歌曲、专辑或歌手。可以尝试更短的关键词。',
            icon: AppIcons.fileSearch,
          );
        }

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                context.echoPageHorizontalPadding,
                context.echoSpacing.xs,
                context.echoPageHorizontalPadding,
                context.echoSpacing.xxl,
              ),
              children: <Widget>[
                if (result.songs.isNotEmpty) ...<Widget>[
                  EchoSectionHeader(
                    title: '歌曲',
                    trailing: _ResultCount(count: result.songs.length),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (var index = 0; index < result.songs.length; index++)
                    DiscoverSongTile(
                      song: result.songs[index],
                      onPressed: () {
                        ref
                            .read(playerProvider.notifier)
                            .playQueue(result.songs, startIndex: index);
                      },
                      onOpenActions: () => showSongOptionsSheet(
                        context: context,
                        song: result.songs[index],
                      ),
                    ),
                ],
                if (result.songs.isNotEmpty &&
                    (result.albums.isNotEmpty ||
                        result.artists.isNotEmpty)) ...<Widget>[
                  SizedBox(height: context.echoSpacing.lg),
                  const EchoDivider(),
                  SizedBox(height: context.echoSpacing.lg),
                ],
                if (result.albums.isNotEmpty) ...<Widget>[
                  EchoSectionHeader(
                    title: '专辑',
                    trailing: _ResultCount(count: result.albums.length),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (final album in result.albums)
                    SearchAlbumRow(
                      album: album,
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          EchoPageRoute<void>(
                            context: context,
                            builder: (context) =>
                                AlbumDetailPage(albumId: album.id),
                          ),
                        );
                      },
                    ),
                ],
                if (result.albums.isNotEmpty &&
                    result.artists.isNotEmpty) ...<Widget>[
                  SizedBox(height: context.echoSpacing.lg),
                  const EchoDivider(),
                  SizedBox(height: context.echoSpacing.lg),
                ],
                if (result.artists.isNotEmpty) ...<Widget>[
                  EchoSectionHeader(
                    title: '歌手',
                    trailing: _ResultCount(count: result.artists.length),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (final artist in result.artists)
                    SearchArtistRow(
                      artist: artist,
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          EchoPageRoute<void>(
                            context: context,
                            builder: (context) =>
                                ArtistDetailPage(artistId: artist.id),
                          ),
                        );
                      },
                    ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.echoPageHorizontalPadding,
              vertical: context.echoSpacing.md,
            ),
            child: const DiscoverSongLoading(count: 5),
          ),
        ),
      ),
      error: (error, stackTrace) => EchoErrorState(
        title: '搜索失败',
        description: '无法读取音乐库，请检查网络或当前线路后重试。',
        actionLabel: '重试',
        onAction: () => ref.invalidate(searchProvider(_query)),
      ),
    );
  }
}

class _ResultCount extends StatelessWidget {
  const _ResultCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count 项',
      style: context.echoTypography.metadata.copyWith(
        color: context.echoColors.muted,
      ),
    );
  }
}
