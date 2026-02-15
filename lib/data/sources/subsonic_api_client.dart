import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/subsonic_auth.dart';
import '../../core/utils/logger.dart';
import '../models/music_library.dart';

/// Subsonic API Client
/// Updated to support MusicLibrary model and injected Dio.
class SubsonicApiClient {
  final Dio _dio;
  MusicLibrary? _library;

  SubsonicApiClient({required Dio dio}) : _dio = dio {
    // Remove any existing auth interceptor (may reference a stale client instance)
    // then add a new one pointing to this client.
    _dio.interceptors.removeWhere((i) => i is _SubsonicAuthInterceptor);
    _dio.interceptors.add(_SubsonicAuthInterceptor(this));
  }

  /// Set the current music library configuration
  void setLibrary(MusicLibrary? library) {
    _library = library;
    // Note: Base URL is handled by AddressPool/Dio options updates in Provider.
    // Here we just store library for Auth params.
  }

  MusicLibrary? get library => _library;

  /// Check response status (Subsonic specific)
  void _checkResponse(Map<String, dynamic> data) {
    if (!data.containsKey('subsonic-response')) {
      // Some servers might return plain JSON if error?
      // throw Exception('Invalid response: missing subsonic-response');
      return; // Or throw?
    }
    final response = data['subsonic-response'];
    if (response == null) return;

    final status = response['status'];
    if (status != 'ok') {
      final error = response['error'];
      final message = error?['message'] ?? 'Unknown error';
      final code = error?['code'] ?? 0;
      throw SubsonicException(message, code);
    }
  }

  /// Ping
  Future<PingResult> ping() async {
    try {
      final response = await _dio.get(ApiConstants.ping);
      final data = response.data as Map<String, dynamic>;
      _checkResponse(data);

      final subsonicResponse = data['subsonic-response'];

      return PingResult(
        success: true,
        isOpenSubsonic: subsonicResponse['openSubsonic'] == true,
        serverType: subsonicResponse['type'] as String?,
        serverVersion: subsonicResponse['serverVersion'] as String?,
      );
    } on DioException catch (e) {
      Logger.error('Ping failed', e);
      return PingResult(success: false, errorMessage: e.message);
    } catch (e) {
      Logger.error('Ping failed', e);
      return PingResult(success: false, errorMessage: e.toString());
    }
  }

  /// Get OpenSubsonic Extensions
  Future<List<String>> getOpenSubsonicExtensions() async {
    try {
      final response = await _dio.get(ApiConstants.getOpenSubsonicExtensions);
      final data = response.data as Map<String, dynamic>;
      _checkResponse(data);

      final subsonicResponse = data['subsonic-response'];
      final extensions = subsonicResponse['openSubsonicExtensions'] as List?;

      if (extensions == null) return [];

      return extensions
          .map((e) => (e as Map<String, dynamic>)['name'] as String)
          .toList();
    } catch (e) {
      Logger.warn('Failed to get OpenSubsonic extensions', e);
      return [];
    }
  }

  /// Generic GET
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    final data = response.data as Map<String, dynamic>;
    _checkResponse(data);
    return data['subsonic-response'];
  }

  /// Generic POST
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    final response = await _dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    final responseData = response.data as Map<String, dynamic>;
    _checkResponse(responseData);
    return responseData['subsonic-response'];
  }

  /// Get Dio instance
  Dio get dio => _dio;

  /// Generate Cover Art URL
  String getCoverArtUrl(String coverArtId, {int? size}) {
    if (_library == null) return '';
    // Use current dio baseUrl
    final baseUrl = _dio.options.baseUrl;
    if (baseUrl.isEmpty) return '';

    final params = <String, String>{};
    _addAuthParamsMap(params);

    params['id'] = coverArtId;
    if (size != null) {
      params['size'] = size.toString();
    }

    final uri = Uri.parse(baseUrl + ApiConstants.getCoverArt);
    final urlWithParams = uri.replace(queryParameters: params);
    return urlWithParams.toString();
  }

  /// Generate Stream URL
  String getStreamUrl(
    String songId, {
    int? maxBitRate,
    String? format,
    int? timeOffset,
  }) {
    if (_library == null) return '';
    final baseUrl = _dio.options.baseUrl;
    if (baseUrl.isEmpty) return '';

    final params = <String, String>{};
    _addAuthParamsMap(params);

    params['id'] = songId;
    if (maxBitRate != null) {
      params['maxBitRate'] = maxBitRate.toString();
    }
    if (format != null) {
      params['format'] = format;
    }
    if (timeOffset != null && timeOffset > 0) {
      params['timeOffset'] = timeOffset.toString();
    }

    // 流式播放始终使用 /rest/stream（包括转码）
    final uri = Uri.parse(baseUrl + ApiConstants.stream);
    final urlWithParams = uri.replace(queryParameters: params);
    return urlWithParams.toString();
  }

  /// Generate Download URL（始终下载原始无损文件）
  String getDownloadUrl(String songId) {
    if (_library == null) return '';
    final baseUrl = _dio.options.baseUrl;
    if (baseUrl.isEmpty) return '';

    final params = <String, String>{};
    _addAuthParamsMap(params);
    params['id'] = songId;

    final uri = Uri.parse(baseUrl + ApiConstants.download);
    final urlWithParams = uri.replace(queryParameters: params);
    return urlWithParams.toString();
  }

  /// Get Music Folders
  Future<List<Map<String, dynamic>>> getMusicFolders() async {
    try {
      final response = await _dio.get(ApiConstants.getMusicFolders);
      final data = response.data as Map<String, dynamic>;
      _checkResponse(data);

      final subsonicResponse = data['subsonic-response'];
      final folders = subsonicResponse['musicFolders']?['musicFolder'];

      if (folders is List) {
        return folders.cast<Map<String, dynamic>>();
      } else if (folders is Map) {
        // Single folder potentially
        return [folders as Map<String, dynamic>];
      }
      return [];
    } catch (e) {
      Logger.warn('Failed to get music folders', e);
      return [];
    }
  }

  void _addAuthParamsMap(Map<String, String> params) {
    if (_library == null) {
      // Just common params if no library
      params['v'] = ApiConstants.apiVersion;
      params['c'] = ApiConstants.clientName;
      params['f'] = ApiConstants.format;
      return;
    }

    if (_library!.authType == MusicLibraryAuthType.apiKey &&
        _library!.apiKey != null) {
      params.addAll(
        SubsonicAuth.generateApiKeyAuthParams(
          apiKey: _library!.apiKey!,
          version: ApiConstants.apiVersion,
          clientName: ApiConstants.clientName,
          format: ApiConstants.format,
        ),
      );
    } else if (_library!.password != null) {
      params.addAll(
        SubsonicAuth.generateTokenAuthParams(
          username: _library!.username ?? '',
          password: _library!.password!,
          version: ApiConstants.apiVersion,
          clientName: ApiConstants.clientName,
          format: ApiConstants.format,
        ),
      );
    } else {
      // Only common params if auth data incomplete
      params['v'] = ApiConstants.apiVersion;
      params['c'] = ApiConstants.clientName;
      params['f'] = ApiConstants.format;
    }
  }
}

class _SubsonicAuthInterceptor extends Interceptor {
  final SubsonicApiClient _client;
  _SubsonicAuthInterceptor(this._client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final params = <String, String>{};
    _client._addAuthParamsMap(params);
    options.queryParameters.addAll(params);
    handler.next(options);
  }
}

class PingResult {
  final bool success;
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final String? errorMessage;

  PingResult({
    required this.success,
    this.isOpenSubsonic = false,
    this.serverType,
    this.serverVersion,
    this.errorMessage,
  });
}

class SubsonicException implements Exception {
  final String message;
  final int code;
  SubsonicException(this.message, this.code);
  @override
  String toString() => 'SubsonicException: $message (code: $code)';
}
