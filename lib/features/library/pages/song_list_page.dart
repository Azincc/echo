import 'dart:async';
import 'dart:math' as math;

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../utils/library_sorting.dart';
import '../widgets/library_collection_components.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';

class SongListPage extends ConsumerStatefulWidget {
  const SongListPage({super.key});

  @override
  ConsumerState<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends ConsumerState<SongListPage> {
  List<AzItem<Song>> _azSongs = [];
  List<Song> _displaySongs = [];
  SongSortOption _sortOption = SongSortOption.alphabeticalAsc;
  int _songsSignature = 0;
  late final ItemPositionsListener _itemPositionsListener;
  int _coverLoadStart = 0;
  int _coverLoadEnd = -1;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener = ItemPositionsListener.create();
    _itemPositionsListener.itemPositions.addListener(_onItemPositionsChanged);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(
      _onItemPositionsChanged,
    );
    super.dispose();
  }

  void _onItemPositionsChanged() {
    if (!mounted || _displaySongs.isEmpty) return;
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    // Only count items that are currently visible in the viewport.
    final visible = positions
        .where((p) => p.itemTrailingEdge > 0 && p.itemLeadingEdge < 1)
        .toList();
    if (visible.isEmpty) return;

    final minVisibleIndex = visible
        .map((e) => e.index)
        .reduce((a, b) => math.min(a, b));
    final maxVisibleIndex = visible
        .map((e) => e.index)
        .reduce((a, b) => math.max(a, b));

    final visibleCount = maxVisibleIndex - minVisibleIndex + 1;
    // Preload roughly one viewport of covers around the visible range.
    final extraTotal = math.max(1, visibleCount);
    final extraBefore = extraTotal ~/ 2;
    final extraAfter = extraTotal - extraBefore;

    final nextStart = math.max(0, minVisibleIndex - extraBefore);
    final nextEnd = math.min(
      _displaySongs.length - 1,
      maxVisibleIndex + extraAfter,
    );

    if (nextStart == _coverLoadStart && nextEnd == _coverLoadEnd) return;

    setState(() {
      _coverLoadStart = nextStart;
      _coverLoadEnd = nextEnd;
    });
  }

  int _buildSongsSignature(List<Song> songs) {
    return Object.hash(
      _sortOption,
      Object.hashAll(
        songs.map(
          (song) => Object.hash(
            song.id,
            song.title,
            song.artist,
            song.album,
            song.duration,
            song.created,
            song.starred,
          ),
        ),
      ),
    );
  }

  void _processSongs(List<Song> songs, int signature) {
    if (_sortOption.usesAlphabeticalIndexBar) {
      _azSongs = songs.map((song) {
        final tag = PinyinUtils.getFirstChar(song.title);
        final pinyin = PinyinUtils.getPinyin(song.title);
        return AzItem(data: song, tag: tag, namePinyin: pinyin);
      }).toList();

      SuspensionUtil.sortListBySuspensionTag(_azSongs);
      SuspensionUtil.setShowSuspensionStatus(_azSongs);
      _displaySongs = _azSongs.map((item) => item.data).toList();
    } else {
      _displaySongs = sortSongs(songs, _sortOption);
      _azSongs = const [];
    }
    _songsSignature = signature;
  }

  Future<void> _showSortSheet() async {
    final selected = await showEchoBottomSheet<SongSortOption>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '歌曲排序',
        subtitle: '当前：${_sortOption.label}',
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.62,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: selectableSongSortOptionsWithoutDefault.length,
            itemBuilder: (context, index) {
              final option = selectableSongSortOptionsWithoutDefault[index];
              return EchoActionRow(
                icon: option == _sortOption ? AppIcons.check : AppIcons.sort,
                title: option.label,
                selected: option == _sortOption,
                onPressed: () => Navigator.of(sheetContext).pop(option),
              );
            },
          ),
        ),
      ),
    );
    if (!mounted || selected == null || selected == _sortOption) return;
    setState(() {
      _sortOption = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(allSongsProvider);
    final loadFailed = ref.watch(allSongsLoadFailedProvider);
    final songCount = songsAsync.valueOrNull?.length;

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'song_list_page',
      shouldRetry: (ref) => loadFailed || songsAsync.hasError,
      onRetry: (ref) => ref.invalidate(allSongsProvider),
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '所有歌曲',
          subtitle: songCount == null
              ? _sortOption.label
              : '$songCount 首 · ${_sortOption.label}',
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.sort,
              label: '歌曲排序：${_sortOption.label}',
              onPressed: () => unawaited(_showSortSheet()),
            ),
          ],
        ),
        body: songsAsync.when(
          data: (songs) {
            if (songs.isEmpty) {
              if (loadFailed) {
                return EchoErrorState(
                  title: '歌曲加载失败',
                  description: '请检查网络或服务器状态后重试。',
                  actionLabel: '重试',
                  onAction: () => ref.invalidate(allSongsProvider),
                );
              }
              return const EchoEmptyState(
                title: '暂无歌曲',
                description: '同步音乐库后，歌曲会显示在这里。',
                icon: AppIcons.music,
              );
            }

            final signature = _buildSongsSignature(songs);
            final processedLength = _sortOption.usesAlphabeticalIndexBar
                ? _azSongs.length
                : _displaySongs.length;
            if (signature != _songsSignature ||
                processedLength != songs.length) {
              _processSongs(songs, signature);
            }

            return _buildSongCollection();
          },
          loading: () => const EchoMediaListSkeleton(count: 10),
          error: (error, stackTrace) => EchoErrorState(
            title: '歌曲加载失败',
            description: '请检查网络或服务器状态后重试。',
            actionLabel: '重试',
            onAction: () => ref.invalidate(allSongsProvider),
          ),
        ),
      ),
    );
  }

  Widget _buildSongCollection() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: _sortOption.usesAlphabeticalIndexBar
            ? EchoAzIndexReveal(
                builder: (context, opacity, _) => AzListView(
                  key: const ValueKey<String>('song-list-alphabetical-scroll'),
                  data: _azSongs,
                  itemCount: _azSongs.length,
                  padding: EdgeInsets.only(
                    bottom:
                        context.echoSpacing.xxl +
                        context.echoShellBottomObstruction,
                  ),
                  itemPositionsListener: _itemPositionsListener,
                  itemBuilder: (context, index) => _buildSongListItem(index),
                  indexBarData: SuspensionUtil.getTagIndexList(_azSongs),
                  indexBarWidth: 24,
                  indexBarMargin: EdgeInsetsDirectional.only(
                    end: context.echoSpacing.xxs,
                  ),
                  indexBarOptions: echoIndexBarOptions(
                    context,
                    opacity: opacity,
                  ),
                ),
              )
            : ScrollablePositionedList.builder(
                key: const ValueKey<String>('song-list-sorted-scroll'),
                itemCount: _displaySongs.length,
                padding: EdgeInsets.only(
                  bottom:
                      context.echoSpacing.xxl +
                      context.echoShellBottomObstruction,
                ),
                itemPositionsListener: _itemPositionsListener,
                itemBuilder: (context, index) => _buildSongListItem(index),
              ),
      ),
    );
  }

  Widget _buildSongListItem(int index) {
    final song = _displaySongs[index];
    final shouldLoadCover = index >= _coverLoadStart && index <= _coverLoadEnd;

    return SongListItem(
      song: song,
      index: index,
      variant: SongListItemVariant.standard,
      coverArtId: shouldLoadCover ? song.coverArt : null,
      contentPadding: EdgeInsetsDirectional.fromSTEB(
        context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
        _sortOption.usesAlphabeticalIndexBar
            ? 44
            : context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
      ),
      onTap: () {
        ref
            .read(playerProvider.notifier)
            .playQueue(_displaySongs, startIndex: index);
      },
      onLongPress: () {
        showSongOptionsSheet(context: context, song: song);
      },
    );
  }
}
