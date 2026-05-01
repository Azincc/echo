import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/embed_service_config.dart';
import '../../models/song.dart';

/// Embed Service 任务状态
class EmbedJobStatus {
  final String jobId;
  final String
  status; // queued/resolving/downloading/tagging/moving/scanning/done/failed/cancelled
  final String? title;
  final String? artist;
  final String? album;
  final String? source;
  final int? progress; // 0-100
  final String? message;
  final String? error;
  final int? totalBytes;
  final int? completedBytes;
  final String? filePath;
  final int? fileSize;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EmbedJobStatus({
    required this.jobId,
    required this.status,
    this.title,
    this.artist,
    this.album,
    this.source,
    this.progress,
    this.message,
    this.error,
    this.totalBytes,
    this.completedBytes,
    this.filePath,
    this.fileSize,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmbedJobStatus.fromJson(Map<String, dynamic> json) {
    return EmbedJobStatus(
      jobId: json['id'] as String? ?? json['job_id'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      title: json['title'] as String?,
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      source: json['source'] as String?,
      progress: json['progress'] as int?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      totalBytes: json['total_bytes'] as int?,
      completedBytes: json['completed_bytes'] as int?,
      filePath: json['file_path'] as String?,
      fileSize: json['file_size'] as int?,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  bool get isActive =>
      status == 'queued' ||
      status == 'resolving' ||
      status == 'downloading' ||
      status == 'tagging' ||
      status == 'moving' ||
      status == 'scanning';

  bool get isFailed => status == 'failed';
  bool get isDone => status == 'done';
  bool get isCancelled => status == 'cancelled';

  double get progressRatio {
    if (progress != null) return progress! / 100.0;
    if (totalBytes != null && totalBytes! > 0 && completedBytes != null) {
      return completedBytes! / totalBytes!;
    }
    return 0;
  }

  String get statusDisplayName => switch (status) {
    'queued' => '等待中',
    'resolving' => '解析中',
    'downloading' => '下载中',
    'tagging' => '写入标签',
    'moving' => '移动文件',
    'scanning' => '扫描中',
    'done' => '已完成',
    'failed' => '失败',
    'cancelled' => '已取消',
    _ => status,
  };

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }
}

class EditableSongMetadata {
  final String title;
  final String artist;
  final String album;
  final String albumArtist;
  final int trackNumber;
  final int discNumber;
  final int year;
  final String genre;
  final String lyrics;
  final String coverUrl;
  final String comment;
  final String composer;
  final String label;

  const EditableSongMetadata({
    this.title = '',
    this.artist = '',
    this.album = '',
    this.albumArtist = '',
    this.trackNumber = 0,
    this.discNumber = 0,
    this.year = 0,
    this.genre = '',
    this.lyrics = '',
    this.coverUrl = '',
    this.comment = '',
    this.composer = '',
    this.label = '',
  });

  factory EditableSongMetadata.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EditableSongMetadata();
    return EditableSongMetadata(
      title: (json['title'] as String? ?? '').trim(),
      artist: (json['artist'] as String? ?? '').trim(),
      album: (json['album'] as String? ?? '').trim(),
      albumArtist: (json['albumArtist'] as String? ?? '').trim(),
      trackNumber: _toInt(json['trackNumber']),
      discNumber: _toInt(json['discNumber']),
      year: _toInt(json['year']),
      genre: (json['genre'] as String? ?? '').trim(),
      lyrics: (json['lyrics'] as String? ?? '').trim(),
      coverUrl: (json['coverUrl'] as String? ?? '').trim(),
      comment: (json['comment'] as String? ?? '').trim(),
      composer: (json['composer'] as String? ?? '').trim(),
      label: (json['label'] as String? ?? '').trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'albumArtist': albumArtist,
      'trackNumber': trackNumber,
      'discNumber': discNumber,
      'year': year,
      'genre': genre,
      'lyrics': lyrics,
      'coverUrl': coverUrl,
      'comment': comment,
      'composer': composer,
      'label': label,
    };
  }

  EditableSongMetadata copyWith({
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    int? trackNumber,
    int? discNumber,
    int? year,
    String? genre,
    String? lyrics,
    String? coverUrl,
    String? comment,
    String? composer,
    String? label,
  }) {
    return EditableSongMetadata(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      lyrics: lyrics ?? this.lyrics,
      coverUrl: coverUrl ?? this.coverUrl,
      comment: comment ?? this.comment,
      composer: composer ?? this.composer,
      label: label ?? this.label,
    );
  }
}

class MetadataCandidate {
  final String source;
  final double confidence;
  final EditableSongMetadata metadata;

  const MetadataCandidate({
    required this.source,
    required this.confidence,
    required this.metadata,
  });

  factory MetadataCandidate.fromJson(Map<String, dynamic> json) {
    return MetadataCandidate(
      source: (json['source'] as String? ?? '').trim(),
      confidence: _toDouble(json['confidence']),
      metadata: EditableSongMetadata.fromJson(
        (json['metadata'] as Map?)?.cast<String, dynamic>(),
      ),
    );
  }
}

class MetadataCandidatesResponse {
  final EditableSongMetadata current;
  final List<MetadataCandidate> candidates;

  const MetadataCandidatesResponse({
    required this.current,
    required this.candidates,
  });

  factory MetadataCandidatesResponse.fromJson(Map<String, dynamic> json) {
    final candidates = json['candidates'] as List<dynamic>? ?? const [];
    return MetadataCandidatesResponse(
      current: EditableSongMetadata.fromJson(
        (json['current'] as Map?)?.cast<String, dynamic>(),
      ),
      candidates: candidates
          .map(
            (item) => MetadataCandidate.fromJson(
              item is Map<String, dynamic>
                  ? item
                  : (item as Map).cast<String, dynamic>(),
            ),
          )
          .toList(),
    );
  }
}

class MetadataCandidatesJobStatus {
  final String jobId;
  final String status;
  final String? message;
  final String? error;
  final MetadataCandidatesResponse? result;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MetadataCandidatesJobStatus({
    required this.jobId,
    required this.status,
    this.message,
    this.error,
    this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MetadataCandidatesJobStatus.fromJson(Map<String, dynamic> json) {
    return MetadataCandidatesJobStatus(
      jobId: json['job_id'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      message: json['message'] as String?,
      error: json['error'] as String?,
      result: json['result'] is Map
          ? MetadataCandidatesResponse.fromJson(
              (json['result'] as Map).cast<String, dynamic>(),
            )
          : null,
      createdAt: EmbedJobStatus._parseDateTime(json['created_at']),
      updatedAt: EmbedJobStatus._parseDateTime(json['updated_at']),
    );
  }

  bool get isActive =>
      status == 'queued' ||
      status == 'matching_fingerprint' ||
      status == 'searching_song' ||
      status == 'merging_data';

  bool get isDone => status == 'done';
  bool get isFailed => status == 'failed';

  String get statusDisplayName => switch (status) {
    'queued' => '等待中',
    'matching_fingerprint' => '正在匹配音频指纹',
    'searching_song' => '正在搜索歌曲',
    'merging_data' => '正在整合数据',
    'done' => '已完成',
    'failed' => '失败',
    _ => status,
  };
}

class MetadataApplyJobStatus {
  final String jobId;
  final String status;
  final String? message;
  final String? error;
  final String? filePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MetadataApplyJobStatus({
    required this.jobId,
    required this.status,
    this.message,
    this.error,
    this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MetadataApplyJobStatus.fromJson(Map<String, dynamic> json) {
    return MetadataApplyJobStatus(
      jobId: json['job_id'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      message: json['message'] as String?,
      error: json['error'] as String?,
      filePath: json['file_path'] as String?,
      createdAt: EmbedJobStatus._parseDateTime(json['created_at']),
      updatedAt: EmbedJobStatus._parseDateTime(json['updated_at']),
    );
  }

  bool get isActive =>
      status == 'queued' ||
      status == 'reading' ||
      status == 'resolving_cover' ||
      status == 'resolving_lyrics' ||
      status == 'tagging' ||
      status == 'scanning';

  bool get isDone => status == 'done';
  bool get isFailed => status == 'failed';

  String get statusDisplayName => switch (status) {
    'queued' => '等待中',
    'reading' => '读取文件',
    'resolving_cover' => '处理封面',
    'resolving_lyrics' => '处理歌词',
    'tagging' => '写入标签',
    'scanning' => '刷新音乐库',
    'done' => '已完成',
    'failed' => '失败',
    _ => status,
  };
}

/// Embed Service API 客户端
class EmbedServiceClient {
  static const Duration _defaultReceiveTimeout = Duration(seconds: 15);
  static const Duration _metadataCandidatesReceiveTimeout = Duration(
    seconds: 45,
  );
  static const Duration _metadataApplyReceiveTimeout = Duration(seconds: 30);

  final Dio _dio;

  EmbedServiceClient([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: _defaultReceiveTimeout,
              responseType: ResponseType.json,
              headers: {'Content-Type': 'application/json'},
            ),
          );

  /// 测试连接
  Future<void> testConnection(EmbedServiceConfig config) async {
    if (!config.isConfigured) {
      throw Exception('请先配置 Embed Service 地址和 API Key');
    }

    try {
      final response = await _dio.get(
        '${config.baseUrl}/v1/jobs',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('连接失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/jobs'));
    }
  }

  /// 获取所有任务列表
  Future<List<EmbedJobStatus>> listJobs({
    required EmbedServiceConfig config,
    String? status,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;

      final response = await _dio.get(
        '${config.baseUrl}/v1/jobs',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('获取任务列表失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      final jobs = data?['jobs'] as List<dynamic>? ?? [];
      return jobs
          .map(
            (j) => EmbedJobStatus.fromJson(
              j is Map<String, dynamic>
                  ? j
                  : (j as Map).cast<String, dynamic>(),
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/jobs'));
    }
  }

  /// 提交下载任务
  Future<String> submitJob({
    required EmbedServiceConfig config,
    required String source,
    required String trackId,
    required String libraryId,
    String quality = 'best',
    bool force = false,
    String? title,
    String? artist,
    String? album,
    int? trackNumber,
    int? year,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    final idempotencyKey = '$source:$trackId:$libraryId';

    final requestBody = {
      'source': source,
      'track_id': trackId,
      'library_id': libraryId,
      'quality': quality,
      'idempotency_key': idempotencyKey,
      if (force) 'force': true,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (trackNumber != null) 'track_number': trackNumber,
      if (year != null) 'year': year,
    };

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/jobs',
        data: requestBody,
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('提交任务失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      final jobId = data?['job_id'] as String?;
      if (jobId == null || jobId.isEmpty) {
        throw Exception('服务返回的 job_id 为空');
      }

      if (!force && data?['message'] == 'job already exists') {
        throw Exception('已在离线队列中');
      }

      return jobId;
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/jobs'));
    }
  }

  /// 查询任务状态
  Future<EmbedJobStatus> getJobStatus({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.get(
        '${config.baseUrl}/v1/jobs/$jobId',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode == 404) {
        throw Exception('任务不存在');
      }

      if (response.statusCode != 200) {
        throw Exception('查询任务失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      if (data == null) {
        throw Exception('响应数据格式错误');
      }

      return EmbedJobStatus.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/jobs/$jobId'));
    }
  }

  /// 重试失败的任务
  Future<void> retryJob({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/jobs/$jobId/retry',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('重试任务失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/jobs/$jobId/retry'),
      );
    }
  }

  /// 取消任务
  Future<void> cancelJob({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/jobs/$jobId/cancel',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('取消任务失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/jobs/$jobId/cancel'),
      );
    }
  }

  /// 删除单个任务
  Future<void> deleteJob({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.delete(
        '${config.baseUrl}/v1/jobs/$jobId',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('删除任务失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/jobs/$jobId'));
    }
  }

  /// 批量删除任务
  Future<void> batchDeleteJobs({
    required EmbedServiceConfig config,
    required List<String> jobIds,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/jobs/batch-delete',
        data: {'ids': jobIds},
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('批量删除任务失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/jobs/batch-delete'),
      );
    }
  }

  Future<MetadataCandidatesResponse> getMetadataCandidates({
    required EmbedServiceConfig config,
    required Song song,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/metadata/candidates',
        data: {
          'song': {
            'id': song.id,
            'path': song.path,
            'title': song.title,
            'artist': song.artist,
            'album': song.album,
            'albumArtist': song.artist,
            'trackNumber': song.track,
            'discNumber': song.discNumber,
            'year': song.year,
            'genre': song.genre,
            'suffix': song.suffix,
            'libraryId': config.libraryId,
          },
        },
        options: Options(
          headers: {'X-API-Key': config.apiKey},
          receiveTimeout: _metadataCandidatesReceiveTimeout,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('获取候选元数据失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      if (data == null) {
        throw Exception('响应数据格式错误');
      }
      return MetadataCandidatesResponse.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/metadata/candidates'),
      );
    }
  }

  Future<String> createMetadataCandidatesJob({
    required EmbedServiceConfig config,
    required Song song,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/metadata/candidates/jobs',
        data: {
          'song': {
            'id': song.id,
            'path': song.path,
            'title': song.title,
            'artist': song.artist,
            'album': song.album,
            'albumArtist': song.artist,
            'trackNumber': song.track,
            'discNumber': song.discNumber,
            'year': song.year,
            'genre': song.genre,
            'suffix': song.suffix,
            'libraryId': config.libraryId,
          },
        },
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode != 200) {
        throw Exception('创建候选元数据任务失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      final jobId = data?['job_id'] as String?;
      if (jobId == null || jobId.isEmpty) {
        throw Exception('服务返回的 job_id 为空');
      }
      return jobId;
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/metadata/candidates/jobs'),
      );
    }
  }

  Future<MetadataCandidatesJobStatus> getMetadataCandidatesJobStatus({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.get(
        '${config.baseUrl}/v1/metadata/candidates/jobs/$jobId',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode == 404) {
        throw Exception('任务不存在');
      }
      if (response.statusCode != 200) {
        throw Exception('查询候选元数据任务失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      if (data == null) {
        throw Exception('响应数据格式错误');
      }
      return MetadataCandidatesJobStatus.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(
          e,
          config.baseUrl,
          '/v1/metadata/candidates/jobs/$jobId',
        ),
      );
    }
  }

  Future<String> applyMetadata({
    required EmbedServiceConfig config,
    required Song song,
    required EditableSongMetadata metadata,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.post(
        '${config.baseUrl}/v1/metadata/apply',
        data: {
          'song': {
            'id': song.id,
            'path': song.path,
            'libraryId': config.libraryId,
          },
          'metadata': metadata.toJson(),
        },
        options: Options(
          headers: {'X-API-Key': config.apiKey},
          receiveTimeout: _metadataApplyReceiveTimeout,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('提交元数据修改失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      final jobId = data?['job_id'] as String?;
      if (jobId == null || jobId.isEmpty) {
        throw Exception('服务返回的 job_id 为空');
      }
      return jobId;
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, config.baseUrl, '/v1/metadata/apply'));
    }
  }

  Future<MetadataApplyJobStatus> getMetadataJobStatus({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (!config.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    try {
      final response = await _dio.get(
        '${config.baseUrl}/v1/metadata/jobs/$jobId',
        options: Options(headers: {'X-API-Key': config.apiKey}),
      );

      if (response.statusCode == 404) {
        throw Exception('任务不存在');
      }
      if (response.statusCode != 200) {
        throw Exception('查询元数据任务失败: HTTP ${response.statusCode}');
      }

      final data = _asMap(response.data);
      if (data == null) {
        throw Exception('响应数据格式错误');
      }
      return MetadataApplyJobStatus.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        _formatDioError(e, config.baseUrl, '/v1/metadata/jobs/$jobId'),
      );
    }
  }

  Map<String, dynamic>? _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return data.cast<String, dynamic>();
    if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    }
    return null;
  }

  String _formatDioError(DioException e, String baseUrl, String path) {
    final status = e.response?.statusCode;
    final responseData = _asMap(e.response?.data);
    final errorText = responseData?['error']?.toString();
    final target = '$baseUrl$path';

    if (status == 401) {
      final suffix = (errorText != null && errorText.isNotEmpty)
          ? '（$errorText）'
          : '';
      return 'Embed Service 鉴权失败 (401)$suffix，请检查 API Key；并确认 URL 指向 Embed Service 而非 Navidrome。请求地址: $target';
    }

    if (status == 404) {
      return 'Embed Service 接口不存在 (404)，请检查服务地址或版本。请求地址: $target';
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return '连接 Embed Service 失败，请检查地址与网络。请求地址: $target';
    }

    if (status != null) {
      return 'Embed Service 请求失败: HTTP $status。请求地址: $target';
    }

    return 'Embed Service 请求异常: ${e.message ?? e.toString()}。请求地址: $target';
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim()) ?? 0;
  return 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value.trim()) ?? 0;
  return 0;
}
