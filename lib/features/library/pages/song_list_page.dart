import 'dart:math' as math;

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';
import '../../../widgets/cover_art_image.dart';

class SongListPage extends ConsumerStatefulWidget {
  const SongListPage({super.key});

  @override
  ConsumerState<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends ConsumerState<SongListPage> {
  static const double _tileLeadingSize = 48;
  List<AzItem<Song>> _azSongs = [];
  bool _isLoaded = false;
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
    if (!mounted || _azSongs.isEmpty) return;
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    // 只统计当前可见项（进入 viewport 的条目）。
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
    // 预加载可见数量的 100%，总计约 200%。
    final extraTotal = math.max(1, visibleCount);
    final extraBefore = extraTotal ~/ 2;
    final extraAfter = extraTotal - extraBefore;

    final nextStart = math.max(0, minVisibleIndex - extraBefore);
    final nextEnd = math.min(_azSongs.length - 1, maxVisibleIndex + extraAfter);

    if (nextStart == _coverLoadStart && nextEnd == _coverLoadEnd) return;

    setState(() {
      _coverLoadStart = nextStart;
      _coverLoadEnd = nextEnd;
    });
  }

  void _processSongs(List<Song> songs) {
    if (_isLoaded) return;

    // Run in isolate or just standard if list is small?
    // For thousands of songs, this might block UI.
    // For now, let's do it synchronously but maybe delay it slightly or just do it.
    // Ideally put in compute().

    _azSongs = songs.map((song) {
      String tag = PinyinUtils.getFirstChar(song.title);
      String pinyin = PinyinUtils.getPinyin(song.title);
      return AzItem(data: song, tag: tag, namePinyin: pinyin);
    }).toList();

    // Sort
    SuspensionUtil.sortListBySuspensionTag(_azSongs);

    // Show suspension tag logic
    SuspensionUtil.setShowSuspensionStatus(_azSongs);

    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final songsAsync = ref.watch(allSongsProvider);
    final loadFailed = ref.watch(allSongsLoadFailedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('所有歌曲')),
      body: songsAsync.when(
        data: (songs) {
          if (songs.isEmpty) {
            return Center(child: Text(loadFailed ? '网络异常，歌曲加载失败' : '暂无歌曲'));
          }

          // Generate AZ list if not ready or if list changed (simple check)
          // Ideally we accept the list passed in or use a provider that does this processing.
          // For now, let's process it here.
          if (!_isLoaded || _azSongs.length != songs.length) {
            _processSongs(songs);
          }

          return AzListView(
            data: _azSongs,
            itemCount: _azSongs.length,
            itemPositionsListener: _itemPositionsListener,
            itemBuilder: (context, index) {
              final item = _azSongs[index];
              final song = item.data;
              final shouldLoadCover =
                  index >= _coverLoadStart && index <= _coverLoadEnd;

              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artist ?? '未知歌手'),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CoverArtImage(
                    coverArtId: shouldLoadCover ? song.coverArt : null,
                    size: _tileLeadingSize,
                  ),
                ),
                onTap: () {
                  final queue = _azSongs.map((e) => e.data).toList();
                  ref
                      .read(playerProvider.notifier)
                      .playQueue(queue, startIndex: index);
                },
              );
            },
            // Index Bar setup
            indexBarData: SuspensionUtil.getTagIndexList(_azSongs),
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
