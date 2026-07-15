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
  Timer? _indexBarHideTimer;
  bool _showIndexBar = false;
  bool _isIndexBarPointerActive = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener = ItemPositionsListener.create();
    _itemPositionsListener.itemPositions.addListener(_onItemPositionsChanged);
  }

  @override
  void dispose() {
    _indexBarHideTimer?.cancel();
    _itemPositionsListener.itemPositions.removeListener(
      _onItemPositionsChanged,
    );
    super.dispose();
  }

  void _showIndexBarTemporarily() {
    if (!mounted || !_sortOption.usesAlphabeticalIndexBar) return;

    _indexBarHideTimer?.cancel();
    if (!_showIndexBar) {
      setState(() {
        _showIndexBar = true;
      });
    }

    if (_isIndexBarPointerActive) return;
    _indexBarHideTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _showIndexBar = false;
      });
    });
  }

  void _handleIndexBarPointerDown(PointerDownEvent event, double width) {
    if (!_sortOption.usesAlphabeticalIndexBar) return;
    if (event.localPosition.dx < width - 36) return;

    _indexBarHideTimer?.cancel();
    _isIndexBarPointerActive = true;
    if (!_showIndexBar) {
      setState(() {
        _showIndexBar = true;
      });
    }
  }

  void _handleIndexBarPointerEnd() {
    if (!_isIndexBarPointerActive) return;
    _isIndexBarPointerActive = false;
    _showIndexBarTemporarily();
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
    _indexBarHideTimer?.cancel();
    setState(() {
      _sortOption = selected;
      _showIndexBar = false;
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
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Listener(
                    onPointerDown: (event) =>
                        _handleIndexBarPointerDown(event, constraints.maxWidth),
                    onPointerUp: (_) => _handleIndexBarPointerEnd(),
                    onPointerCancel: (_) => _handleIndexBarPointerEnd(),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification ||
                            notification is ScrollUpdateNotification ||
                            notification is UserScrollNotification) {
                          _showIndexBarTemporarily();
                        }
                        return false;
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(end: _showIndexBar ? 1 : 0),
                        duration: context.echoMotion.resolve(
                          context,
                          context.echoMotion.feedback,
                        ),
                        curve: context.echoMotion.easeOut,
                        builder: (context, opacity, child) {
                          final visible = opacity > 0.01;
                          return AzListView(
                            data: _azSongs,
                            itemCount: _azSongs.length,
                            itemPositionsListener: _itemPositionsListener,
                            itemBuilder: (context, index) =>
                                _buildSongListItem(index),
                            indexBarData: SuspensionUtil.getTagIndexList(
                              _azSongs,
                            ),
                            indexBarWidth: visible ? 22 : 0,
                            indexBarHeight: visible ? null : 0,
                            indexBarMargin: EdgeInsetsDirectional.only(
                              end: visible ? context.echoSpacing.xxs : 0,
                            ),
                            indexBarOptions: _songIndexBarOptions(opacity),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            : ScrollablePositionedList.builder(
                itemCount: _displaySongs.length,
                itemPositionsListener: _itemPositionsListener,
                itemBuilder: (context, index) => _buildSongListItem(index),
              ),
      ),
    );
  }

  IndexBarOptions _songIndexBarOptions(double opacity) {
    final colors = context.echoColors;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final metadataSize =
        (context.echoTypography.metadata.fontSize ?? 13) / textScale;
    final hintSize =
        (context.echoTypography.headline.fontSize ?? 24) / textScale;
    return IndexBarOptions(
      needRebuild: true,
      ignoreDragCancel: true,
      decoration: BoxDecoration(
        color: colors.ink.withValues(alpha: 0.58 * opacity),
        borderRadius: context.echoRadii.pill,
      ),
      downDecoration: BoxDecoration(
        color: colors.ink.withValues(alpha: 0.72 * opacity),
        borderRadius: context.echoRadii.pill,
      ),
      textStyle: context.echoTypography.metadata.copyWith(
        fontSize: metadataSize,
        height: 1,
        color: colors.canvas.withValues(alpha: opacity),
      ),
      downTextStyle: context.echoTypography.metadata.copyWith(
        fontSize: metadataSize,
        height: 1,
        fontWeight: FontWeight.w700,
        color: colors.canvas.withValues(alpha: opacity),
      ),
      downItemDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.canvas.withValues(alpha: 0.24 * opacity),
      ),
      indexHintWidth: 60,
      indexHintHeight: 50,
      indexHintDecoration: BoxDecoration(
        color: colors.ink.withValues(alpha: 0.88),
        borderRadius: context.echoRadii.control,
      ),
      indexHintTextStyle: context.echoTypography.headline.copyWith(
        fontSize: hintSize,
        color: colors.canvas,
      ),
      indexHintAlignment: Alignment.centerRight,
      indexHintChildAlignment: const Alignment(-0.25, 0),
      indexHintOffset: const Offset(-20, 0),
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
