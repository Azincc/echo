import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../models/music_library.dart'; // New model
import '../models/server_address.dart'; // New model
import '../sources/subsonic_api_client.dart';
import '../../core/utils/logger.dart';

/// Authentication Repository
/// Handles login verification. Persistence is now handled by LibraryRepository.
class AuthRepository {
  // We handle ephemeral clients internally for verification

  AuthRepository();

  /// Detect Server Capabilities
  Future<ServerCapabilities> detectServerCapabilities(String serverUrl) async {
    try {
      final tempDio = Dio(
        BaseOptions(
          baseUrl: serverUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          responseType: ResponseType.json,
        ),
      );

      final tempClient = SubsonicApiClient(dio: tempDio);
      // No setLibrary needed for initial ping if we only check openSubsonic response structure?
      // Actually ping needs auth usually.
      // But OpenSubsonic servers might respond to ping without auth?
      // Let's try with empty auth.

      // We can create a dummy library
      tempClient.setLibrary(
        MusicLibrary(
          id: 'temp',
          name: 'temp',
          authType: MusicLibraryAuthType.token,
          username: '',
          password: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      try {
        final result = await tempClient.ping();
        return ServerCapabilities(
          isOpenSubsonic: result.isOpenSubsonic,
          serverType: result.serverType,
          serverVersion: result.serverVersion,
          supportsApiKey: result.isOpenSubsonic,
        );
      } catch (e) {
        return ServerCapabilities(isOpenSubsonic: false, supportsApiKey: false);
      }
    } catch (e) {
      Logger.error('Failed to detect server capabilities', e);
      rethrow;
    }
  }

  /// Login with Token/Salt (Password)
  Future<LoginResult> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    return _attemptLogin(
      serverUrl: serverUrl,
      username: username,
      authType: MusicLibraryAuthType.token,
      password: password,
    );
  }

  /// Login with API Key
  Future<LoginResult> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
  }) async {
    return _attemptLogin(
      serverUrl: serverUrl,
      username: username,
      authType: MusicLibraryAuthType.apiKey,
      apiKey: apiKey,
    );
  }

  Future<LoginResult> _attemptLogin({
    required String serverUrl,
    required String username,
    required MusicLibraryAuthType authType,
    String? password,
    String? apiKey,
  }) async {
    try {
      final tempDio = Dio(
        BaseOptions(
          baseUrl: serverUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      );

      final tempClient = SubsonicApiClient(dio: tempDio);

      final tempLib = MusicLibrary(
        id: const Uuid().v4(),
        name: 'Temp',
        authType: authType,
        username: username,
        password: password,
        apiKey: apiKey,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      tempClient.setLibrary(tempLib);

      // Ping
      final pingResult = await tempClient.ping();

      if (!pingResult.success) {
        return LoginResult(
          success: false,
          errorMessage: pingResult.errorMessage ?? 'Connection failed',
        );
      }

      // Get Extensions if OpenSubsonic
      Map<String, dynamic> extensions = {};
      if (pingResult.isOpenSubsonic) {
        try {
          final exts = await tempClient.getOpenSubsonicExtensions();
          // Store as map or list? Model says map.
          // Actually model says Map<String, dynamic> extensions
          // The API returns List<String>.
          // Let's store it as {'list': [...]}?
          // Or change model? The model says Map<String, dynamic>.
          // Let's just say extensions['supported'] = [list]
          extensions = {'supported': exts};
        } catch (_) {}
      }

      // Create final MusicLibrary object
      // Define initial address
      final address = ServerAddress(
        id: const Uuid().v4(),
        libraryId: tempLib.id,
        label: 'Primary',
        url: serverUrl,
        priority: 0,
        status: ServerAddressStatus.ok,
        lastLatencyMs: 0, // We could measure this
      );

      final finalLib = tempLib.copyWith(
        name: pingResult.serverType ?? 'Subsonic Server', // Default name
        serverType: pingResult.serverType,
        serverVersion: pingResult.serverVersion,
        isOpenSubsonic: pingResult.isOpenSubsonic,
        extensions: extensions,
        addresses: [address],
        isActive: true, // Will be made active
      );

      return LoginResult(success: true, library: finalLib);
    } catch (e) {
      Logger.error('Login failed', e);
      return LoginResult(success: false, errorMessage: e.toString());
    }
  }

  // Legacy load/logout methods are removed as they are handled by LibraryRepository
}

class ServerCapabilities {
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final bool supportsApiKey;

  ServerCapabilities({
    required this.isOpenSubsonic,
    this.serverType,
    this.serverVersion,
    required this.supportsApiKey,
  });
}

class LoginResult {
  final bool success;
  final MusicLibrary? library;
  final String? errorMessage;

  LoginResult({required this.success, this.library, this.errorMessage});
}
