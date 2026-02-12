import 'package:echoes/data/sources/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
