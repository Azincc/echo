import 'package:drift/drift.dart';

@DataClassName('LyricsCacheData')
class LyricsCache extends Table {
  TextColumn get songId => text()();
  TextColumn get sourceId => text()();
  TextColumn get content => text()();
  BoolColumn get hasSynced => boolean().withDefault(const Constant(false))();
  TextColumn get languages => text().nullable()();
  IntColumn get fetchedAt => integer()();

  @override
  Set<Column> get primaryKey => {songId};
}
