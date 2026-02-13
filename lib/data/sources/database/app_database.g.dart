// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MusicLibrariesTable extends MusicLibraries
    with TableInfo<$MusicLibrariesTable, MusicLibraryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MusicLibrariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authTypeMeta = const VerificationMeta(
    'authType',
  );
  @override
  late final GeneratedColumn<String> authType = GeneratedColumn<String>(
    'auth_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('token'),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverTypeMeta = const VerificationMeta(
    'serverType',
  );
  @override
  late final GeneratedColumn<String> serverType = GeneratedColumn<String>(
    'server_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<String> serverVersion = GeneratedColumn<String>(
    'server_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOpenSubsonicMeta = const VerificationMeta(
    'isOpenSubsonic',
  );
  @override
  late final GeneratedColumn<bool> isOpenSubsonic = GeneratedColumn<bool>(
    'is_open_subsonic',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_open_subsonic" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _extensionsMeta = const VerificationMeta(
    'extensions',
  );
  @override
  late final GeneratedColumn<String> extensions = GeneratedColumn<String>(
    'extensions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    authType,
    username,
    password,
    apiKey,
    serverType,
    serverVersion,
    isOpenSubsonic,
    extensions,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'music_libraries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MusicLibraryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('auth_type')) {
      context.handle(
        _authTypeMeta,
        authType.isAcceptableOrUnknown(data['auth_type']!, _authTypeMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    }
    if (data.containsKey('server_type')) {
      context.handle(
        _serverTypeMeta,
        serverType.isAcceptableOrUnknown(data['server_type']!, _serverTypeMeta),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('is_open_subsonic')) {
      context.handle(
        _isOpenSubsonicMeta,
        isOpenSubsonic.isAcceptableOrUnknown(
          data['is_open_subsonic']!,
          _isOpenSubsonicMeta,
        ),
      );
    }
    if (data.containsKey('extensions')) {
      context.handle(
        _extensionsMeta,
        extensions.isAcceptableOrUnknown(data['extensions']!, _extensionsMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MusicLibraryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MusicLibraryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      authType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_type'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      ),
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      ),
      serverType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_type'],
      ),
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_version'],
      ),
      isOpenSubsonic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_open_subsonic'],
      )!,
      extensions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extensions'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MusicLibrariesTable createAlias(String alias) {
    return $MusicLibrariesTable(attachedDatabase, alias);
  }
}

class MusicLibraryTableData extends DataClass
    implements Insertable<MusicLibraryTableData> {
  final String id;
  final String name;
  final String authType;
  final String? username;
  final String? password;
  final String? apiKey;
  final String? serverType;
  final String? serverVersion;
  final bool isOpenSubsonic;
  final String? extensions;
  final bool isActive;
  final int createdAt;
  final int updatedAt;
  const MusicLibraryTableData({
    required this.id,
    required this.name,
    required this.authType,
    this.username,
    this.password,
    this.apiKey,
    this.serverType,
    this.serverVersion,
    required this.isOpenSubsonic,
    this.extensions,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['auth_type'] = Variable<String>(authType);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    if (!nullToAbsent || serverType != null) {
      map['server_type'] = Variable<String>(serverType);
    }
    if (!nullToAbsent || serverVersion != null) {
      map['server_version'] = Variable<String>(serverVersion);
    }
    map['is_open_subsonic'] = Variable<bool>(isOpenSubsonic);
    if (!nullToAbsent || extensions != null) {
      map['extensions'] = Variable<String>(extensions);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  MusicLibrariesCompanion toCompanion(bool nullToAbsent) {
    return MusicLibrariesCompanion(
      id: Value(id),
      name: Value(name),
      authType: Value(authType),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      apiKey: apiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(apiKey),
      serverType: serverType == null && nullToAbsent
          ? const Value.absent()
          : Value(serverType),
      serverVersion: serverVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(serverVersion),
      isOpenSubsonic: Value(isOpenSubsonic),
      extensions: extensions == null && nullToAbsent
          ? const Value.absent()
          : Value(extensions),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MusicLibraryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MusicLibraryTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      authType: serializer.fromJson<String>(json['authType']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      apiKey: serializer.fromJson<String?>(json['apiKey']),
      serverType: serializer.fromJson<String?>(json['serverType']),
      serverVersion: serializer.fromJson<String?>(json['serverVersion']),
      isOpenSubsonic: serializer.fromJson<bool>(json['isOpenSubsonic']),
      extensions: serializer.fromJson<String?>(json['extensions']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'authType': serializer.toJson<String>(authType),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'apiKey': serializer.toJson<String?>(apiKey),
      'serverType': serializer.toJson<String?>(serverType),
      'serverVersion': serializer.toJson<String?>(serverVersion),
      'isOpenSubsonic': serializer.toJson<bool>(isOpenSubsonic),
      'extensions': serializer.toJson<String?>(extensions),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  MusicLibraryTableData copyWith({
    String? id,
    String? name,
    String? authType,
    Value<String?> username = const Value.absent(),
    Value<String?> password = const Value.absent(),
    Value<String?> apiKey = const Value.absent(),
    Value<String?> serverType = const Value.absent(),
    Value<String?> serverVersion = const Value.absent(),
    bool? isOpenSubsonic,
    Value<String?> extensions = const Value.absent(),
    bool? isActive,
    int? createdAt,
    int? updatedAt,
  }) => MusicLibraryTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    authType: authType ?? this.authType,
    username: username.present ? username.value : this.username,
    password: password.present ? password.value : this.password,
    apiKey: apiKey.present ? apiKey.value : this.apiKey,
    serverType: serverType.present ? serverType.value : this.serverType,
    serverVersion: serverVersion.present
        ? serverVersion.value
        : this.serverVersion,
    isOpenSubsonic: isOpenSubsonic ?? this.isOpenSubsonic,
    extensions: extensions.present ? extensions.value : this.extensions,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MusicLibraryTableData copyWithCompanion(MusicLibrariesCompanion data) {
    return MusicLibraryTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      authType: data.authType.present ? data.authType.value : this.authType,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      serverType: data.serverType.present
          ? data.serverType.value
          : this.serverType,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      isOpenSubsonic: data.isOpenSubsonic.present
          ? data.isOpenSubsonic.value
          : this.isOpenSubsonic,
      extensions: data.extensions.present
          ? data.extensions.value
          : this.extensions,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MusicLibraryTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('authType: $authType, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('apiKey: $apiKey, ')
          ..write('serverType: $serverType, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('isOpenSubsonic: $isOpenSubsonic, ')
          ..write('extensions: $extensions, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    authType,
    username,
    password,
    apiKey,
    serverType,
    serverVersion,
    isOpenSubsonic,
    extensions,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MusicLibraryTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.authType == this.authType &&
          other.username == this.username &&
          other.password == this.password &&
          other.apiKey == this.apiKey &&
          other.serverType == this.serverType &&
          other.serverVersion == this.serverVersion &&
          other.isOpenSubsonic == this.isOpenSubsonic &&
          other.extensions == this.extensions &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MusicLibrariesCompanion extends UpdateCompanion<MusicLibraryTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> authType;
  final Value<String?> username;
  final Value<String?> password;
  final Value<String?> apiKey;
  final Value<String?> serverType;
  final Value<String?> serverVersion;
  final Value<bool> isOpenSubsonic;
  final Value<String?> extensions;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const MusicLibrariesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.authType = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.serverType = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.isOpenSubsonic = const Value.absent(),
    this.extensions = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MusicLibrariesCompanion.insert({
    required String id,
    required String name,
    this.authType = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.serverType = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.isOpenSubsonic = const Value.absent(),
    this.extensions = const Value.absent(),
    this.isActive = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MusicLibraryTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? authType,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? apiKey,
    Expression<String>? serverType,
    Expression<String>? serverVersion,
    Expression<bool>? isOpenSubsonic,
    Expression<String>? extensions,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (authType != null) 'auth_type': authType,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (apiKey != null) 'api_key': apiKey,
      if (serverType != null) 'server_type': serverType,
      if (serverVersion != null) 'server_version': serverVersion,
      if (isOpenSubsonic != null) 'is_open_subsonic': isOpenSubsonic,
      if (extensions != null) 'extensions': extensions,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MusicLibrariesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? authType,
    Value<String?>? username,
    Value<String?>? password,
    Value<String?>? apiKey,
    Value<String?>? serverType,
    Value<String?>? serverVersion,
    Value<bool>? isOpenSubsonic,
    Value<String?>? extensions,
    Value<bool>? isActive,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return MusicLibrariesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      authType: authType ?? this.authType,
      username: username ?? this.username,
      password: password ?? this.password,
      apiKey: apiKey ?? this.apiKey,
      serverType: serverType ?? this.serverType,
      serverVersion: serverVersion ?? this.serverVersion,
      isOpenSubsonic: isOpenSubsonic ?? this.isOpenSubsonic,
      extensions: extensions ?? this.extensions,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (authType.present) {
      map['auth_type'] = Variable<String>(authType.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (serverType.present) {
      map['server_type'] = Variable<String>(serverType.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<String>(serverVersion.value);
    }
    if (isOpenSubsonic.present) {
      map['is_open_subsonic'] = Variable<bool>(isOpenSubsonic.value);
    }
    if (extensions.present) {
      map['extensions'] = Variable<String>(extensions.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MusicLibrariesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('authType: $authType, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('apiKey: $apiKey, ')
          ..write('serverType: $serverType, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('isOpenSubsonic: $isOpenSubsonic, ')
          ..write('extensions: $extensions, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServerAddressesTable extends ServerAddresses
    with TableInfo<$ServerAddressesTable, ServerAddressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerAddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libraryIdMeta = const VerificationMeta(
    'libraryId',
  );
  @override
  late final GeneratedColumn<String> libraryId = GeneratedColumn<String>(
    'library_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES music_libraries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLockedMeta = const VerificationMeta(
    'isLocked',
  );
  @override
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
    'is_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_locked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastLatencyMsMeta = const VerificationMeta(
    'lastLatencyMs',
  );
  @override
  late final GeneratedColumn<int> lastLatencyMs = GeneratedColumn<int>(
    'last_latency_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastStatusMeta = const VerificationMeta(
    'lastStatus',
  );
  @override
  late final GeneratedColumn<String> lastStatus = GeneratedColumn<String>(
    'last_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    label,
    url,
    priority,
    isLocked,
    lastLatencyMs,
    lastStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server_addresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerAddressTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('library_id')) {
      context.handle(
        _libraryIdMeta,
        libraryId.isAcceptableOrUnknown(data['library_id']!, _libraryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_libraryIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('is_locked')) {
      context.handle(
        _isLockedMeta,
        isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta),
      );
    }
    if (data.containsKey('last_latency_ms')) {
      context.handle(
        _lastLatencyMsMeta,
        lastLatencyMs.isAcceptableOrUnknown(
          data['last_latency_ms']!,
          _lastLatencyMsMeta,
        ),
      );
    }
    if (data.containsKey('last_status')) {
      context.handle(
        _lastStatusMeta,
        lastStatus.isAcceptableOrUnknown(data['last_status']!, _lastStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerAddressTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerAddressTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
      lastLatencyMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_latency_ms'],
      ),
      lastStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_status'],
      )!,
    );
  }

  @override
  $ServerAddressesTable createAlias(String alias) {
    return $ServerAddressesTable(attachedDatabase, alias);
  }
}

class ServerAddressTableData extends DataClass
    implements Insertable<ServerAddressTableData> {
  final String id;
  final String libraryId;
  final String label;
  final String url;
  final int priority;
  final bool isLocked;
  final int? lastLatencyMs;
  final String lastStatus;
  const ServerAddressTableData({
    required this.id,
    required this.libraryId,
    required this.label,
    required this.url,
    required this.priority,
    required this.isLocked,
    this.lastLatencyMs,
    required this.lastStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['library_id'] = Variable<String>(libraryId);
    map['label'] = Variable<String>(label);
    map['url'] = Variable<String>(url);
    map['priority'] = Variable<int>(priority);
    map['is_locked'] = Variable<bool>(isLocked);
    if (!nullToAbsent || lastLatencyMs != null) {
      map['last_latency_ms'] = Variable<int>(lastLatencyMs);
    }
    map['last_status'] = Variable<String>(lastStatus);
    return map;
  }

  ServerAddressesCompanion toCompanion(bool nullToAbsent) {
    return ServerAddressesCompanion(
      id: Value(id),
      libraryId: Value(libraryId),
      label: Value(label),
      url: Value(url),
      priority: Value(priority),
      isLocked: Value(isLocked),
      lastLatencyMs: lastLatencyMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLatencyMs),
      lastStatus: Value(lastStatus),
    );
  }

  factory ServerAddressTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerAddressTableData(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String>(json['libraryId']),
      label: serializer.fromJson<String>(json['label']),
      url: serializer.fromJson<String>(json['url']),
      priority: serializer.fromJson<int>(json['priority']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
      lastLatencyMs: serializer.fromJson<int?>(json['lastLatencyMs']),
      lastStatus: serializer.fromJson<String>(json['lastStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String>(libraryId),
      'label': serializer.toJson<String>(label),
      'url': serializer.toJson<String>(url),
      'priority': serializer.toJson<int>(priority),
      'isLocked': serializer.toJson<bool>(isLocked),
      'lastLatencyMs': serializer.toJson<int?>(lastLatencyMs),
      'lastStatus': serializer.toJson<String>(lastStatus),
    };
  }

  ServerAddressTableData copyWith({
    String? id,
    String? libraryId,
    String? label,
    String? url,
    int? priority,
    bool? isLocked,
    Value<int?> lastLatencyMs = const Value.absent(),
    String? lastStatus,
  }) => ServerAddressTableData(
    id: id ?? this.id,
    libraryId: libraryId ?? this.libraryId,
    label: label ?? this.label,
    url: url ?? this.url,
    priority: priority ?? this.priority,
    isLocked: isLocked ?? this.isLocked,
    lastLatencyMs: lastLatencyMs.present
        ? lastLatencyMs.value
        : this.lastLatencyMs,
    lastStatus: lastStatus ?? this.lastStatus,
  );
  ServerAddressTableData copyWithCompanion(ServerAddressesCompanion data) {
    return ServerAddressTableData(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      label: data.label.present ? data.label.value : this.label,
      url: data.url.present ? data.url.value : this.url,
      priority: data.priority.present ? data.priority.value : this.priority,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
      lastLatencyMs: data.lastLatencyMs.present
          ? data.lastLatencyMs.value
          : this.lastLatencyMs,
      lastStatus: data.lastStatus.present
          ? data.lastStatus.value
          : this.lastStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerAddressTableData(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('priority: $priority, ')
          ..write('isLocked: $isLocked, ')
          ..write('lastLatencyMs: $lastLatencyMs, ')
          ..write('lastStatus: $lastStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    label,
    url,
    priority,
    isLocked,
    lastLatencyMs,
    lastStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerAddressTableData &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.label == this.label &&
          other.url == this.url &&
          other.priority == this.priority &&
          other.isLocked == this.isLocked &&
          other.lastLatencyMs == this.lastLatencyMs &&
          other.lastStatus == this.lastStatus);
}

class ServerAddressesCompanion extends UpdateCompanion<ServerAddressTableData> {
  final Value<String> id;
  final Value<String> libraryId;
  final Value<String> label;
  final Value<String> url;
  final Value<int> priority;
  final Value<bool> isLocked;
  final Value<int?> lastLatencyMs;
  final Value<String> lastStatus;
  final Value<int> rowid;
  const ServerAddressesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.label = const Value.absent(),
    this.url = const Value.absent(),
    this.priority = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.lastLatencyMs = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServerAddressesCompanion.insert({
    required String id,
    required String libraryId,
    required String label,
    required String url,
    required int priority,
    this.isLocked = const Value.absent(),
    this.lastLatencyMs = const Value.absent(),
    this.lastStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       libraryId = Value(libraryId),
       label = Value(label),
       url = Value(url),
       priority = Value(priority);
  static Insertable<ServerAddressTableData> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? label,
    Expression<String>? url,
    Expression<int>? priority,
    Expression<bool>? isLocked,
    Expression<int>? lastLatencyMs,
    Expression<String>? lastStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (label != null) 'label': label,
      if (url != null) 'url': url,
      if (priority != null) 'priority': priority,
      if (isLocked != null) 'is_locked': isLocked,
      if (lastLatencyMs != null) 'last_latency_ms': lastLatencyMs,
      if (lastStatus != null) 'last_status': lastStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServerAddressesCompanion copyWith({
    Value<String>? id,
    Value<String>? libraryId,
    Value<String>? label,
    Value<String>? url,
    Value<int>? priority,
    Value<bool>? isLocked,
    Value<int?>? lastLatencyMs,
    Value<String>? lastStatus,
    Value<int>? rowid,
  }) {
    return ServerAddressesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      label: label ?? this.label,
      url: url ?? this.url,
      priority: priority ?? this.priority,
      isLocked: isLocked ?? this.isLocked,
      lastLatencyMs: lastLatencyMs ?? this.lastLatencyMs,
      lastStatus: lastStatus ?? this.lastStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libraryId.present) {
      map['library_id'] = Variable<String>(libraryId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (lastLatencyMs.present) {
      map['last_latency_ms'] = Variable<int>(lastLatencyMs.value);
    }
    if (lastStatus.present) {
      map['last_status'] = Variable<String>(lastStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerAddressesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('priority: $priority, ')
          ..write('isLocked: $isLocked, ')
          ..write('lastLatencyMs: $lastLatencyMs, ')
          ..write('lastStatus: $lastStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LyricsProviderConfigsTable extends LyricsProviderConfigs
    with TableInfo<$LyricsProviderConfigsTable, LyricsProviderConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LyricsProviderConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _configMeta = const VerificationMeta('config');
  @override
  late final GeneratedColumn<String> config = GeneratedColumn<String>(
    'config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    enabled,
    priority,
    config,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lyrics_provider_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LyricsProviderConfigData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('config')) {
      context.handle(
        _configMeta,
        config.isAcceptableOrUnknown(data['config']!, _configMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LyricsProviderConfigData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LyricsProviderConfigData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      config: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config'],
      ),
    );
  }

  @override
  $LyricsProviderConfigsTable createAlias(String alias) {
    return $LyricsProviderConfigsTable(attachedDatabase, alias);
  }
}

class LyricsProviderConfigData extends DataClass
    implements Insertable<LyricsProviderConfigData> {
  final String id;
  final String sourceId;
  final bool enabled;
  final int priority;
  final String? config;
  const LyricsProviderConfigData({
    required this.id,
    required this.sourceId,
    required this.enabled,
    required this.priority,
    this.config,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['enabled'] = Variable<bool>(enabled);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || config != null) {
      map['config'] = Variable<String>(config);
    }
    return map;
  }

  LyricsProviderConfigsCompanion toCompanion(bool nullToAbsent) {
    return LyricsProviderConfigsCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      enabled: Value(enabled),
      priority: Value(priority),
      config: config == null && nullToAbsent
          ? const Value.absent()
          : Value(config),
    );
  }

  factory LyricsProviderConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LyricsProviderConfigData(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      priority: serializer.fromJson<int>(json['priority']),
      config: serializer.fromJson<String?>(json['config']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'enabled': serializer.toJson<bool>(enabled),
      'priority': serializer.toJson<int>(priority),
      'config': serializer.toJson<String?>(config),
    };
  }

  LyricsProviderConfigData copyWith({
    String? id,
    String? sourceId,
    bool? enabled,
    int? priority,
    Value<String?> config = const Value.absent(),
  }) => LyricsProviderConfigData(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    enabled: enabled ?? this.enabled,
    priority: priority ?? this.priority,
    config: config.present ? config.value : this.config,
  );
  LyricsProviderConfigData copyWithCompanion(
    LyricsProviderConfigsCompanion data,
  ) {
    return LyricsProviderConfigData(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      priority: data.priority.present ? data.priority.value : this.priority,
      config: data.config.present ? data.config.value : this.config,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LyricsProviderConfigData(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('config: $config')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, enabled, priority, config);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LyricsProviderConfigData &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.enabled == this.enabled &&
          other.priority == this.priority &&
          other.config == this.config);
}

class LyricsProviderConfigsCompanion
    extends UpdateCompanion<LyricsProviderConfigData> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<bool> enabled;
  final Value<int> priority;
  final Value<String?> config;
  final Value<int> rowid;
  const LyricsProviderConfigsCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.config = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LyricsProviderConfigsCompanion.insert({
    required String id,
    required String sourceId,
    this.enabled = const Value.absent(),
    required int priority,
    this.config = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceId = Value(sourceId),
       priority = Value(priority);
  static Insertable<LyricsProviderConfigData> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<bool>? enabled,
    Expression<int>? priority,
    Expression<String>? config,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (enabled != null) 'enabled': enabled,
      if (priority != null) 'priority': priority,
      if (config != null) 'config': config,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LyricsProviderConfigsCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceId,
    Value<bool>? enabled,
    Value<int>? priority,
    Value<String?>? config,
    Value<int>? rowid,
  }) {
    return LyricsProviderConfigsCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      enabled: enabled ?? this.enabled,
      priority: priority ?? this.priority,
      config: config ?? this.config,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (config.present) {
      map['config'] = Variable<String>(config.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LyricsProviderConfigsCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('config: $config, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoverProviderConfigsTable extends CoverProviderConfigs
    with TableInfo<$CoverProviderConfigsTable, CoverProviderConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoverProviderConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _configMeta = const VerificationMeta('config');
  @override
  late final GeneratedColumn<String> config = GeneratedColumn<String>(
    'config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    enabled,
    priority,
    config,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cover_provider_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoverProviderConfigData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('config')) {
      context.handle(
        _configMeta,
        config.isAcceptableOrUnknown(data['config']!, _configMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoverProviderConfigData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoverProviderConfigData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      config: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config'],
      ),
    );
  }

  @override
  $CoverProviderConfigsTable createAlias(String alias) {
    return $CoverProviderConfigsTable(attachedDatabase, alias);
  }
}

class CoverProviderConfigData extends DataClass
    implements Insertable<CoverProviderConfigData> {
  final String id;
  final String sourceId;
  final bool enabled;
  final int priority;
  final String? config;
  const CoverProviderConfigData({
    required this.id,
    required this.sourceId,
    required this.enabled,
    required this.priority,
    this.config,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['enabled'] = Variable<bool>(enabled);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || config != null) {
      map['config'] = Variable<String>(config);
    }
    return map;
  }

  CoverProviderConfigsCompanion toCompanion(bool nullToAbsent) {
    return CoverProviderConfigsCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      enabled: Value(enabled),
      priority: Value(priority),
      config: config == null && nullToAbsent
          ? const Value.absent()
          : Value(config),
    );
  }

  factory CoverProviderConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoverProviderConfigData(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      priority: serializer.fromJson<int>(json['priority']),
      config: serializer.fromJson<String?>(json['config']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'enabled': serializer.toJson<bool>(enabled),
      'priority': serializer.toJson<int>(priority),
      'config': serializer.toJson<String?>(config),
    };
  }

  CoverProviderConfigData copyWith({
    String? id,
    String? sourceId,
    bool? enabled,
    int? priority,
    Value<String?> config = const Value.absent(),
  }) => CoverProviderConfigData(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    enabled: enabled ?? this.enabled,
    priority: priority ?? this.priority,
    config: config.present ? config.value : this.config,
  );
  CoverProviderConfigData copyWithCompanion(
    CoverProviderConfigsCompanion data,
  ) {
    return CoverProviderConfigData(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      priority: data.priority.present ? data.priority.value : this.priority,
      config: data.config.present ? data.config.value : this.config,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoverProviderConfigData(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('config: $config')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, enabled, priority, config);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoverProviderConfigData &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.enabled == this.enabled &&
          other.priority == this.priority &&
          other.config == this.config);
}

class CoverProviderConfigsCompanion
    extends UpdateCompanion<CoverProviderConfigData> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<bool> enabled;
  final Value<int> priority;
  final Value<String?> config;
  final Value<int> rowid;
  const CoverProviderConfigsCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.config = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoverProviderConfigsCompanion.insert({
    required String id,
    required String sourceId,
    this.enabled = const Value.absent(),
    required int priority,
    this.config = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceId = Value(sourceId),
       priority = Value(priority);
  static Insertable<CoverProviderConfigData> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<bool>? enabled,
    Expression<int>? priority,
    Expression<String>? config,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (enabled != null) 'enabled': enabled,
      if (priority != null) 'priority': priority,
      if (config != null) 'config': config,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoverProviderConfigsCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceId,
    Value<bool>? enabled,
    Value<int>? priority,
    Value<String?>? config,
    Value<int>? rowid,
  }) {
    return CoverProviderConfigsCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      enabled: enabled ?? this.enabled,
      priority: priority ?? this.priority,
      config: config ?? this.config,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (config.present) {
      map['config'] = Variable<String>(config.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoverProviderConfigsCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('config: $config, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LyricsCacheTable extends LyricsCache
    with TableInfo<$LyricsCacheTable, LyricsCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LyricsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
    'song_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasSyncedMeta = const VerificationMeta(
    'hasSynced',
  );
  @override
  late final GeneratedColumn<bool> hasSynced = GeneratedColumn<bool>(
    'has_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _languagesMeta = const VerificationMeta(
    'languages',
  );
  @override
  late final GeneratedColumn<String> languages = GeneratedColumn<String>(
    'languages',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<int> fetchedAt = GeneratedColumn<int>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    songId,
    sourceId,
    content,
    hasSynced,
    languages,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lyrics_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<LyricsCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('has_synced')) {
      context.handle(
        _hasSyncedMeta,
        hasSynced.isAcceptableOrUnknown(data['has_synced']!, _hasSyncedMeta),
      );
    }
    if (data.containsKey('languages')) {
      context.handle(
        _languagesMeta,
        languages.isAcceptableOrUnknown(data['languages']!, _languagesMeta),
      );
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  LyricsCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LyricsCacheData(
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}song_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      hasSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_synced'],
      )!,
      languages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}languages'],
      ),
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $LyricsCacheTable createAlias(String alias) {
    return $LyricsCacheTable(attachedDatabase, alias);
  }
}

class LyricsCacheData extends DataClass implements Insertable<LyricsCacheData> {
  final String songId;
  final String sourceId;
  final String content;
  final bool hasSynced;
  final String? languages;
  final int fetchedAt;
  const LyricsCacheData({
    required this.songId,
    required this.sourceId,
    required this.content,
    required this.hasSynced,
    this.languages,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['source_id'] = Variable<String>(sourceId);
    map['content'] = Variable<String>(content);
    map['has_synced'] = Variable<bool>(hasSynced);
    if (!nullToAbsent || languages != null) {
      map['languages'] = Variable<String>(languages);
    }
    map['fetched_at'] = Variable<int>(fetchedAt);
    return map;
  }

  LyricsCacheCompanion toCompanion(bool nullToAbsent) {
    return LyricsCacheCompanion(
      songId: Value(songId),
      sourceId: Value(sourceId),
      content: Value(content),
      hasSynced: Value(hasSynced),
      languages: languages == null && nullToAbsent
          ? const Value.absent()
          : Value(languages),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory LyricsCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LyricsCacheData(
      songId: serializer.fromJson<String>(json['songId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      content: serializer.fromJson<String>(json['content']),
      hasSynced: serializer.fromJson<bool>(json['hasSynced']),
      languages: serializer.fromJson<String?>(json['languages']),
      fetchedAt: serializer.fromJson<int>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'sourceId': serializer.toJson<String>(sourceId),
      'content': serializer.toJson<String>(content),
      'hasSynced': serializer.toJson<bool>(hasSynced),
      'languages': serializer.toJson<String?>(languages),
      'fetchedAt': serializer.toJson<int>(fetchedAt),
    };
  }

  LyricsCacheData copyWith({
    String? songId,
    String? sourceId,
    String? content,
    bool? hasSynced,
    Value<String?> languages = const Value.absent(),
    int? fetchedAt,
  }) => LyricsCacheData(
    songId: songId ?? this.songId,
    sourceId: sourceId ?? this.sourceId,
    content: content ?? this.content,
    hasSynced: hasSynced ?? this.hasSynced,
    languages: languages.present ? languages.value : this.languages,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  LyricsCacheData copyWithCompanion(LyricsCacheCompanion data) {
    return LyricsCacheData(
      songId: data.songId.present ? data.songId.value : this.songId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      content: data.content.present ? data.content.value : this.content,
      hasSynced: data.hasSynced.present ? data.hasSynced.value : this.hasSynced,
      languages: data.languages.present ? data.languages.value : this.languages,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LyricsCacheData(')
          ..write('songId: $songId, ')
          ..write('sourceId: $sourceId, ')
          ..write('content: $content, ')
          ..write('hasSynced: $hasSynced, ')
          ..write('languages: $languages, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(songId, sourceId, content, hasSynced, languages, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LyricsCacheData &&
          other.songId == this.songId &&
          other.sourceId == this.sourceId &&
          other.content == this.content &&
          other.hasSynced == this.hasSynced &&
          other.languages == this.languages &&
          other.fetchedAt == this.fetchedAt);
}

class LyricsCacheCompanion extends UpdateCompanion<LyricsCacheData> {
  final Value<String> songId;
  final Value<String> sourceId;
  final Value<String> content;
  final Value<bool> hasSynced;
  final Value<String?> languages;
  final Value<int> fetchedAt;
  final Value<int> rowid;
  const LyricsCacheCompanion({
    this.songId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.content = const Value.absent(),
    this.hasSynced = const Value.absent(),
    this.languages = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LyricsCacheCompanion.insert({
    required String songId,
    required String sourceId,
    required String content,
    this.hasSynced = const Value.absent(),
    this.languages = const Value.absent(),
    required int fetchedAt,
    this.rowid = const Value.absent(),
  }) : songId = Value(songId),
       sourceId = Value(sourceId),
       content = Value(content),
       fetchedAt = Value(fetchedAt);
  static Insertable<LyricsCacheData> custom({
    Expression<String>? songId,
    Expression<String>? sourceId,
    Expression<String>? content,
    Expression<bool>? hasSynced,
    Expression<String>? languages,
    Expression<int>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (sourceId != null) 'source_id': sourceId,
      if (content != null) 'content': content,
      if (hasSynced != null) 'has_synced': hasSynced,
      if (languages != null) 'languages': languages,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LyricsCacheCompanion copyWith({
    Value<String>? songId,
    Value<String>? sourceId,
    Value<String>? content,
    Value<bool>? hasSynced,
    Value<String?>? languages,
    Value<int>? fetchedAt,
    Value<int>? rowid,
  }) {
    return LyricsCacheCompanion(
      songId: songId ?? this.songId,
      sourceId: sourceId ?? this.sourceId,
      content: content ?? this.content,
      hasSynced: hasSynced ?? this.hasSynced,
      languages: languages ?? this.languages,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (hasSynced.present) {
      map['has_synced'] = Variable<bool>(hasSynced.value);
    }
    if (languages.present) {
      map['languages'] = Variable<String>(languages.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<int>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LyricsCacheCompanion(')
          ..write('songId: $songId, ')
          ..write('sourceId: $sourceId, ')
          ..write('content: $content, ')
          ..write('hasSynced: $hasSynced, ')
          ..write('languages: $languages, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MusicLibrariesTable musicLibraries = $MusicLibrariesTable(this);
  late final $ServerAddressesTable serverAddresses = $ServerAddressesTable(
    this,
  );
  late final $LyricsProviderConfigsTable lyricsProviderConfigs =
      $LyricsProviderConfigsTable(this);
  late final $CoverProviderConfigsTable coverProviderConfigs =
      $CoverProviderConfigsTable(this);
  late final $LyricsCacheTable lyricsCache = $LyricsCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    musicLibraries,
    serverAddresses,
    lyricsProviderConfigs,
    coverProviderConfigs,
    lyricsCache,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'music_libraries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('server_addresses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MusicLibrariesTableCreateCompanionBuilder =
    MusicLibrariesCompanion Function({
      required String id,
      required String name,
      Value<String> authType,
      Value<String?> username,
      Value<String?> password,
      Value<String?> apiKey,
      Value<String?> serverType,
      Value<String?> serverVersion,
      Value<bool> isOpenSubsonic,
      Value<String?> extensions,
      Value<bool> isActive,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$MusicLibrariesTableUpdateCompanionBuilder =
    MusicLibrariesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> authType,
      Value<String?> username,
      Value<String?> password,
      Value<String?> apiKey,
      Value<String?> serverType,
      Value<String?> serverVersion,
      Value<bool> isOpenSubsonic,
      Value<String?> extensions,
      Value<bool> isActive,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$MusicLibrariesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MusicLibrariesTable,
          MusicLibraryTableData
        > {
  $$MusicLibrariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ServerAddressesTable,
    List<ServerAddressTableData>
  >
  _serverAddressesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serverAddresses,
    aliasName: $_aliasNameGenerator(
      db.musicLibraries.id,
      db.serverAddresses.libraryId,
    ),
  );

  $$ServerAddressesTableProcessedTableManager get serverAddressesRefs {
    final manager = $$ServerAddressesTableTableManager(
      $_db,
      $_db.serverAddresses,
    ).filter((f) => f.libraryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _serverAddressesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MusicLibrariesTableFilterComposer
    extends Composer<_$AppDatabase, $MusicLibrariesTable> {
  $$MusicLibrariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authType => $composableBuilder(
    column: $table.authType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpenSubsonic => $composableBuilder(
    column: $table.isOpenSubsonic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extensions => $composableBuilder(
    column: $table.extensions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> serverAddressesRefs(
    Expression<bool> Function($$ServerAddressesTableFilterComposer f) f,
  ) {
    final $$ServerAddressesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serverAddresses,
      getReferencedColumn: (t) => t.libraryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerAddressesTableFilterComposer(
            $db: $db,
            $table: $db.serverAddresses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MusicLibrariesTableOrderingComposer
    extends Composer<_$AppDatabase, $MusicLibrariesTable> {
  $$MusicLibrariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authType => $composableBuilder(
    column: $table.authType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpenSubsonic => $composableBuilder(
    column: $table.isOpenSubsonic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extensions => $composableBuilder(
    column: $table.extensions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MusicLibrariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MusicLibrariesTable> {
  $$MusicLibrariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get authType =>
      $composableBuilder(column: $table.authType, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOpenSubsonic => $composableBuilder(
    column: $table.isOpenSubsonic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extensions => $composableBuilder(
    column: $table.extensions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> serverAddressesRefs<T extends Object>(
    Expression<T> Function($$ServerAddressesTableAnnotationComposer a) f,
  ) {
    final $$ServerAddressesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serverAddresses,
      getReferencedColumn: (t) => t.libraryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServerAddressesTableAnnotationComposer(
            $db: $db,
            $table: $db.serverAddresses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MusicLibrariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MusicLibrariesTable,
          MusicLibraryTableData,
          $$MusicLibrariesTableFilterComposer,
          $$MusicLibrariesTableOrderingComposer,
          $$MusicLibrariesTableAnnotationComposer,
          $$MusicLibrariesTableCreateCompanionBuilder,
          $$MusicLibrariesTableUpdateCompanionBuilder,
          (MusicLibraryTableData, $$MusicLibrariesTableReferences),
          MusicLibraryTableData,
          PrefetchHooks Function({bool serverAddressesRefs})
        > {
  $$MusicLibrariesTableTableManager(
    _$AppDatabase db,
    $MusicLibrariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MusicLibrariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MusicLibrariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MusicLibrariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> authType = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> password = const Value.absent(),
                Value<String?> apiKey = const Value.absent(),
                Value<String?> serverType = const Value.absent(),
                Value<String?> serverVersion = const Value.absent(),
                Value<bool> isOpenSubsonic = const Value.absent(),
                Value<String?> extensions = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MusicLibrariesCompanion(
                id: id,
                name: name,
                authType: authType,
                username: username,
                password: password,
                apiKey: apiKey,
                serverType: serverType,
                serverVersion: serverVersion,
                isOpenSubsonic: isOpenSubsonic,
                extensions: extensions,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> authType = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> password = const Value.absent(),
                Value<String?> apiKey = const Value.absent(),
                Value<String?> serverType = const Value.absent(),
                Value<String?> serverVersion = const Value.absent(),
                Value<bool> isOpenSubsonic = const Value.absent(),
                Value<String?> extensions = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MusicLibrariesCompanion.insert(
                id: id,
                name: name,
                authType: authType,
                username: username,
                password: password,
                apiKey: apiKey,
                serverType: serverType,
                serverVersion: serverVersion,
                isOpenSubsonic: isOpenSubsonic,
                extensions: extensions,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MusicLibrariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({serverAddressesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (serverAddressesRefs) db.serverAddresses,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (serverAddressesRefs)
                    await $_getPrefetchedData<
                      MusicLibraryTableData,
                      $MusicLibrariesTable,
                      ServerAddressTableData
                    >(
                      currentTable: table,
                      referencedTable: $$MusicLibrariesTableReferences
                          ._serverAddressesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MusicLibrariesTableReferences(
                            db,
                            table,
                            p0,
                          ).serverAddressesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.libraryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MusicLibrariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MusicLibrariesTable,
      MusicLibraryTableData,
      $$MusicLibrariesTableFilterComposer,
      $$MusicLibrariesTableOrderingComposer,
      $$MusicLibrariesTableAnnotationComposer,
      $$MusicLibrariesTableCreateCompanionBuilder,
      $$MusicLibrariesTableUpdateCompanionBuilder,
      (MusicLibraryTableData, $$MusicLibrariesTableReferences),
      MusicLibraryTableData,
      PrefetchHooks Function({bool serverAddressesRefs})
    >;
typedef $$ServerAddressesTableCreateCompanionBuilder =
    ServerAddressesCompanion Function({
      required String id,
      required String libraryId,
      required String label,
      required String url,
      required int priority,
      Value<bool> isLocked,
      Value<int?> lastLatencyMs,
      Value<String> lastStatus,
      Value<int> rowid,
    });
typedef $$ServerAddressesTableUpdateCompanionBuilder =
    ServerAddressesCompanion Function({
      Value<String> id,
      Value<String> libraryId,
      Value<String> label,
      Value<String> url,
      Value<int> priority,
      Value<bool> isLocked,
      Value<int?> lastLatencyMs,
      Value<String> lastStatus,
      Value<int> rowid,
    });

final class $$ServerAddressesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ServerAddressesTable,
          ServerAddressTableData
        > {
  $$ServerAddressesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MusicLibrariesTable _libraryIdTable(_$AppDatabase db) =>
      db.musicLibraries.createAlias(
        $_aliasNameGenerator(
          db.serverAddresses.libraryId,
          db.musicLibraries.id,
        ),
      );

  $$MusicLibrariesTableProcessedTableManager get libraryId {
    final $_column = $_itemColumn<String>('library_id')!;

    final manager = $$MusicLibrariesTableTableManager(
      $_db,
      $_db.musicLibraries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_libraryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServerAddressesTableFilterComposer
    extends Composer<_$AppDatabase, $ServerAddressesTable> {
  $$ServerAddressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastLatencyMs => $composableBuilder(
    column: $table.lastLatencyMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$MusicLibrariesTableFilterComposer get libraryId {
    final $$MusicLibrariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryId,
      referencedTable: $db.musicLibraries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MusicLibrariesTableFilterComposer(
            $db: $db,
            $table: $db.musicLibraries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServerAddressesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServerAddressesTable> {
  $$ServerAddressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLocked => $composableBuilder(
    column: $table.isLocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastLatencyMs => $composableBuilder(
    column: $table.lastLatencyMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$MusicLibrariesTableOrderingComposer get libraryId {
    final $$MusicLibrariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryId,
      referencedTable: $db.musicLibraries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MusicLibrariesTableOrderingComposer(
            $db: $db,
            $table: $db.musicLibraries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServerAddressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServerAddressesTable> {
  $$ServerAddressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);

  GeneratedColumn<int> get lastLatencyMs => $composableBuilder(
    column: $table.lastLatencyMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => column,
  );

  $$MusicLibrariesTableAnnotationComposer get libraryId {
    final $$MusicLibrariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.libraryId,
      referencedTable: $db.musicLibraries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MusicLibrariesTableAnnotationComposer(
            $db: $db,
            $table: $db.musicLibraries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServerAddressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServerAddressesTable,
          ServerAddressTableData,
          $$ServerAddressesTableFilterComposer,
          $$ServerAddressesTableOrderingComposer,
          $$ServerAddressesTableAnnotationComposer,
          $$ServerAddressesTableCreateCompanionBuilder,
          $$ServerAddressesTableUpdateCompanionBuilder,
          (ServerAddressTableData, $$ServerAddressesTableReferences),
          ServerAddressTableData,
          PrefetchHooks Function({bool libraryId})
        > {
  $$ServerAddressesTableTableManager(
    _$AppDatabase db,
    $ServerAddressesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServerAddressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServerAddressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServerAddressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> libraryId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isLocked = const Value.absent(),
                Value<int?> lastLatencyMs = const Value.absent(),
                Value<String> lastStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServerAddressesCompanion(
                id: id,
                libraryId: libraryId,
                label: label,
                url: url,
                priority: priority,
                isLocked: isLocked,
                lastLatencyMs: lastLatencyMs,
                lastStatus: lastStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String libraryId,
                required String label,
                required String url,
                required int priority,
                Value<bool> isLocked = const Value.absent(),
                Value<int?> lastLatencyMs = const Value.absent(),
                Value<String> lastStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServerAddressesCompanion.insert(
                id: id,
                libraryId: libraryId,
                label: label,
                url: url,
                priority: priority,
                isLocked: isLocked,
                lastLatencyMs: lastLatencyMs,
                lastStatus: lastStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ServerAddressesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({libraryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (libraryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.libraryId,
                                referencedTable:
                                    $$ServerAddressesTableReferences
                                        ._libraryIdTable(db),
                                referencedColumn:
                                    $$ServerAddressesTableReferences
                                        ._libraryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ServerAddressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServerAddressesTable,
      ServerAddressTableData,
      $$ServerAddressesTableFilterComposer,
      $$ServerAddressesTableOrderingComposer,
      $$ServerAddressesTableAnnotationComposer,
      $$ServerAddressesTableCreateCompanionBuilder,
      $$ServerAddressesTableUpdateCompanionBuilder,
      (ServerAddressTableData, $$ServerAddressesTableReferences),
      ServerAddressTableData,
      PrefetchHooks Function({bool libraryId})
    >;
typedef $$LyricsProviderConfigsTableCreateCompanionBuilder =
    LyricsProviderConfigsCompanion Function({
      required String id,
      required String sourceId,
      Value<bool> enabled,
      required int priority,
      Value<String?> config,
      Value<int> rowid,
    });
typedef $$LyricsProviderConfigsTableUpdateCompanionBuilder =
    LyricsProviderConfigsCompanion Function({
      Value<String> id,
      Value<String> sourceId,
      Value<bool> enabled,
      Value<int> priority,
      Value<String?> config,
      Value<int> rowid,
    });

class $$LyricsProviderConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $LyricsProviderConfigsTable> {
  $$LyricsProviderConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LyricsProviderConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $LyricsProviderConfigsTable> {
  $$LyricsProviderConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LyricsProviderConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LyricsProviderConfigsTable> {
  $$LyricsProviderConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get config =>
      $composableBuilder(column: $table.config, builder: (column) => column);
}

class $$LyricsProviderConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LyricsProviderConfigsTable,
          LyricsProviderConfigData,
          $$LyricsProviderConfigsTableFilterComposer,
          $$LyricsProviderConfigsTableOrderingComposer,
          $$LyricsProviderConfigsTableAnnotationComposer,
          $$LyricsProviderConfigsTableCreateCompanionBuilder,
          $$LyricsProviderConfigsTableUpdateCompanionBuilder,
          (
            LyricsProviderConfigData,
            BaseReferences<
              _$AppDatabase,
              $LyricsProviderConfigsTable,
              LyricsProviderConfigData
            >,
          ),
          LyricsProviderConfigData,
          PrefetchHooks Function()
        > {
  $$LyricsProviderConfigsTableTableManager(
    _$AppDatabase db,
    $LyricsProviderConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LyricsProviderConfigsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LyricsProviderConfigsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LyricsProviderConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String?> config = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LyricsProviderConfigsCompanion(
                id: id,
                sourceId: sourceId,
                enabled: enabled,
                priority: priority,
                config: config,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceId,
                Value<bool> enabled = const Value.absent(),
                required int priority,
                Value<String?> config = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LyricsProviderConfigsCompanion.insert(
                id: id,
                sourceId: sourceId,
                enabled: enabled,
                priority: priority,
                config: config,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LyricsProviderConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LyricsProviderConfigsTable,
      LyricsProviderConfigData,
      $$LyricsProviderConfigsTableFilterComposer,
      $$LyricsProviderConfigsTableOrderingComposer,
      $$LyricsProviderConfigsTableAnnotationComposer,
      $$LyricsProviderConfigsTableCreateCompanionBuilder,
      $$LyricsProviderConfigsTableUpdateCompanionBuilder,
      (
        LyricsProviderConfigData,
        BaseReferences<
          _$AppDatabase,
          $LyricsProviderConfigsTable,
          LyricsProviderConfigData
        >,
      ),
      LyricsProviderConfigData,
      PrefetchHooks Function()
    >;
typedef $$CoverProviderConfigsTableCreateCompanionBuilder =
    CoverProviderConfigsCompanion Function({
      required String id,
      required String sourceId,
      Value<bool> enabled,
      required int priority,
      Value<String?> config,
      Value<int> rowid,
    });
typedef $$CoverProviderConfigsTableUpdateCompanionBuilder =
    CoverProviderConfigsCompanion Function({
      Value<String> id,
      Value<String> sourceId,
      Value<bool> enabled,
      Value<int> priority,
      Value<String?> config,
      Value<int> rowid,
    });

class $$CoverProviderConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $CoverProviderConfigsTable> {
  $$CoverProviderConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoverProviderConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoverProviderConfigsTable> {
  $$CoverProviderConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoverProviderConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoverProviderConfigsTable> {
  $$CoverProviderConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get config =>
      $composableBuilder(column: $table.config, builder: (column) => column);
}

class $$CoverProviderConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoverProviderConfigsTable,
          CoverProviderConfigData,
          $$CoverProviderConfigsTableFilterComposer,
          $$CoverProviderConfigsTableOrderingComposer,
          $$CoverProviderConfigsTableAnnotationComposer,
          $$CoverProviderConfigsTableCreateCompanionBuilder,
          $$CoverProviderConfigsTableUpdateCompanionBuilder,
          (
            CoverProviderConfigData,
            BaseReferences<
              _$AppDatabase,
              $CoverProviderConfigsTable,
              CoverProviderConfigData
            >,
          ),
          CoverProviderConfigData,
          PrefetchHooks Function()
        > {
  $$CoverProviderConfigsTableTableManager(
    _$AppDatabase db,
    $CoverProviderConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoverProviderConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoverProviderConfigsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CoverProviderConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String?> config = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoverProviderConfigsCompanion(
                id: id,
                sourceId: sourceId,
                enabled: enabled,
                priority: priority,
                config: config,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceId,
                Value<bool> enabled = const Value.absent(),
                required int priority,
                Value<String?> config = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoverProviderConfigsCompanion.insert(
                id: id,
                sourceId: sourceId,
                enabled: enabled,
                priority: priority,
                config: config,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoverProviderConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoverProviderConfigsTable,
      CoverProviderConfigData,
      $$CoverProviderConfigsTableFilterComposer,
      $$CoverProviderConfigsTableOrderingComposer,
      $$CoverProviderConfigsTableAnnotationComposer,
      $$CoverProviderConfigsTableCreateCompanionBuilder,
      $$CoverProviderConfigsTableUpdateCompanionBuilder,
      (
        CoverProviderConfigData,
        BaseReferences<
          _$AppDatabase,
          $CoverProviderConfigsTable,
          CoverProviderConfigData
        >,
      ),
      CoverProviderConfigData,
      PrefetchHooks Function()
    >;
typedef $$LyricsCacheTableCreateCompanionBuilder =
    LyricsCacheCompanion Function({
      required String songId,
      required String sourceId,
      required String content,
      Value<bool> hasSynced,
      Value<String?> languages,
      required int fetchedAt,
      Value<int> rowid,
    });
typedef $$LyricsCacheTableUpdateCompanionBuilder =
    LyricsCacheCompanion Function({
      Value<String> songId,
      Value<String> sourceId,
      Value<String> content,
      Value<bool> hasSynced,
      Value<String?> languages,
      Value<int> fetchedAt,
      Value<int> rowid,
    });

class $$LyricsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSynced => $composableBuilder(
    column: $table.hasSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languages => $composableBuilder(
    column: $table.languages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LyricsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSynced => $composableBuilder(
    column: $table.hasSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languages => $composableBuilder(
    column: $table.languages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LyricsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get hasSynced =>
      $composableBuilder(column: $table.hasSynced, builder: (column) => column);

  GeneratedColumn<String> get languages =>
      $composableBuilder(column: $table.languages, builder: (column) => column);

  GeneratedColumn<int> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$LyricsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LyricsCacheTable,
          LyricsCacheData,
          $$LyricsCacheTableFilterComposer,
          $$LyricsCacheTableOrderingComposer,
          $$LyricsCacheTableAnnotationComposer,
          $$LyricsCacheTableCreateCompanionBuilder,
          $$LyricsCacheTableUpdateCompanionBuilder,
          (
            LyricsCacheData,
            BaseReferences<_$AppDatabase, $LyricsCacheTable, LyricsCacheData>,
          ),
          LyricsCacheData,
          PrefetchHooks Function()
        > {
  $$LyricsCacheTableTableManager(_$AppDatabase db, $LyricsCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LyricsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LyricsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LyricsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> songId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<bool> hasSynced = const Value.absent(),
                Value<String?> languages = const Value.absent(),
                Value<int> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LyricsCacheCompanion(
                songId: songId,
                sourceId: sourceId,
                content: content,
                hasSynced: hasSynced,
                languages: languages,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String songId,
                required String sourceId,
                required String content,
                Value<bool> hasSynced = const Value.absent(),
                Value<String?> languages = const Value.absent(),
                required int fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => LyricsCacheCompanion.insert(
                songId: songId,
                sourceId: sourceId,
                content: content,
                hasSynced: hasSynced,
                languages: languages,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LyricsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LyricsCacheTable,
      LyricsCacheData,
      $$LyricsCacheTableFilterComposer,
      $$LyricsCacheTableOrderingComposer,
      $$LyricsCacheTableAnnotationComposer,
      $$LyricsCacheTableCreateCompanionBuilder,
      $$LyricsCacheTableUpdateCompanionBuilder,
      (
        LyricsCacheData,
        BaseReferences<_$AppDatabase, $LyricsCacheTable, LyricsCacheData>,
      ),
      LyricsCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MusicLibrariesTableTableManager get musicLibraries =>
      $$MusicLibrariesTableTableManager(_db, _db.musicLibraries);
  $$ServerAddressesTableTableManager get serverAddresses =>
      $$ServerAddressesTableTableManager(_db, _db.serverAddresses);
  $$LyricsProviderConfigsTableTableManager get lyricsProviderConfigs =>
      $$LyricsProviderConfigsTableTableManager(_db, _db.lyricsProviderConfigs);
  $$CoverProviderConfigsTableTableManager get coverProviderConfigs =>
      $$CoverProviderConfigsTableTableManager(_db, _db.coverProviderConfigs);
  $$LyricsCacheTableTableManager get lyricsCache =>
      $$LyricsCacheTableTableManager(_db, _db.lyricsCache);
}
