import 'dart:math' as math;

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:echoes/widgets/app_back_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../utils/library_sorting.dart';
import '../widgets/auto_hiding_az_list_view.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/music_chrome.dart';
import '../../../widgets/skeleton_templates.dart';
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

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(allSongsProvider);
    final loadFailed = ref.watch(allSongsLoadFailedProvider);

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'song_list_page',
      shouldRetry: (ref) => loadFailed || songsAsync.hasError,
      onRetry: (ref) => ref.invalidate(allSongsProvider),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('所有歌曲'),
          actions: [
            MusicSortButton<SongSortOption>(
              title: '歌曲排序',
              value: _sortOption,
              options: selectableSongSortOptionsWithoutDefault,
              labelBuilder: (option) => option.label,
              onSelected: (option) {
                if (option == _sortOption) return;
                setState(() {
                  _sortOption = option;
                });
              },
            ),
          ],
        ),
        body: songsAsync.when(
          data: (songs) {
            if (songs.isEmpty) {
              return Center(child: Text(loadFailed ? '网络异常，歌曲加载失败' : '暂无歌曲'));
            }

            final signature = _buildSongsSignature(songs);
            final processedLength = _sortOption.usesAlphabeticalIndexBar
                ? _azSongs.length
                : _displaySongs.length;
            if (signature != _songsSignature ||
                processedLength != songs.length) {
              _processSongs(songs, signature);
            }

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: _sortOption.usesAlphabeticalIndexBar
                    ? AutoHidingAzListView(
                        data: _azSongs,
                        itemCount: _azSongs.length,
                        itemPositionsListener: _itemPositionsListener,
                        itemBuilder: (context, index) =>
                            _buildSongListItem(index),
                        indexBarData: SuspensionUtil.getTagIndexList(_azSongs),
                      )
                    : ScrollablePositionedList.builder(
                        itemCount: _displaySongs.length,
                        itemPositionsListener: _itemPositionsListener,
                        itemBuilder: (context, index) =>
                            _buildSongListItem(index),
                      ),
              ),
            );
          },
          loading: () => const ListTileSkeleton(count: 10),
          error: (err, stack) =>
              const ErrorPlaceholder(message: '歌曲加载失败，请检查网络后重试'),
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
