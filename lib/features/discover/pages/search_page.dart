import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/music_chrome.dart';
import '../../../widgets/skeleton_templates.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';
import '../../player/widgets/song_options_sheet.dart';

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
    final normalized = query.trim();
    setState(() => _query = normalized);
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
        if (_query.isEmpty) return;
        ref.invalidate(searchProvider(_query));
      },
      child: Scaffold(
        body: MusicGradientBackdrop(
          child: SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: MusicChrome.maxContentWidth,
                ),
                child: Column(
                  children: [
                    MusicPageHeader(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
                      title: '搜索',
                      subtitle: '查找资料库里的歌曲、专辑和歌手',
                      leading: MusicIconButton(
                        icon: AppIcons.arrow_back_ios_new,
                        tooltip: '返回',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      child: _buildSearchField(context),
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: _query.isEmpty
                            ? _buildEmptyState(context)
                            : searchResultAsync!.when(
                                data: (result) {
                                  if (result.isEmpty) {
                                    if (searchLoadFailed) {
                                      return ErrorPlaceholder(
                                        message: '搜索失败，请检查网络后重试',
                                        onRetry: () => ref.invalidate(
                                          searchProvider(_query),
                                        ),
                                      );
                                    }
                                    return _buildEmptyState(
                                      context,
                                      icon: AppIcons.search_off,
                                      title: '未找到 “$_query”',
                                      subtitle: '换个关键词再试试',
                                    );
                                  }
                                  return _buildResults(context, result);
                                },
                                loading: () => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: MusicGlassSurface(
                                    borderRadius: MusicChrome.largeRadius,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    child: ListTileSkeleton(count: 5),
                                  ),
                                ),
                                error: (error, stack) => ErrorPlaceholder(
                                  message: '搜索失败，请检查网络后重试',
                                  onRetry: () =>
                                      ref.invalidate(searchProvider(_query)),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);
    return MusicGlassSurface(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Icon(
            AppIcons.search,
            size: 21,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: '搜索歌曲、专辑、歌手',
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: _performSearch,
            ),
          ),
          if (_searchController.text.isNotEmpty || _query.isNotEmpty)
            IconButton(
              tooltip: '清除',
              icon: const Icon(AppIcons.clear),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context, {
    IconData icon = AppIcons.search,
    String title = '搜索你喜欢的音乐',
    String subtitle = '输入关键词后按下搜索',
  }) {
    final theme = Theme.of(context);
    return Center(
      key: ValueKey('empty-$title'),
      child: MusicGlassSurface(
        borderRadius: BorderRadius.circular(28),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 54, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context, dynamic result) {
    return ListView(
      key: ValueKey('results-$_query'),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      children: [
        if (result.songs.isNotEmpty) ...[
          _sectionHeader(
            context,
            AppIcons.music_note,
            '歌曲',
            result.songs.length,
          ),
          MusicGlassSurface(
            borderRadius: MusicChrome.largeRadius,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: result.songs.asMap().entries.map<Widget>((entry) {
                final index = entry.key;
                final song = entry.value;
                return SongListItem(
                  song: song,
                  index: index,
                  variant: SongListItemVariant.standard,
                  onTap: () {
                    ref
                        .read(playerProvider.notifier)
                        .playQueue(result.songs, startIndex: index);
                  },
                  onLongPress: () {
                    showSongOptionsSheet(context: context, song: song);
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 22),
        ],
        if (result.albums.isNotEmpty) ...[
          _sectionHeader(context, AppIcons.album, '专辑', result.albums.length),
          MusicGlassSurface(
            borderRadius: MusicChrome.largeRadius,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: result.albums.map<Widget>((album) {
                return _albumTile(context, album);
              }).toList(),
            ),
          ),
          const SizedBox(height: 22),
        ],
        if (result.artists.isNotEmpty) ...[
          _sectionHeader(context, AppIcons.person, '歌手', result.artists.length),
          MusicGlassSurface(
            borderRadius: MusicChrome.largeRadius,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: result.artists.map<Widget>((artist) {
                return _artistTile(context, artist);
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    IconData icon,
    String title,
    int count,
  ) {
    return MusicSectionHeader(
      title: '$title ($count)',
      actions: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
      ],
    );
  }

  Widget _albumTile(BuildContext context, dynamic album) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: ClipRRect(
        borderRadius: MusicChrome.albumRadius,
        child: CoverArtImage(coverArtId: album.coverArt, size: 52),
      ),
      title: Text(
        album.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: album.artist != null
          ? Text(album.artist!, maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
      trailing: Text(
        '${album.songCount} 首',
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumDetailPage(albumId: album.id),
          ),
        );
      },
    );
  }

  Widget _artistTile(BuildContext context, dynamic artist) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
        child: artist.coverArt != null
            ? ClipOval(
                child: CoverArtImage(coverArtId: artist.coverArt, size: 44),
              )
            : Icon(AppIcons.person, color: theme.colorScheme.primary),
      ),
      title: Text(
        artist.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text('${artist.albumCount} 张专辑'),
      trailing: const Icon(AppIcons.chevron_right, size: 18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtistDetailPage(artistId: artist.id),
          ),
        );
      },
    );
  }
}
