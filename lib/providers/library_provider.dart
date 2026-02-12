import 'package:echo/data/models/music_library.dart';
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

final activeLibraryProvider = Provider<MusicLibrary?>((ref) {
  final asyncLibraries = ref.watch(librariesProvider);
  return asyncLibraries.when(
    data: (libs) {
      if (libs.isEmpty) return null;
      try {
        return libs.firstWhere((l) => l.isActive);
      } catch (_) {
        // If none active, maybe return first?
        // Or null, indicating no active library selected.
        return libs.isNotEmpty ? libs.first : null;
      }
    },
    error: (error, stackTrace) => null,
    loading: () => null,
  );
});
