import 'package:drift/drift.dart';

@DataClassName('DownloadTaskData')
class DownloadTasks extends Table {
  TextColumn get id => text()();
  TextColumn get libraryId => text()();
  TextColumn get songId => text()();
  TextColumn get title => text()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();
  TextColumn get coverArt => text().nullable()();
  IntColumn get duration => integer().nullable()();
  TextColumn get suffix => text().nullable()();
  IntColumn get bitRate => integer().nullable()();
  TextColumn get contentType => text().nullable()();
  TextColumn get filePath => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  TextColumn get errorMessage => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get completedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {libraryId, songId},
  ];
}
