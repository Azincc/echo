import 'package:echo/data/models/music_library.dart';
import 'package:echo/data/models/server_address.dart';
import 'package:echo/data/repositories/library_repository.dart';
import 'package:echo/data/sources/database/database_provider.dart';
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
      a.isActive != b.isActive ||
      a.addresses.length != b.addresses.length) {
    return false;
  }
  for (int i = 0; i < a.addresses.length; i++) {
    if (!_addressKeyFieldsEqual(a.addresses[i], b.addresses[i])) {
      return false;
    }
  }
  return true;
}

MusicLibrary? _lastActiveLibrary;

final activeLibraryProvider = Provider<MusicLibrary?>((ref) {
  final asyncLibraries = ref.watch(librariesProvider);
  return asyncLibraries.when(
    data: (libs) {
      if (libs.isEmpty) {
        _lastActiveLibrary = null;
        return null;
      }
      MusicLibrary? current;
      try {
        current = libs.firstWhere((l) => l.isActive);
      } catch (_) {
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

      _lastActiveLibrary = current;
      return current;
    },
    error: (error, stackTrace) => null,
    loading: () => null,
  );
});
