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

class $DownloadTasksTable extends DownloadTasks
    with TableInfo<$DownloadTasksTable, DownloadTaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadTasksTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
    'song_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
    'album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverArtMeta = const VerificationMeta(
    'coverArt',
  );
  @override
  late final GeneratedColumn<String> coverArt = GeneratedColumn<String>(
    'cover_art',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _suffixMeta = const VerificationMeta('suffix');
  @override
  late final GeneratedColumn<String> suffix = GeneratedColumn<String>(
    'suffix',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bitRateMeta = const VerificationMeta(
    'bitRate',
  );
  @override
  late final GeneratedColumn<int> bitRate = GeneratedColumn<int>(
    'bit_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    songId,
    title,
    artist,
    album,
    coverArt,
    duration,
    suffix,
    bitRate,
    contentType,
    filePath,
    fileSize,
    status,
    progress,
    errorMessage,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadTaskData> instance, {
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
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('album')) {
      context.handle(
        _albumMeta,
        album.isAcceptableOrUnknown(data['album']!, _albumMeta),
      );
    }
    if (data.containsKey('cover_art')) {
      context.handle(
        _coverArtMeta,
        coverArt.isAcceptableOrUnknown(data['cover_art']!, _coverArtMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('suffix')) {
      context.handle(
        _suffixMeta,
        suffix.isAcceptableOrUnknown(data['suffix']!, _suffixMeta),
      );
    }
    if (data.containsKey('bit_rate')) {
      context.handle(
        _bitRateMeta,
        bitRate.isAcceptableOrUnknown(data['bit_rate']!, _bitRateMeta),
      );
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
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
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {libraryId, songId},
  ];
  @override
  DownloadTaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadTaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      )!,
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}song_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      album: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album'],
      ),
      coverArt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_art'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      suffix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suffix'],
      ),
      bitRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bit_rate'],
      ),
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $DownloadTasksTable createAlias(String alias) {
    return $DownloadTasksTable(attachedDatabase, alias);
  }
}

class DownloadTaskData extends DataClass
    implements Insertable<DownloadTaskData> {
  final String id;
  final String libraryId;
  final String songId;
  final String title;
  final String? artist;
  final String? album;
  final String? coverArt;
  final int? duration;
  final String? suffix;
  final int? bitRate;
  final String? contentType;
  final String? filePath;
  final int? fileSize;
  final String status;
  final double progress;
  final String? errorMessage;
  final int createdAt;
  final int? completedAt;
  const DownloadTaskData({
    required this.id,
    required this.libraryId,
    required this.songId,
    required this.title,
    this.artist,
    this.album,
    this.coverArt,
    this.duration,
    this.suffix,
    this.bitRate,
    this.contentType,
    this.filePath,
    this.fileSize,
    required this.status,
    required this.progress,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['library_id'] = Variable<String>(libraryId);
    map['song_id'] = Variable<String>(songId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || coverArt != null) {
      map['cover_art'] = Variable<String>(coverArt);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || suffix != null) {
      map['suffix'] = Variable<String>(suffix);
    }
    if (!nullToAbsent || bitRate != null) {
      map['bit_rate'] = Variable<int>(bitRate);
    }
    if (!nullToAbsent || contentType != null) {
      map['content_type'] = Variable<String>(contentType);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    map['status'] = Variable<String>(status);
    map['progress'] = Variable<double>(progress);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    return map;
  }

  DownloadTasksCompanion toCompanion(bool nullToAbsent) {
    return DownloadTasksCompanion(
      id: Value(id),
      libraryId: Value(libraryId),
      songId: Value(songId),
      title: Value(title),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      album: album == null && nullToAbsent
          ? const Value.absent()
          : Value(album),
      coverArt: coverArt == null && nullToAbsent
          ? const Value.absent()
          : Value(coverArt),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      suffix: suffix == null && nullToAbsent
          ? const Value.absent()
          : Value(suffix),
      bitRate: bitRate == null && nullToAbsent
          ? const Value.absent()
          : Value(bitRate),
      contentType: contentType == null && nullToAbsent
          ? const Value.absent()
          : Value(contentType),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
      status: Value(status),
      progress: Value(progress),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DownloadTaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadTaskData(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String>(json['libraryId']),
      songId: serializer.fromJson<String>(json['songId']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      coverArt: serializer.fromJson<String?>(json['coverArt']),
      duration: serializer.fromJson<int?>(json['duration']),
      suffix: serializer.fromJson<String?>(json['suffix']),
      bitRate: serializer.fromJson<int?>(json['bitRate']),
      contentType: serializer.fromJson<String?>(json['contentType']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      fileSize: serializer.fromJson<int?>(json['fileSize']),
      status: serializer.fromJson<String>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String>(libraryId),
      'songId': serializer.toJson<String>(songId),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'coverArt': serializer.toJson<String?>(coverArt),
      'duration': serializer.toJson<int?>(duration),
      'suffix': serializer.toJson<String?>(suffix),
      'bitRate': serializer.toJson<int?>(bitRate),
      'contentType': serializer.toJson<String?>(contentType),
      'filePath': serializer.toJson<String?>(filePath),
      'fileSize': serializer.toJson<int?>(fileSize),
      'status': serializer.toJson<String>(status),
      'progress': serializer.toJson<double>(progress),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<int>(createdAt),
      'completedAt': serializer.toJson<int?>(completedAt),
    };
  }

  DownloadTaskData copyWith({
    String? id,
    String? libraryId,
    String? songId,
    String? title,
    Value<String?> artist = const Value.absent(),
    Value<String?> album = const Value.absent(),
    Value<String?> coverArt = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<String?> suffix = const Value.absent(),
    Value<int?> bitRate = const Value.absent(),
    Value<String?> contentType = const Value.absent(),
    Value<String?> filePath = const Value.absent(),
    Value<int?> fileSize = const Value.absent(),
    String? status,
    double? progress,
    Value<String?> errorMessage = const Value.absent(),
    int? createdAt,
    Value<int?> completedAt = const Value.absent(),
  }) => DownloadTaskData(
    id: id ?? this.id,
    libraryId: libraryId ?? this.libraryId,
    songId: songId ?? this.songId,
    title: title ?? this.title,
    artist: artist.present ? artist.value : this.artist,
    album: album.present ? album.value : this.album,
    coverArt: coverArt.present ? coverArt.value : this.coverArt,
    duration: duration.present ? duration.value : this.duration,
    suffix: suffix.present ? suffix.value : this.suffix,
    bitRate: bitRate.present ? bitRate.value : this.bitRate,
    contentType: contentType.present ? contentType.value : this.contentType,
    filePath: filePath.present ? filePath.value : this.filePath,
    fileSize: fileSize.present ? fileSize.value : this.fileSize,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DownloadTaskData copyWithCompanion(DownloadTasksCompanion data) {
    return DownloadTaskData(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      songId: data.songId.present ? data.songId.value : this.songId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      coverArt: data.coverArt.present ? data.coverArt.value : this.coverArt,
      duration: data.duration.present ? data.duration.value : this.duration,
      suffix: data.suffix.present ? data.suffix.value : this.suffix,
      bitRate: data.bitRate.present ? data.bitRate.value : this.bitRate,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTaskData(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('songId: $songId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('coverArt: $coverArt, ')
          ..write('duration: $duration, ')
          ..write('suffix: $suffix, ')
          ..write('bitRate: $bitRate, ')
          ..write('contentType: $contentType, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    songId,
    title,
    artist,
    album,
    coverArt,
    duration,
    suffix,
    bitRate,
    contentType,
    filePath,
    fileSize,
    status,
    progress,
    errorMessage,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadTaskData &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.songId == this.songId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.coverArt == this.coverArt &&
          other.duration == this.duration &&
          other.suffix == this.suffix &&
          other.bitRate == this.bitRate &&
          other.contentType == this.contentType &&
          other.filePath == this.filePath &&
          other.fileSize == this.fileSize &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class DownloadTasksCompanion extends UpdateCompanion<DownloadTaskData> {
  final Value<String> id;
  final Value<String> libraryId;
  final Value<String> songId;
  final Value<String> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<String?> coverArt;
  final Value<int?> duration;
  final Value<String?> suffix;
  final Value<int?> bitRate;
  final Value<String?> contentType;
  final Value<String?> filePath;
  final Value<int?> fileSize;
  final Value<String> status;
  final Value<double> progress;
  final Value<String?> errorMessage;
  final Value<int> createdAt;
  final Value<int?> completedAt;
  final Value<int> rowid;
  const DownloadTasksCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.songId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.coverArt = const Value.absent(),
    this.duration = const Value.absent(),
    this.suffix = const Value.absent(),
    this.bitRate = const Value.absent(),
    this.contentType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadTasksCompanion.insert({
    required String id,
    required String libraryId,
    required String songId,
    required String title,
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.coverArt = const Value.absent(),
    this.duration = const Value.absent(),
    this.suffix = const Value.absent(),
    this.bitRate = const Value.absent(),
    this.contentType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required int createdAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       libraryId = Value(libraryId),
       songId = Value(songId),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<DownloadTaskData> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? songId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? coverArt,
    Expression<int>? duration,
    Expression<String>? suffix,
    Expression<int>? bitRate,
    Expression<String>? contentType,
    Expression<String>? filePath,
    Expression<int>? fileSize,
    Expression<String>? status,
    Expression<double>? progress,
    Expression<String>? errorMessage,
    Expression<int>? createdAt,
    Expression<int>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (songId != null) 'song_id': songId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (coverArt != null) 'cover_art': coverArt,
      if (duration != null) 'duration': duration,
      if (suffix != null) 'suffix': suffix,
      if (bitRate != null) 'bit_rate': bitRate,
      if (contentType != null) 'content_type': contentType,
      if (filePath != null) 'file_path': filePath,
      if (fileSize != null) 'file_size': fileSize,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadTasksCompanion copyWith({
    Value<String>? id,
    Value<String>? libraryId,
    Value<String>? songId,
    Value<String>? title,
    Value<String?>? artist,
    Value<String?>? album,
    Value<String?>? coverArt,
    Value<int?>? duration,
    Value<String?>? suffix,
    Value<int?>? bitRate,
    Value<String?>? contentType,
    Value<String?>? filePath,
    Value<int?>? fileSize,
    Value<String>? status,
    Value<double>? progress,
    Value<String?>? errorMessage,
    Value<int>? createdAt,
    Value<int?>? completedAt,
    Value<int>? rowid,
  }) {
    return DownloadTasksCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      songId: songId ?? this.songId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      coverArt: coverArt ?? this.coverArt,
      duration: duration ?? this.duration,
      suffix: suffix ?? this.suffix,
      bitRate: bitRate ?? this.bitRate,
      contentType: contentType ?? this.contentType,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
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
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (coverArt.present) {
      map['cover_art'] = Variable<String>(coverArt.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (suffix.present) {
      map['suffix'] = Variable<String>(suffix.value);
    }
    if (bitRate.present) {
      map['bit_rate'] = Variable<int>(bitRate.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTasksCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('songId: $songId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('coverArt: $coverArt, ')
          ..write('duration: $duration, ')
          ..write('suffix: $suffix, ')
          ..write('bitRate: $bitRate, ')
          ..write('contentType: $contentType, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AudioCacheEntriesTable extends AudioCacheEntries
    with TableInfo<$AudioCacheEntriesTable, AudioCacheEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioCacheEntriesTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
    'song_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playCountMeta = const VerificationMeta(
    'playCount',
  );
  @override
  late final GeneratedColumn<int> playCount = GeneratedColumn<int>(
    'play_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastPlayedAtMeta = const VerificationMeta(
    'lastPlayedAt',
  );
  @override
  late final GeneratedColumn<int> lastPlayedAt = GeneratedColumn<int>(
    'last_played_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<int> cachedAt = GeneratedColumn<int>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompleteMeta = const VerificationMeta(
    'isComplete',
  );
  @override
  late final GeneratedColumn<bool> isComplete = GeneratedColumn<bool>(
    'is_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    libraryId,
    songId,
    quality,
    filePath,
    fileSize,
    playCount,
    lastPlayedAt,
    cachedAt,
    isComplete,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AudioCacheEntryData> instance, {
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
    if (data.containsKey('song_id')) {
      context.handle(
        _songIdMeta,
        songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta),
      );
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('play_count')) {
      context.handle(
        _playCountMeta,
        playCount.isAcceptableOrUnknown(data['play_count']!, _playCountMeta),
      );
    }
    if (data.containsKey('last_played_at')) {
      context.handle(
        _lastPlayedAtMeta,
        lastPlayedAt.isAcceptableOrUnknown(
          data['last_played_at']!,
          _lastPlayedAtMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('is_complete')) {
      context.handle(
        _isCompleteMeta,
        isComplete.isAcceptableOrUnknown(data['is_complete']!, _isCompleteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {libraryId, songId, quality},
  ];
  @override
  AudioCacheEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioCacheEntryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libraryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}library_id'],
      )!,
      songId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}song_id'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      playCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}play_count'],
      )!,
      lastPlayedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_played_at'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cached_at'],
      )!,
      isComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_complete'],
      )!,
    );
  }

  @override
  $AudioCacheEntriesTable createAlias(String alias) {
    return $AudioCacheEntriesTable(attachedDatabase, alias);
  }
}

class AudioCacheEntryData extends DataClass
    implements Insertable<AudioCacheEntryData> {
  final String id;
  final String libraryId;
  final String songId;
  final String quality;
  final String filePath;
  final int fileSize;
  final int playCount;
  final int? lastPlayedAt;
  final int cachedAt;
  final bool isComplete;
  const AudioCacheEntryData({
    required this.id,
    required this.libraryId,
    required this.songId,
    required this.quality,
    required this.filePath,
    required this.fileSize,
    required this.playCount,
    this.lastPlayedAt,
    required this.cachedAt,
    required this.isComplete,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['library_id'] = Variable<String>(libraryId);
    map['song_id'] = Variable<String>(songId);
    map['quality'] = Variable<String>(quality);
    map['file_path'] = Variable<String>(filePath);
    map['file_size'] = Variable<int>(fileSize);
    map['play_count'] = Variable<int>(playCount);
    if (!nullToAbsent || lastPlayedAt != null) {
      map['last_played_at'] = Variable<int>(lastPlayedAt);
    }
    map['cached_at'] = Variable<int>(cachedAt);
    map['is_complete'] = Variable<bool>(isComplete);
    return map;
  }

  AudioCacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return AudioCacheEntriesCompanion(
      id: Value(id),
      libraryId: Value(libraryId),
      songId: Value(songId),
      quality: Value(quality),
      filePath: Value(filePath),
      fileSize: Value(fileSize),
      playCount: Value(playCount),
      lastPlayedAt: lastPlayedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlayedAt),
      cachedAt: Value(cachedAt),
      isComplete: Value(isComplete),
    );
  }

  factory AudioCacheEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioCacheEntryData(
      id: serializer.fromJson<String>(json['id']),
      libraryId: serializer.fromJson<String>(json['libraryId']),
      songId: serializer.fromJson<String>(json['songId']),
      quality: serializer.fromJson<String>(json['quality']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      playCount: serializer.fromJson<int>(json['playCount']),
      lastPlayedAt: serializer.fromJson<int?>(json['lastPlayedAt']),
      cachedAt: serializer.fromJson<int>(json['cachedAt']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libraryId': serializer.toJson<String>(libraryId),
      'songId': serializer.toJson<String>(songId),
      'quality': serializer.toJson<String>(quality),
      'filePath': serializer.toJson<String>(filePath),
      'fileSize': serializer.toJson<int>(fileSize),
      'playCount': serializer.toJson<int>(playCount),
      'lastPlayedAt': serializer.toJson<int?>(lastPlayedAt),
      'cachedAt': serializer.toJson<int>(cachedAt),
      'isComplete': serializer.toJson<bool>(isComplete),
    };
  }

  AudioCacheEntryData copyWith({
    String? id,
    String? libraryId,
    String? songId,
    String? quality,
    String? filePath,
    int? fileSize,
    int? playCount,
    Value<int?> lastPlayedAt = const Value.absent(),
    int? cachedAt,
    bool? isComplete,
  }) => AudioCacheEntryData(
    id: id ?? this.id,
    libraryId: libraryId ?? this.libraryId,
    songId: songId ?? this.songId,
    quality: quality ?? this.quality,
    filePath: filePath ?? this.filePath,
    fileSize: fileSize ?? this.fileSize,
    playCount: playCount ?? this.playCount,
    lastPlayedAt: lastPlayedAt.present ? lastPlayedAt.value : this.lastPlayedAt,
    cachedAt: cachedAt ?? this.cachedAt,
    isComplete: isComplete ?? this.isComplete,
  );
  AudioCacheEntryData copyWithCompanion(AudioCacheEntriesCompanion data) {
    return AudioCacheEntryData(
      id: data.id.present ? data.id.value : this.id,
      libraryId: data.libraryId.present ? data.libraryId.value : this.libraryId,
      songId: data.songId.present ? data.songId.value : this.songId,
      quality: data.quality.present ? data.quality.value : this.quality,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      playCount: data.playCount.present ? data.playCount.value : this.playCount,
      lastPlayedAt: data.lastPlayedAt.present
          ? data.lastPlayedAt.value
          : this.lastPlayedAt,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      isComplete: data.isComplete.present
          ? data.isComplete.value
          : this.isComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AudioCacheEntryData(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('songId: $songId, ')
          ..write('quality: $quality, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('playCount: $playCount, ')
          ..write('lastPlayedAt: $lastPlayedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    libraryId,
    songId,
    quality,
    filePath,
    fileSize,
    playCount,
    lastPlayedAt,
    cachedAt,
    isComplete,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioCacheEntryData &&
          other.id == this.id &&
          other.libraryId == this.libraryId &&
          other.songId == this.songId &&
          other.quality == this.quality &&
          other.filePath == this.filePath &&
          other.fileSize == this.fileSize &&
          other.playCount == this.playCount &&
          other.lastPlayedAt == this.lastPlayedAt &&
          other.cachedAt == this.cachedAt &&
          other.isComplete == this.isComplete);
}

class AudioCacheEntriesCompanion extends UpdateCompanion<AudioCacheEntryData> {
  final Value<String> id;
  final Value<String> libraryId;
  final Value<String> songId;
  final Value<String> quality;
  final Value<String> filePath;
  final Value<int> fileSize;
  final Value<int> playCount;
  final Value<int?> lastPlayedAt;
  final Value<int> cachedAt;
  final Value<bool> isComplete;
  final Value<int> rowid;
  const AudioCacheEntriesCompanion({
    this.id = const Value.absent(),
    this.libraryId = const Value.absent(),
    this.songId = const Value.absent(),
    this.quality = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.playCount = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.isComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AudioCacheEntriesCompanion.insert({
    required String id,
    required String libraryId,
    required String songId,
    required String quality,
    required String filePath,
    required int fileSize,
    this.playCount = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
    required int cachedAt,
    this.isComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       libraryId = Value(libraryId),
       songId = Value(songId),
       quality = Value(quality),
       filePath = Value(filePath),
       fileSize = Value(fileSize),
       cachedAt = Value(cachedAt);
  static Insertable<AudioCacheEntryData> custom({
    Expression<String>? id,
    Expression<String>? libraryId,
    Expression<String>? songId,
    Expression<String>? quality,
    Expression<String>? filePath,
    Expression<int>? fileSize,
    Expression<int>? playCount,
    Expression<int>? lastPlayedAt,
    Expression<int>? cachedAt,
    Expression<bool>? isComplete,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libraryId != null) 'library_id': libraryId,
      if (songId != null) 'song_id': songId,
      if (quality != null) 'quality': quality,
      if (filePath != null) 'file_path': filePath,
      if (fileSize != null) 'file_size': fileSize,
      if (playCount != null) 'play_count': playCount,
      if (lastPlayedAt != null) 'last_played_at': lastPlayedAt,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (isComplete != null) 'is_complete': isComplete,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AudioCacheEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? libraryId,
    Value<String>? songId,
    Value<String>? quality,
    Value<String>? filePath,
    Value<int>? fileSize,
    Value<int>? playCount,
    Value<int?>? lastPlayedAt,
    Value<int>? cachedAt,
    Value<bool>? isComplete,
    Value<int>? rowid,
  }) {
    return AudioCacheEntriesCompanion(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      songId: songId ?? this.songId,
      quality: quality ?? this.quality,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      playCount: playCount ?? this.playCount,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      cachedAt: cachedAt ?? this.cachedAt,
      isComplete: isComplete ?? this.isComplete,
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
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (playCount.present) {
      map['play_count'] = Variable<int>(playCount.value);
    }
    if (lastPlayedAt.present) {
      map['last_played_at'] = Variable<int>(lastPlayedAt.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<int>(cachedAt.value);
    }
    if (isComplete.present) {
      map['is_complete'] = Variable<bool>(isComplete.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioCacheEntriesCompanion(')
          ..write('id: $id, ')
          ..write('libraryId: $libraryId, ')
          ..write('songId: $songId, ')
          ..write('quality: $quality, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('playCount: $playCount, ')
          ..write('lastPlayedAt: $lastPlayedAt, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('isComplete: $isComplete, ')
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
  late final $DownloadTasksTable downloadTasks = $DownloadTasksTable(this);
  late final $AudioCacheEntriesTable audioCacheEntries =
      $AudioCacheEntriesTable(this);
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
    downloadTasks,
    audioCacheEntries,
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
typedef $$DownloadTasksTableCreateCompanionBuilder =
    DownloadTasksCompanion Function({
      required String id,
      required String libraryId,
      required String songId,
      required String title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> coverArt,
      Value<int?> duration,
      Value<String?> suffix,
      Value<int?> bitRate,
      Value<String?> contentType,
      Value<String?> filePath,
      Value<int?> fileSize,
      Value<String> status,
      Value<double> progress,
      Value<String?> errorMessage,
      required int createdAt,
      Value<int?> completedAt,
      Value<int> rowid,
    });
typedef $$DownloadTasksTableUpdateCompanionBuilder =
    DownloadTasksCompanion Function({
      Value<String> id,
      Value<String> libraryId,
      Value<String> songId,
      Value<String> title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> coverArt,
      Value<int?> duration,
      Value<String?> suffix,
      Value<int?> bitRate,
      Value<String?> contentType,
      Value<String?> filePath,
      Value<int?> fileSize,
      Value<String> status,
      Value<double> progress,
      Value<String?> errorMessage,
      Value<int> createdAt,
      Value<int?> completedAt,
      Value<int> rowid,
    });

class $$DownloadTasksTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableFilterComposer({
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

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverArt => $composableBuilder(
    column: $table.coverArt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bitRate => $composableBuilder(
    column: $table.bitRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DownloadTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableOrderingComposer({
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

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverArt => $composableBuilder(
    column: $table.coverArt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suffix => $composableBuilder(
    column: $table.suffix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bitRate => $composableBuilder(
    column: $table.bitRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DownloadTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<String> get coverArt =>
      $composableBuilder(column: $table.coverArt, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get suffix =>
      $composableBuilder(column: $table.suffix, builder: (column) => column);

  GeneratedColumn<int> get bitRate =>
      $composableBuilder(column: $table.bitRate, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$DownloadTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DownloadTasksTable,
          DownloadTaskData,
          $$DownloadTasksTableFilterComposer,
          $$DownloadTasksTableOrderingComposer,
          $$DownloadTasksTableAnnotationComposer,
          $$DownloadTasksTableCreateCompanionBuilder,
          $$DownloadTasksTableUpdateCompanionBuilder,
          (
            DownloadTaskData,
            BaseReferences<
              _$AppDatabase,
              $DownloadTasksTable,
              DownloadTaskData
            >,
          ),
          DownloadTaskData,
          PrefetchHooks Function()
        > {
  $$DownloadTasksTableTableManager(_$AppDatabase db, $DownloadTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> libraryId = const Value.absent(),
                Value<String> songId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> coverArt = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> suffix = const Value.absent(),
                Value<int?> bitRate = const Value.absent(),
                Value<String?> contentType = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadTasksCompanion(
                id: id,
                libraryId: libraryId,
                songId: songId,
                title: title,
                artist: artist,
                album: album,
                coverArt: coverArt,
                duration: duration,
                suffix: suffix,
                bitRate: bitRate,
                contentType: contentType,
                filePath: filePath,
                fileSize: fileSize,
                status: status,
                progress: progress,
                errorMessage: errorMessage,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String libraryId,
                required String songId,
                required String title,
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> coverArt = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> suffix = const Value.absent(),
                Value<int?> bitRate = const Value.absent(),
                Value<String?> contentType = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required int createdAt,
                Value<int?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DownloadTasksCompanion.insert(
                id: id,
                libraryId: libraryId,
                songId: songId,
                title: title,
                artist: artist,
                album: album,
                coverArt: coverArt,
                duration: duration,
                suffix: suffix,
                bitRate: bitRate,
                contentType: contentType,
                filePath: filePath,
                fileSize: fileSize,
                status: status,
                progress: progress,
                errorMessage: errorMessage,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DownloadTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DownloadTasksTable,
      DownloadTaskData,
      $$DownloadTasksTableFilterComposer,
      $$DownloadTasksTableOrderingComposer,
      $$DownloadTasksTableAnnotationComposer,
      $$DownloadTasksTableCreateCompanionBuilder,
      $$DownloadTasksTableUpdateCompanionBuilder,
      (
        DownloadTaskData,
        BaseReferences<_$AppDatabase, $DownloadTasksTable, DownloadTaskData>,
      ),
      DownloadTaskData,
      PrefetchHooks Function()
    >;
typedef $$AudioCacheEntriesTableCreateCompanionBuilder =
    AudioCacheEntriesCompanion Function({
      required String id,
      required String libraryId,
      required String songId,
      required String quality,
      required String filePath,
      required int fileSize,
      Value<int> playCount,
      Value<int?> lastPlayedAt,
      required int cachedAt,
      Value<bool> isComplete,
      Value<int> rowid,
    });
typedef $$AudioCacheEntriesTableUpdateCompanionBuilder =
    AudioCacheEntriesCompanion Function({
      Value<String> id,
      Value<String> libraryId,
      Value<String> songId,
      Value<String> quality,
      Value<String> filePath,
      Value<int> fileSize,
      Value<int> playCount,
      Value<int?> lastPlayedAt,
      Value<int> cachedAt,
      Value<bool> isComplete,
      Value<int> rowid,
    });

class $$AudioCacheEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AudioCacheEntriesTable> {
  $$AudioCacheEntriesTableFilterComposer({
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

  ColumnFilters<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playCount => $composableBuilder(
    column: $table.playCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AudioCacheEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AudioCacheEntriesTable> {
  $$AudioCacheEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get libraryId => $composableBuilder(
    column: $table.libraryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get songId => $composableBuilder(
    column: $table.songId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playCount => $composableBuilder(
    column: $table.playCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AudioCacheEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AudioCacheEntriesTable> {
  $$AudioCacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libraryId =>
      $composableBuilder(column: $table.libraryId, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<int> get playCount =>
      $composableBuilder(column: $table.playCount, builder: (column) => column);

  GeneratedColumn<int> get lastPlayedAt => $composableBuilder(
    column: $table.lastPlayedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<bool> get isComplete => $composableBuilder(
    column: $table.isComplete,
    builder: (column) => column,
  );
}

class $$AudioCacheEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AudioCacheEntriesTable,
          AudioCacheEntryData,
          $$AudioCacheEntriesTableFilterComposer,
          $$AudioCacheEntriesTableOrderingComposer,
          $$AudioCacheEntriesTableAnnotationComposer,
          $$AudioCacheEntriesTableCreateCompanionBuilder,
          $$AudioCacheEntriesTableUpdateCompanionBuilder,
          (
            AudioCacheEntryData,
            BaseReferences<
              _$AppDatabase,
              $AudioCacheEntriesTable,
              AudioCacheEntryData
            >,
          ),
          AudioCacheEntryData,
          PrefetchHooks Function()
        > {
  $$AudioCacheEntriesTableTableManager(
    _$AppDatabase db,
    $AudioCacheEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AudioCacheEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AudioCacheEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AudioCacheEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> libraryId = const Value.absent(),
                Value<String> songId = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<int> playCount = const Value.absent(),
                Value<int?> lastPlayedAt = const Value.absent(),
                Value<int> cachedAt = const Value.absent(),
                Value<bool> isComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AudioCacheEntriesCompanion(
                id: id,
                libraryId: libraryId,
                songId: songId,
                quality: quality,
                filePath: filePath,
                fileSize: fileSize,
                playCount: playCount,
                lastPlayedAt: lastPlayedAt,
                cachedAt: cachedAt,
                isComplete: isComplete,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String libraryId,
                required String songId,
                required String quality,
                required String filePath,
                required int fileSize,
                Value<int> playCount = const Value.absent(),
                Value<int?> lastPlayedAt = const Value.absent(),
                required int cachedAt,
                Value<bool> isComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AudioCacheEntriesCompanion.insert(
                id: id,
                libraryId: libraryId,
                songId: songId,
                quality: quality,
                filePath: filePath,
                fileSize: fileSize,
                playCount: playCount,
                lastPlayedAt: lastPlayedAt,
                cachedAt: cachedAt,
                isComplete: isComplete,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AudioCacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AudioCacheEntriesTable,
      AudioCacheEntryData,
      $$AudioCacheEntriesTableFilterComposer,
      $$AudioCacheEntriesTableOrderingComposer,
      $$AudioCacheEntriesTableAnnotationComposer,
      $$AudioCacheEntriesTableCreateCompanionBuilder,
      $$AudioCacheEntriesTableUpdateCompanionBuilder,
      (
        AudioCacheEntryData,
        BaseReferences<
          _$AppDatabase,
          $AudioCacheEntriesTable,
          AudioCacheEntryData
        >,
      ),
      AudioCacheEntryData,
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
  $$DownloadTasksTableTableManager get downloadTasks =>
      $$DownloadTasksTableTableManager(_db, _db.downloadTasks);
  $$AudioCacheEntriesTableTableManager get audioCacheEntries =>
      $$AudioCacheEntriesTableTableManager(_db, _db.audioCacheEntries);
}
