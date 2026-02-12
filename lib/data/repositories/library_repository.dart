import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:echo/data/models/music_library.dart';
import 'package:echo/data/models/server_address.dart';
import 'package:echo/data/sources/database/app_database.dart';
// Note: imports of table files are not strictly needed if we access via AppDatabase getters,
// but we need the Data classes (Row classes).
// AppDatabase exports them or they are available part of it?
// Usually generated code contains them.
// But we can import the table definitions if needed for type reference if distinct.
// Actually generated classes are in app_database.g.dart usually.
// Let's rely on AppDatabase's types.

class LibraryRepository {
  final AppDatabase _db;

  LibraryRepository(this._db);

  Stream<List<MusicLibrary>> watchLibraries() {
    return (_db.select(_db.musicLibraries)..orderBy([
          (t) => OrderingTerm(mode: OrderingMode.asc, expression: t.createdAt),
        ]))
        .watch()
        .asyncMap((rows) async {
          final libraries = <MusicLibrary>[];
          for (final row in rows) {
            final addresses =
                await (_db.select(_db.serverAddresses)
                      ..where((t) => t.libraryId.equals(row.id))
                      ..orderBy([
                        (t) => OrderingTerm(
                          mode: OrderingMode.asc,
                          expression: t.priority,
                        ),
                      ]))
                    .get();

            libraries.add(_mapLibrary(row, addresses));
          }
          return libraries;
        });
  }

  Future<void> addLibrary(MusicLibrary library) async {
    await _db.transaction(() async {
      await _db
          .into(_db.musicLibraries)
          .insert(
            MusicLibrariesCompanion.insert(
              id: library.id,
              name: library.name,
              authType: Value(library.authType.name),
              username: Value(library.username),
              password: Value(library.password),
              apiKey: Value(library.apiKey),
              serverType: Value(library.serverType),
              serverVersion: Value(library.serverVersion),
              isOpenSubsonic: Value(library.isOpenSubsonic),
              extensions: Value(jsonEncode(library.extensions)),
              isActive: Value(library.isActive),
              createdAt: library.createdAt.millisecondsSinceEpoch,
              updatedAt: library.updatedAt.millisecondsSinceEpoch,
            ),
          );

      for (final addr in library.addresses) {
        await _db
            .into(_db.serverAddresses)
            .insert(
              ServerAddressesCompanion.insert(
                id: addr.id,
                libraryId: library.id,
                label: addr.label,
                url: addr.url,
                priority: addr.priority,
                isLocked: Value(addr.isLocked),
                lastLatencyMs: Value(addr.lastLatencyMs),
                lastStatus: Value(addr.status.name),
              ),
            );
      }
    });
  }

  Future<void> updateLibrary(MusicLibrary library) async {
    await _db.transaction(() async {
      await (_db.update(
        _db.musicLibraries,
      )..where((t) => t.id.equals(library.id))).write(
        MusicLibrariesCompanion(
          name: Value(library.name),
          authType: Value(library.authType.name),
          username: Value(library.username),
          password: Value(library.password),
          apiKey: Value(library.apiKey),
          extensions: Value(jsonEncode(library.extensions)),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
          isActive: Value(
            library.isActive,
          ), // Ideally handle active switching separately
          // ...
        ),
      );

      // For addresses, simplest is to delete all and re-insert, or diff.
      // For now, let's assume addresses are updated via separate methods or full replace?
      // If we pass the full library with addresses, we should probably sync addresses.
      // But users might update just library info.
      // Let's assume this method updates library info. Addresses are managed separately or we implement logic.
      // Given the plan says "Edit Library" includes addresses management, maybe we just handle address updates separately in UI logic.
      // But let's implement basic update.
    });
  }

  Future<void> updateAddress(ServerAddress addr) async {
    await (_db.update(
      _db.serverAddresses,
    )..where((t) => t.id.equals(addr.id))).write(
      ServerAddressesCompanion(
        label: Value(addr.label),
        url: Value(addr.url),
        priority: Value(addr.priority),
        isLocked: Value(addr.isLocked),
        lastLatencyMs: Value(addr.lastLatencyMs),
        lastStatus: Value(addr.status.name),
      ),
    );
  }

  Future<void> deleteLibrary(String id) async {
    await (_db.delete(_db.musicLibraries)..where((t) => t.id.equals(id))).go();
  }

  Future<void> addAddress(ServerAddress addr) async {
    await _db
        .into(_db.serverAddresses)
        .insert(
          ServerAddressesCompanion.insert(
            id: addr.id,
            libraryId: addr.libraryId,
            label: addr.label,
            url: addr.url,
            priority: addr.priority,
            isLocked: Value(addr.isLocked),
            lastStatus: Value(addr.status.name),
          ),
        );
  }

  Future<void> deleteAddress(String id) async {
    await (_db.delete(_db.serverAddresses)..where((t) => t.id.equals(id))).go();
  }

  Future<void> setActiveLibrary(String id) async {
    await _db.transaction(() async {
      await (_db.update(_db.musicLibraries)
            ..where((t) => t.isActive.equals(true)))
          .write(const MusicLibrariesCompanion(isActive: Value(false)));

      await (_db.update(_db.musicLibraries)..where((t) => t.id.equals(id)))
          .write(const MusicLibrariesCompanion(isActive: Value(true)));
    });
  }

  MusicLibrary _mapLibrary(
    MusicLibraryTableData row,
    List<ServerAddressTableData> addrRows,
  ) {
    return MusicLibrary(
      id: row.id,
      name: row.name,
      authType: MusicLibraryAuthType.values.byName(row.authType),
      username: row.username,
      password: row.password,
      apiKey: row.apiKey,
      serverType: row.serverType,
      serverVersion: row.serverVersion,
      isOpenSubsonic: row.isOpenSubsonic,
      extensions: row.extensions != null
          ? jsonDecode(row.extensions!) as Map<String, dynamic>
          : {},
      isActive: row.isActive,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
      addresses: addrRows
          .map(
            (a) => ServerAddress(
              id: a.id,
              libraryId: a.libraryId,
              label: a.label,
              url: a.url,
              priority: a.priority,
              isLocked: a.isLocked,
              lastLatencyMs: a.lastLatencyMs,
              status: ServerAddressStatus.values.byName(a.lastStatus),
            ),
          )
          .toList(),
    );
  }
}
