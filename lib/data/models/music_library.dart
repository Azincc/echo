import 'package:echo/data/models/server_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'music_library.freezed.dart';
part 'music_library.g.dart';

@freezed
sealed class MusicLibrary with _$MusicLibrary {
  const factory MusicLibrary({
    required String id,
    required String name,
    @Default(MusicLibraryAuthType.token) MusicLibraryAuthType authType,
    String? username,
    String? password, // Encrypted
    String? apiKey, // Encrypted
    String? serverType,
    String? serverVersion,
    @Default(false) bool isOpenSubsonic,
    @Default({}) Map<String, dynamic> extensions,
    @Default(false) bool isActive,
    @Default([]) List<ServerAddress> addresses,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MusicLibrary;

  factory MusicLibrary.fromJson(Map<String, dynamic> json) =>
      _$MusicLibraryFromJson(json);
}

enum MusicLibraryAuthType { token, apiKey }
