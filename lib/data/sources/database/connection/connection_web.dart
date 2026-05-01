import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

Future<WasmSqlite3>? _sqlite3Loader;

Future<WasmSqlite3> _loadSqlite3() {
  return _sqlite3Loader ??= () async {
    final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    sqlite3.registerVirtualFileSystem(InMemoryFileSystem(), makeDefault: true);
    return sqlite3;
  }();
}

LazyDatabase _createConnection() {
  return LazyDatabase(() async {
    final sqlite3 = await _loadSqlite3();
    return WasmDatabase.inMemory(sqlite3);
  });
}

LazyDatabase openConnection() => _createConnection();
