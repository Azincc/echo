import 'package:drift/drift.dart';

@DataClassName('AudioCacheEntryData')
class AudioCacheEntries extends Table {
  TextColumn get id => text()();
  TextColumn get libraryId => text()();
  TextColumn get songId => text()();
  TextColumn get quality => text()();
  TextColumn get filePath => text()();
  IntColumn get fileSize => integer()();
  IntColumn get playCount => integer().withDefault(const Constant(0))();
  IntColumn get lastPlayedAt => integer().nullable()();
  IntColumn get cachedAt => integer()();
  BoolColumn get isComplete => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {libraryId, songId, quality},
  ];
}
