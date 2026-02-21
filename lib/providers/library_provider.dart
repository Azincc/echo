import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/data/repositories/library_repository.dart';
import 'package:echoes/data/sources/database/database_provider.dart';
import 'package:echoes/core/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LibraryRepository(db);
});

final librariesProvider = StreamProvider<List<MusicLibrary>>((ref) {
  final repo = ref.watch(libraryRepositoryProvider);
  return repo.watchLibraries();
});

/// 比较两个 ServerAddress 的关键字段（忽略 latency/status 等探测数据）
bool _addressKeyFieldsEqual(ServerAddress a, ServerAddress b) {
  return a.id == b.id &&
      a.libraryId == b.libraryId &&
      a.label == b.label &&
      a.url == b.url &&
      a.priority == b.priority &&
      a.isLocked == b.isLocked;
}

/// 比较两个 MusicLibrary 的关键字段（忽略 addresses 中的 latency/status 和 updatedAt）
bool _libraryKeyFieldsEqual(MusicLibrary a, MusicLibrary b) {
  if (a.id != b.id ||
      a.name != b.name ||
      a.authType != b.authType ||
      a.username != b.username ||
      a.password != b.password ||
      a.apiKey != b.apiKey ||
      a.serverType != b.serverType ||
      a.serverVersion != b.serverVersion ||
      a.isOpenSubsonic != b.isOpenSubsonic ||
      a.isActive != b.isActive ||
      a.addresses.length != b.addresses.length) {
    return false;
  }
  if (!_deepEquals(a.extensions, b.extensions)) {
    return false;
  }
  for (int i = 0; i < a.addresses.length; i++) {
    if (!_addressKeyFieldsEqual(a.addresses[i], b.addresses[i])) {
      return false;
    }
  }
  return true;
}

bool _deepEquals(Object? a, Object? b) {
  if (identical(a, b)) return true;
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || !_deepEquals(a[key], b[key])) {
        return false;
      }
    }
    return true;
  }
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!_deepEquals(a[i], b[i])) {
        return false;
      }
    }
    return true;
  }
  return a == b;
}

MusicLibrary? _lastActiveLibrary;

final activeLibraryProvider = Provider<MusicLibrary?>((ref) {
  final asyncLibraries = ref.watch(librariesProvider);
  return asyncLibraries.when(
    data: (libs) {
      if (libs.isEmpty) {
        if (_lastActiveLibrary != null) {
          Logger.infoWithTag('LIBRARY', 'no libraries available');
        }
        _lastActiveLibrary = null;
        return null;
      }
      MusicLibrary? current;
      try {
        current = libs.firstWhere((l) => l.isActive);
      } catch (_) {
        Logger.warnWithTag(
          'LIBRARY',
          'no active library flag found, fallback to first library',
        );
        current = libs.isNotEmpty ? libs.first : null;
      }

      if (current == null) {
        _lastActiveLibrary = null;
        return null;
      }

      // 只在关键字段变化时才返回新对象，避免 latency/status 变化触发下游重建
      if (_lastActiveLibrary != null &&
          _libraryKeyFieldsEqual(_lastActiveLibrary!, current)) {
        return _lastActiveLibrary;
      }

      if (_lastActiveLibrary?.id != current.id) {
        Logger.infoWithTag('LIBRARY', 'active library -> ${current.name}');
      }
      _lastActiveLibrary = current;
      return current;
    },
    error: (error, stackTrace) {
      Logger.errorWithTag(
        'LIBRARY',
        'watch libraries failed',
        error,
        stackTrace,
      );
      return null;
    },
    loading: () => null,
  );
});
