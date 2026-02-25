import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/album.dart';
import '../../../providers/playback_stats_provider.dart';
import '../../../widgets/cover_art_image.dart';

class PlaybackStatsPage extends ConsumerWidget {
  const PlaybackStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(playbackStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('统计信息')),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  const Text('统计加载失败'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => ref.invalidate(playbackStatsProvider),
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (stats) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(playbackStatsProvider);
              await ref.read(playbackStatsProvider.future);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionTitle(context, '库总览'),
                _buildStatsGrid(context, [
                  _StatItem(
                    icon: Icons.music_note_outlined,
                    label: '歌曲总数',
                    value: _formatInteger(stats.totalSongs),
                  ),
                  _StatItem(
                    icon: Icons.album_outlined,
                    label: '专辑总数',
                    value: _formatInteger(stats.totalAlbums),
                  ),
                  _StatItem(
                    icon: Icons.person_outline,
                    label: '歌手总数',
                    value: _formatInteger(stats.totalArtists),
                  ),
                  _StatItem(
                    icon: Icons.schedule_outlined,
                    label: '曲库总时长',
                    value: _formatDuration(stats.totalSongDurationSeconds),
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '播放总览'),
                _buildStatsGrid(context, [
                  _StatItem(
                    icon: Icons.equalizer_outlined,
                    label: '总播放次数',
                    value: _formatInteger(stats.totalPlayCount),
                  ),
                  _StatItem(
                    icon: Icons.library_music_outlined,
                    label: '有播放记录歌曲',
                    value: _formatInteger(stats.playedSongsCount),
                  ),
                  _StatItem(
                    icon: Icons.timer_outlined,
                    label: '估算累计播放时长',
                    value: _formatDuration(
                      stats.estimatedPlayedDurationSeconds,
                    ),
                  ),
                  _StatItem(
                    icon: Icons.auto_graph_outlined,
                    label: '平均每首播放次数',
                    value: stats.averagePlayCountPerSong.toStringAsFixed(2),
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '收藏统计'),
                _buildStatsGrid(context, [
                  _StatItem(
                    icon: Icons.favorite_outline,
                    label: '收藏歌曲',
                    value: _formatInteger(stats.starredSongCount),
                  ),
                  _StatItem(
                    icon: Icons.collections_bookmark_outlined,
                    label: '收藏专辑',
                    value: _formatInteger(stats.starredAlbumCount),
                  ),
                  _StatItem(
                    icon: Icons.people_outline,
                    label: '收藏歌手',
                    value: _formatInteger(stats.starredArtistCount),
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '缓存统计'),
                _buildStatsGrid(context, [
                  _StatItem(
                    icon: Icons.storage_outlined,
                    label: '缓存条目',
                    value: _formatInteger(stats.cacheEntryCount),
                  ),
                  _StatItem(
                    icon: Icons.music_video_outlined,
                    label: '缓存歌曲',
                    value: _formatInteger(stats.cacheSongCount),
                  ),
                  _StatItem(
                    icon: Icons.sd_storage_outlined,
                    label: '缓存大小',
                    value: _formatBytes(stats.cacheTotalBytes),
                  ),
                  _StatItem(
                    icon: Icons.shield_outlined,
                    label: '受保护缓存条目',
                    value: _formatInteger(stats.cacheProtectedEntryCount),
                    subtitle: '播放次数 >= $cacheProtectionThreshold',
                  ),
                  _StatItem(
                    icon: Icons.touch_app_outlined,
                    label: '缓存命中次数',
                    value: _formatInteger(stats.cachePlayCount),
                  ),
                  _StatItem(
                    icon: Icons.network_check_outlined,
                    label: '移动网络节省流量',
                    value: _formatBytes(stats.cacheSavedTrafficBytes),
                    subtitle: '仅统计移动网络缓存命中',
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '最多播放歌曲'),
                _buildTopSongsCard(stats.topSongs),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '最多播放歌手'),
                _buildTopArtistsCard(stats.topArtists),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '最多播放专辑'),
                _buildTopAlbumsCard(stats.topAlbums),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '最近播放专辑'),
                _buildAlbumChipsCard(stats.recentAlbums, emptyText: '暂无最近播放专辑'),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '常听专辑'),
                _buildAlbumChipsCard(stats.frequentAlbums, emptyText: '暂无常听专辑'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, List<_StatItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(item.icon, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (item.subtitle != null)
                  Text(
                    item.subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopSongsCard(List<SongPlayStat> topSongs) {
    if (topSongs.isEmpty) {
      return const _EmptyCard(message: '暂无歌曲播放记录');
    }

    return Card(
      child: Column(
        children: [
          for (var i = 0; i < topSongs.length; i++)
            ListTile(
              leading: SizedBox(
                width: 74,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Text(
                        '${i + 1}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CoverArtImage(
                        coverArtId: topSongs[i].song.coverArt,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                topSongs[i].song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                _buildSongSubtitle(topSongs[i]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text('${_formatInteger(topSongs[i].playCount)} 次'),
            ),
        ],
      ),
    );
  }

  Widget _buildTopArtistsCard(List<ArtistPlayStat> topArtists) {
    if (topArtists.isEmpty) {
      return const _EmptyCard(message: '暂无歌手播放记录');
    }

    return Card(
      child: Column(
        children: [
          for (var i = 0; i < topArtists.length; i++)
            ListTile(
              leading: SizedBox(
                width: 22,
                child: Text(
                  '${i + 1}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              title: Text(
                topArtists[i].artistName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('${_formatInteger(topArtists[i].songCount)} 首歌曲'),
              trailing: Text('${_formatInteger(topArtists[i].playCount)} 次'),
            ),
        ],
      ),
    );
  }

  Widget _buildTopAlbumsCard(List<AlbumPlayStat> topAlbums) {
    if (topAlbums.isEmpty) {
      return const _EmptyCard(message: '暂无专辑播放记录');
    }

    return Card(
      child: Column(
        children: [
          for (var i = 0; i < topAlbums.length; i++)
            ListTile(
              leading: SizedBox(
                width: 74,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Text(
                        '${i + 1}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CoverArtImage(
                        coverArtId: topAlbums[i].coverArtId,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                topAlbums[i].albumName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${topAlbums[i].artistName ?? '未知歌手'} · ${_formatInteger(topAlbums[i].songCount)} 首歌曲',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text('${_formatInteger(topAlbums[i].playCount)} 次'),
            ),
        ],
      ),
    );
  }

  Widget _buildAlbumChipsCard(List<Album> albums, {required String emptyText}) {
    if (albums.isEmpty) {
      return _EmptyCard(message: emptyText);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: albums.take(16).map((album) {
            return Chip(
              avatar: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CoverArtImage(coverArtId: album.coverArt, size: 20),
              ),
              label: Text(album.name, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _buildSongSubtitle(SongPlayStat stat) {
    final artist = stat.song.artist?.trim();
    final album = stat.song.album?.trim();
    if (artist != null &&
        artist.isNotEmpty &&
        album != null &&
        album.isNotEmpty) {
      return '$artist · $album';
    }
    if (artist != null && artist.isNotEmpty) {
      return artist;
    }
    if (album != null && album.isNotEmpty) {
      return album;
    }
    return '未知';
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
}

String _formatInteger(num value) {
  final rounded = value.round();
  final negative = rounded < 0;
  var digits = rounded.abs().toString();
  final chunks = <String>[];
  while (digits.length > 3) {
    chunks.insert(0, digits.substring(digits.length - 3));
    digits = digits.substring(0, digits.length - 3);
  }
  chunks.insert(0, digits);
  return '${negative ? '-' : ''}${chunks.join(',')}';
}

String _formatDuration(int seconds) {
  if (seconds <= 0) return '0 分';
  final hours = seconds ~/ Duration.secondsPerHour;
  final minutes =
      (seconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;

  if (hours > 0) return '$hours 小时 $minutes 分';
  return '$minutes 分';
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes 字节';
  final kb = bytes / 1024;
  if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
  final mb = kb / 1024;
  if (mb < 1024) return '${mb.toStringAsFixed(1)} MB';
  final gb = mb / 1024;
  return '${gb.toStringAsFixed(2)} GB';
}
