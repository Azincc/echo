import 'package:drift/drift.dart';
import 'music_libraries_table.dart';

@DataClassName('ServerAddressTableData')
class ServerAddresses extends Table {
  TextColumn get id => text()();
  TextColumn get libraryId =>
      text().references(MusicLibraries, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();
  TextColumn get url => text()();
  IntColumn get priority => integer()();
  BoolColumn get isLocked => boolean().withDefault(const Constant(false))();
  IntColumn get lastLatencyMs => integer().nullable()();
  TextColumn get lastStatus => text().withDefault(const Constant('unknown'))();

  @override
  Set<Column> get primaryKey => {id};
}
