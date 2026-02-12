import 'package:drift/drift.dart';

@DataClassName('MusicLibraryTableData')
class MusicLibraries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get authType =>
      text().withDefault(const Constant('token'))(); // 'apikey' / 'token'
  TextColumn get username => text().nullable()();
  TextColumn get password => text().nullable()(); // Encrypted
  TextColumn get apiKey => text().nullable()(); // Encrypted
  TextColumn get serverType => text().nullable()();
  TextColumn get serverVersion => text().nullable()();
  BoolColumn get isOpenSubsonic =>
      boolean().withDefault(const Constant(false))();
  TextColumn get extensions => text().nullable()(); // JSON
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
