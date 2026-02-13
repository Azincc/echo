import 'package:drift/drift.dart';

@DataClassName('LyricsProviderConfigData')
class LyricsProviderConfigs extends Table {
  TextColumn get id => text()();
  TextColumn get sourceId => text().unique()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get priority => integer()();
  TextColumn get config => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
