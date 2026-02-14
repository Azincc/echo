import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/music_libraries_table.dart';
import 'tables/server_addresses_table.dart';
import 'tables/lyrics_provider_configs_table.dart';
import 'tables/cover_provider_configs_table.dart';
import 'tables/lyrics_cache_table.dart';
import 'tables/download_tasks_table.dart';
import 'tables/audio_cache_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    MusicLibraries,
    ServerAddresses,
    LyricsProviderConfigs,
    CoverProviderConfigs,
    LyricsCache,
    DownloadTasks,
    AudioCacheEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _insertDefaultProviderConfigs();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(lyricsProviderConfigs);
        await m.createTable(coverProviderConfigs);
        await m.createTable(lyricsCache);
        await _insertDefaultProviderConfigs();
      }
      if (from < 3) {
        await m.createTable(downloadTasks);
        await m.createTable(audioCacheEntries);
      }
    },
  );

  Future<void> _insertDefaultProviderConfigs() async {
    final lyricsDefaults = [
      LyricsProviderConfigsCompanion.insert(
        id: 'lyrics_subsonic',
        sourceId: 'subsonic',
        priority: 0,
      ),
      LyricsProviderConfigsCompanion.insert(
        id: 'lyrics_lrclib',
        sourceId: 'lrclib',
        priority: 1,
      ),
      LyricsProviderConfigsCompanion.insert(
        id: 'lyrics_netease',
        sourceId: 'netease',
        priority: 2,
      ),
    ];

    for (final config in lyricsDefaults) {
      await into(lyricsProviderConfigs).insertOnConflictUpdate(config);
    }

    final coverDefaults = [
      CoverProviderConfigsCompanion.insert(
        id: 'cover_subsonic',
        sourceId: 'subsonic',
        priority: 0,
      ),
      CoverProviderConfigsCompanion.insert(
        id: 'cover_musicbrainz',
        sourceId: 'musicbrainz',
        priority: 1,
      ),
      CoverProviderConfigsCompanion.insert(
        id: 'cover_fanart',
        sourceId: 'fanart',
        priority: 2,
      ),
    ];

    for (final config in coverDefaults) {
      await into(coverProviderConfigs).insertOnConflictUpdate(config);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
