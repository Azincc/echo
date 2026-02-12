import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../utils/az_item.dart';
import '../../../utils/pinyin_helper.dart';

class SongListPage extends ConsumerStatefulWidget {
  const SongListPage({super.key});

  @override
  ConsumerState<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends ConsumerState<SongListPage> {
  List<AzItem<Song>> _azSongs = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      appBar: AppBar(title: const Text('所有歌曲')),
      body: songsAsync.when(
        data: (songs) {
          if (songs.isEmpty) {
            return const Center(child: Text('暂无歌曲'));
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
            itemBuilder: (context, index) {
              final item = _azSongs[index];
              final song = item.data;
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artist ?? '未知歌手'),
                leading: Text(
                  item.getSuspensionTag(),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ), // Debug/Optional: show tag
                onTap: () {
                  // Play song
                  // ref.read(playerProvider.notifier).play(song);
                  // TODO: Implement playback logic based on existing app patterns
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
