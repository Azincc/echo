import '../../../data/models/playlist.dart';
import '../../../data/models/song.dart';
import '../../../utils/pinyin_helper.dart';

enum SongSortOption {
  defaultOrder,
  alphabeticalAsc,
  alphabeticalDesc,
  durationAsc,
  durationDesc,
  updatedAsc,
  updatedDesc,
}

const selectableSongSortOptions = <SongSortOption>[
  SongSortOption.defaultOrder,
  SongSortOption.alphabeticalAsc,
  SongSortOption.alphabeticalDesc,
  SongSortOption.durationAsc,
  SongSortOption.durationDesc,
  SongSortOption.updatedAsc,
  SongSortOption.updatedDesc,
];

const selectableSongSortOptionsWithoutDefault = <SongSortOption>[
  SongSortOption.alphabeticalAsc,
  SongSortOption.alphabeticalDesc,
  SongSortOption.durationAsc,
  SongSortOption.durationDesc,
  SongSortOption.updatedAsc,
  SongSortOption.updatedDesc,
];

extension SongSortOptionX on SongSortOption {
  String get label {
    switch (this) {
      case SongSortOption.defaultOrder:
        return '默认顺序';
      case SongSortOption.alphabeticalAsc:
        return '字母 A-Z';
      case SongSortOption.alphabeticalDesc:
        return '字母 Z-A';
      case SongSortOption.durationAsc:
        return '时长从短到长';
      case SongSortOption.durationDesc:
        return '时长从长到短';
      case SongSortOption.updatedAsc:
        return '时间从旧到新';
      case SongSortOption.updatedDesc:
        return '时间从新到旧';
    }
  }

  bool get usesAlphabeticalIndexBar => this == SongSortOption.alphabeticalAsc;
}

List<Song> sortSongs(List<Song> songs, SongSortOption option) {
  if (songs.length < 2 || option == SongSortOption.defaultOrder) {
    return List<Song>.of(songs);
  }

  final sorted = List<Song>.of(songs);
  sorted.sort((left, right) {
    switch (option) {
      case SongSortOption.defaultOrder:
        return 0;
      case SongSortOption.alphabeticalAsc:
        return _compareSongAlphabetically(left, right);
      case SongSortOption.alphabeticalDesc:
        return _compareDescendingBy(
          _compareSongAlphabetically(left, right),
          fallback: () => 0,
        );
      case SongSortOption.durationAsc:
        return _compareAscending(
          left.duration ?? -1,
          right.duration ?? -1,
          fallback: () => _compareSongAlphabetically(left, right),
        );
      case SongSortOption.durationDesc:
        return _compareDescending(
          left.duration ?? -1,
          right.duration ?? -1,
          fallback: () => _compareSongAlphabetically(left, right),
        );
      case SongSortOption.updatedAsc:
        return _compareAscending(
          left.created?.millisecondsSinceEpoch ?? -1,
          right.created?.millisecondsSinceEpoch ?? -1,
          fallback: () => _compareSongAlphabetically(left, right),
        );
      case SongSortOption.updatedDesc:
        return _compareDescending(
          left.created?.millisecondsSinceEpoch ?? -1,
          right.created?.millisecondsSinceEpoch ?? -1,
          fallback: () => _compareSongAlphabetically(left, right),
        );
    }
  });
  return sorted;
}

enum PlaylistSortOption {
  defaultOrder,
  alphabeticalAsc,
  alphabeticalDesc,
  durationAsc,
  durationDesc,
  updatedAsc,
  updatedDesc,
}

const selectablePlaylistSortOptions = <PlaylistSortOption>[
  PlaylistSortOption.defaultOrder,
  PlaylistSortOption.alphabeticalAsc,
  PlaylistSortOption.alphabeticalDesc,
  PlaylistSortOption.durationAsc,
  PlaylistSortOption.durationDesc,
  PlaylistSortOption.updatedAsc,
  PlaylistSortOption.updatedDesc,
];

extension PlaylistSortOptionX on PlaylistSortOption {
  String get label {
    switch (this) {
      case PlaylistSortOption.defaultOrder:
        return '默认顺序';
      case PlaylistSortOption.alphabeticalAsc:
        return '字母 A-Z';
      case PlaylistSortOption.alphabeticalDesc:
        return '字母 Z-A';
      case PlaylistSortOption.durationAsc:
        return '时长从短到长';
      case PlaylistSortOption.durationDesc:
        return '时长从长到短';
      case PlaylistSortOption.updatedAsc:
        return '更新时间从旧到新';
      case PlaylistSortOption.updatedDesc:
        return '更新时间从新到旧';
    }
  }
}

List<Playlist> sortPlaylists(
  List<Playlist> playlists,
  PlaylistSortOption option,
) {
  if (playlists.length < 2 || option == PlaylistSortOption.defaultOrder) {
    return List<Playlist>.of(playlists);
  }

  final sorted = List<Playlist>.of(playlists);
  sorted.sort((left, right) {
    switch (option) {
      case PlaylistSortOption.defaultOrder:
        return 0;
      case PlaylistSortOption.alphabeticalAsc:
        return _comparePlaylistAlphabetically(left, right);
      case PlaylistSortOption.alphabeticalDesc:
        return _compareDescendingBy(
          _comparePlaylistAlphabetically(left, right),
          fallback: () => 0,
        );
      case PlaylistSortOption.durationAsc:
        return _compareAscending(
          left.duration,
          right.duration,
          fallback: () => _comparePlaylistAlphabetically(left, right),
        );
      case PlaylistSortOption.durationDesc:
        return _compareDescending(
          left.duration,
          right.duration,
          fallback: () => _comparePlaylistAlphabetically(left, right),
        );
      case PlaylistSortOption.updatedAsc:
        return _compareAscending(
          left.changed?.millisecondsSinceEpoch ??
              left.created?.millisecondsSinceEpoch ??
              -1,
          right.changed?.millisecondsSinceEpoch ??
              right.created?.millisecondsSinceEpoch ??
              -1,
          fallback: () => _comparePlaylistAlphabetically(left, right),
        );
      case PlaylistSortOption.updatedDesc:
        return _compareDescending(
          left.changed?.millisecondsSinceEpoch ??
              left.created?.millisecondsSinceEpoch ??
              -1,
          right.changed?.millisecondsSinceEpoch ??
              right.created?.millisecondsSinceEpoch ??
              -1,
          fallback: () => _comparePlaylistAlphabetically(left, right),
        );
    }
  });
  return sorted;
}

int _compareSongAlphabetically(Song left, Song right) {
  return _compareAlphabetically(
    primaryLeft: left.title,
    primaryRight: right.title,
    secondaryLeft: left.artist,
    secondaryRight: right.artist,
  );
}

int _comparePlaylistAlphabetically(Playlist left, Playlist right) {
  return _compareAlphabetically(
    primaryLeft: left.name,
    primaryRight: right.name,
    secondaryLeft: left.owner,
    secondaryRight: right.owner,
  );
}

int _compareAlphabetically({
  required String primaryLeft,
  required String primaryRight,
  String? secondaryLeft,
  String? secondaryRight,
}) {
  final leftPinyin = PinyinUtils.getPinyin(primaryLeft).toLowerCase();
  final rightPinyin = PinyinUtils.getPinyin(primaryRight).toLowerCase();
  final primaryResult = leftPinyin.compareTo(rightPinyin);
  if (primaryResult != 0) return primaryResult;

  final leftRaw = primaryLeft.toLowerCase();
  final rightRaw = primaryRight.toLowerCase();
  final rawResult = leftRaw.compareTo(rightRaw);
  if (rawResult != 0) return rawResult;

  final leftSecondary = (secondaryLeft ?? '').toLowerCase();
  final rightSecondary = (secondaryRight ?? '').toLowerCase();
  return leftSecondary.compareTo(rightSecondary);
}

int _compareDescending(
  int left,
  int right, {
  required int Function() fallback,
}) {
  final result = right.compareTo(left);
  if (result != 0) return result;
  return fallback();
}

int _compareAscending(int left, int right, {required int Function() fallback}) {
  final result = left.compareTo(right);
  if (result != 0) return result;
  return fallback();
}

int _compareDescendingBy(
  int comparisonResult, {
  required int Function() fallback,
}) {
  if (comparisonResult != 0) return -comparisonResult;
  return fallback();
}
