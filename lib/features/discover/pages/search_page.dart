import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/repositories/music_repository.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';
import '../../library/widgets/library_collection_components.dart';
import '../../player/widgets/song_options_sheet.dart';

/// 搜索页面
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  static const Duration _searchDebounce = Duration(milliseconds: 500);

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(debugLabel: 'library_search');
  Timer? _searchTimer;
  String _draftQuery = '';
  String _query = '';

  @override
  void dispose() {
    _searchTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _scheduleSearch(String value) {
    _searchTimer?.cancel();
    _searchTimer = null;

    final query = value.trim();
    if (_draftQuery != query) {
      setState(() => _draftQuery = query);
    }
    if (query.isEmpty) {
      _commitSearch('');
      return;
    }
    if (query == _query) return;

    _searchTimer = Timer(_searchDebounce, () {
      _searchTimer = null;
      if (!mounted) return;
      _commitSearch(query);
    });
  }

  void _submitSearch(String value) {
    _searchTimer?.cancel();
    _searchTimer = null;
    _searchFocusNode.unfocus();
    _commitSearch(value);
  }

  void _commitSearch(String value) {
    final query = value.trim();
    if (_query == query && _draftQuery == query) return;
    setState(() {
      _draftQuery = query;
      _query = query;
    });
  }

  void _clearSearch() {
    _searchTimer?.cancel();
    _searchTimer = null;
    _searchController.clear();
    _commitSearch('');
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final committedQueryIsVisible = _query.isNotEmpty && _draftQuery == _query;
    final searchResultAsync = !committedQueryIsVisible
        ? null
        : ref.watch(searchProvider(_query));
    final searchLoadFailed = !committedQueryIsVisible
        ? false
        : ref.watch(searchLoadFailedProvider(_query));
    final currentSongId = ref.watch(
      playerProvider.select((state) => state.currentSong?.id),
    );

    return VisibleRemoteRetryScope(
      branchIndex: discoverBranchIndex,
      debugLabel: 'search_page',
      shouldRetry: (ref) =>
          committedQueryIsVisible &&
          (searchLoadFailed || ref.read(searchProvider(_query)).hasError),
      onRetry: (ref) {
        if (committedQueryIsVisible) ref.invalidate(searchProvider(_query));
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
                    final draftQuery = value.text.trim();
                    late final String helperText;
                    if (draftQuery.isEmpty) {
                      helperText = '输入后会自动搜索，也可以按搜索键立即开始。';
                    } else if (draftQuery != _query) {
                      helperText = '停止输入后将自动搜索。';
                    } else if (searchResultAsync?.isLoading ?? false) {
                      helperText = '正在搜索“$_query”。';
                    } else if (searchLoadFailed ||
                        (searchResultAsync?.hasError ?? false)) {
                      helperText = '搜索未完成，请重试。';
                    } else {
                      helperText = '正在显示“$_query”的结果。';
                    }
                    return EchoTextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      label: '搜索音乐库',
                      hintText: '歌曲、专辑或歌手',
                      helperText: helperText,
                      leadingIcon: AppIcons.search,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onChanged: _scheduleSearch,
                      onSubmitted: _submitSearch,
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
                child: _draftQuery.isEmpty
                    ? _withBottomObstruction(
                        const EchoEmptyState(
                          title: '搜索你的音乐库',
                          description: '输入歌曲、专辑或歌手名称，结果会自动出现。',
                          icon: AppIcons.search,
                        ),
                      )
                    : !committedQueryIsVisible
                    ? _withBottomObstruction(
                        _SearchDraftState(query: _draftQuery),
                      )
                    : _buildSearchResults(
                        searchResultAsync!,
                        searchLoadFailed: searchLoadFailed,
                        currentSongId: currentSongId,
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
    required String? currentSongId,
  }) {
    return resultAsync.when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (result) {
        if (result.isEmpty) {
          if (searchLoadFailed) {
            return Stack(
              children: <Widget>[
                _SearchStatusAnnouncement(
                  statusKey: const ValueKey<String>('search_results_error'),
                  label: '“$_query”搜索失败',
                ),
                _withBottomObstruction(
                  EchoErrorState(
                    title: '搜索失败',
                    description: '无法读取音乐库，请检查网络或当前线路后重试。',
                    actionLabel: '重试',
                    onAction: () => ref.invalidate(searchProvider(_query)),
                  ),
                ),
              ],
            );
          }
          return Stack(
            children: <Widget>[
              _SearchStatusAnnouncement(
                statusKey: const ValueKey<String>('search_results_empty'),
                label: '“$_query”搜索完成，没有找到相关结果',
              ),
              _withBottomObstruction(
                EchoEmptyState(
                  title: '没有找到相关结果',
                  description: '“$_query”没有匹配的歌曲、专辑或歌手。可以尝试更短的关键词。',
                  icon: AppIcons.fileSearch,
                ),
              ),
            ],
          );
        }

        final resultCount =
            result.songs.length + result.albums.length + result.artists.length;
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: ListView(
              key: const ValueKey<String>('search_results_list'),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                context.echoPageHorizontalPadding,
                context.echoSpacing.xs,
                context.echoPageHorizontalPadding,
                context.echoSpacing.xxl + context.echoShellBottomObstruction,
              ),
              children: <Widget>[
                Semantics(
                  key: const ValueKey<String>('search_results_summary'),
                  container: true,
                  liveRegion: true,
                  excludeSemantics: true,
                  label: '“$_query”搜索完成，找到 $resultCount 项结果',
                  child: Text(
                    '找到 $resultCount 项结果',
                    style: context.echoTypography.metadata.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ),
                SizedBox(height: context.echoSpacing.md),
                if (result.songs.isNotEmpty) ...<Widget>[
                  KeyedSubtree(
                    key: const ValueKey<String>('search_section_songs'),
                    child: EchoSectionHeader(
                      title: '歌曲',
                      trailing: _ResultCount(count: result.songs.length),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (var index = 0; index < result.songs.length; index++)
                    EchoSongRow(
                      song: result.songs[index],
                      index: index,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.echoSpacing.xs,
                      ),
                      isCurrent: result.songs[index].id == currentSongId,
                      onPressed: () {
                        ref
                            .read(playerProvider.notifier)
                            .playQueue(result.songs, startIndex: index);
                      },
                      onLongPress: () => showSongOptionsSheet(
                        context: context,
                        song: result.songs[index],
                      ),
                      onMorePressed: () => showSongOptionsSheet(
                        context: context,
                        song: result.songs[index],
                      ),
                    ),
                ],
                if (result.songs.isNotEmpty &&
                    (result.albums.isNotEmpty ||
                        result.artists.isNotEmpty)) ...<Widget>[
                  SizedBox(height: context.echoSpacing.xl),
                ],
                if (result.albums.isNotEmpty) ...<Widget>[
                  KeyedSubtree(
                    key: const ValueKey<String>('search_section_albums'),
                    child: EchoSectionHeader(
                      title: '专辑',
                      trailing: _ResultCount(count: result.albums.length),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (final album in result.albums)
                    EchoAlbumRow(
                      album: album,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.echoSpacing.xs,
                      ),
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
                  SizedBox(height: context.echoSpacing.xl),
                ],
                if (result.artists.isNotEmpty) ...<Widget>[
                  KeyedSubtree(
                    key: const ValueKey<String>('search_section_artists'),
                    child: EchoSectionHeader(
                      title: '歌手',
                      trailing: _ResultCount(count: result.artists.length),
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (final artist in result.artists)
                    EchoArtistRow(
                      artist: artist,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.echoSpacing.xs,
                      ),
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
          child: _SearchResultsLoading(query: _query),
        ),
      ),
      error: (error, stackTrace) => Stack(
        children: <Widget>[
          _SearchStatusAnnouncement(
            statusKey: const ValueKey<String>('search_results_error'),
            label: '“$_query”搜索失败',
          ),
          _withBottomObstruction(
            EchoErrorState(
              title: '搜索失败',
              description: '无法读取音乐库，请检查网络或当前线路后重试。',
              actionLabel: '重试',
              onAction: () => ref.invalidate(searchProvider(_query)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _withBottomObstruction(Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.echoShellBottomObstruction),
      child: child,
    );
  }
}

class _SearchDraftState extends StatelessWidget {
  const _SearchDraftState({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return EchoEmptyState(
      title: '准备搜索',
      description: '停止输入后将搜索“$query”。',
      icon: AppIcons.search,
    );
  }
}

class _SearchStatusAnnouncement extends StatelessWidget {
  const _SearchStatusAnnouncement({
    required this.statusKey,
    required this.label,
  });

  final Key statusKey;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: statusKey,
      container: true,
      liveRegion: true,
      label: label,
      child: const SizedBox.shrink(),
    );
  }
}

class _SearchResultsLoading extends StatelessWidget {
  const _SearchResultsLoading({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: const ValueKey<String>('search_results_loading'),
      container: true,
      liveRegion: true,
      label: '正在搜索“$query”',
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          context.echoPageHorizontalPadding,
          context.echoSpacing.xs,
          context.echoPageHorizontalPadding,
          context.echoSpacing.xxl + context.echoShellBottomObstruction,
        ),
        children: <Widget>[
          const _SearchLoadingHeader(),
          SizedBox(height: context.echoSpacing.sm),
          for (var index = 0; index < 3; index++)
            const _SearchLoadingRow(artworkSize: 48, trailingAction: true),
          SizedBox(height: context.echoSpacing.xl),
          const _SearchLoadingHeader(),
          SizedBox(height: context.echoSpacing.sm),
          for (var index = 0; index < 2; index++)
            const _SearchLoadingRow(artworkSize: 72),
          SizedBox(height: context.echoSpacing.xl),
          const _SearchLoadingHeader(),
          SizedBox(height: context.echoSpacing.sm),
          for (var index = 0; index < 2; index++)
            const _SearchLoadingRow(artworkSize: 56, circular: true),
        ],
      ),
    );
  }
}

class _SearchLoadingHeader extends StatelessWidget {
  const _SearchLoadingHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const EchoSkeleton.line(width: 72, height: 22),
        const Spacer(),
        EchoSkeleton(
          width: 36,
          height: 14,
          borderRadius: context.echoRadii.pill,
        ),
      ],
    );
  }
}

class _SearchLoadingRow extends StatelessWidget {
  const _SearchLoadingRow({
    required this.artworkSize,
    this.circular = false,
    this.trailingAction = false,
  });

  final double artworkSize;
  final bool circular;
  final bool trailingAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
      child: Row(
        children: <Widget>[
          if (circular)
            EchoSkeleton.circle(size: artworkSize)
          else
            EchoSkeleton(
              width: artworkSize,
              height: artworkSize,
              borderRadius: context.echoRadii.detail,
            ),
          SizedBox(width: context.echoSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const EchoSkeleton.line(height: 16),
                SizedBox(height: context.echoSpacing.xs),
                const FractionallySizedBox(
                  widthFactor: 0.64,
                  alignment: AlignmentDirectional.centerStart,
                  child: EchoSkeleton.line(height: 12),
                ),
              ],
            ),
          ),
          if (trailingAction) ...<Widget>[
            SizedBox(width: context.echoSpacing.sm),
            const EchoSkeleton.circle(size: 48),
          ],
        ],
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
