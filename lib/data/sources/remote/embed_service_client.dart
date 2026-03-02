import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/embed_service_config.dart';

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

/// Embed Service API 客户端
class EmbedServiceClient {
  final Dio _dio;

  EmbedServiceClient([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
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
