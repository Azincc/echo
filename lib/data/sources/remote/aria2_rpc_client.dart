import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/aria2_config.dart';

class Aria2TaskStatus {
  final String gid;
  final String status;
  final int totalLength;
  final int completedLength;
  final int downloadSpeed;
  final String? errorMessage;

  const Aria2TaskStatus({
    required this.gid,
    required this.status,
    this.totalLength = 0,
    this.completedLength = 0,
    this.downloadSpeed = 0,
    this.errorMessage,
  });
}

class Aria2RpcClient {
  final Dio _dio;

  Aria2RpcClient([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 8),
              receiveTimeout: const Duration(seconds: 10),
              responseType: ResponseType.json,
            ),
          );

  Future<void> testConnection(Aria2Config config) async {
    await _call(config: config, method: 'aria2.getVersion', params: const []);
  }

  Future<String> addUri({
    required Aria2Config config,
    required String url,
    required String dir,
    String? out,
    Map<String, String> headers = const {},
  }) async {
    final options = <String, dynamic>{
      'dir': dir,
      if (out != null && out.trim().isNotEmpty) 'out': out,
      if (headers.isNotEmpty)
        'header': headers.entries.map((e) => '${e.key}: ${e.value}').toList(),
    };

    final result = await _call(
      config: config,
      method: 'aria2.addUri',
      params: [
        [url],
        options,
      ],
    );

    final gid = (result ?? '').toString();
    if (gid.isEmpty) {
      throw Exception('aria2 返回了空 GID');
    }
    return gid;
  }

  Future<Aria2TaskStatus> tellStatus({
    required Aria2Config config,
    required String gid,
  }) async {
    final result = await _call(
      config: config,
      method: 'aria2.tellStatus',
      params: [
        gid,
        [
          'gid',
          'status',
          'totalLength',
          'completedLength',
          'downloadSpeed',
          'errorMessage',
        ],
      ],
    );

    if (result is! Map) {
      return Aria2TaskStatus(gid: gid, status: 'error', errorMessage: '状态解析失败');
    }

    final map = result.cast<String, dynamic>();
    return Aria2TaskStatus(
      gid: (map['gid'] ?? gid).toString(),
      status: (map['status'] ?? 'unknown').toString(),
      totalLength: _toInt(map['totalLength']),
      completedLength: _toInt(map['completedLength']),
      downloadSpeed: _toInt(map['downloadSpeed']),
      errorMessage: (map['errorMessage'] ?? '').toString().trim().isEmpty
          ? null
          : (map['errorMessage'] ?? '').toString(),
    );
  }

  Future<dynamic> _call({
    required Aria2Config config,
    required String method,
    required List<dynamic> params,
  }) async {
    final rpcUrl = config.rpcUrl.trim();
    if (rpcUrl.isEmpty) {
      throw Exception('未配置 Aria2 RPC 地址');
    }

    final callParams = [...params];
    // 兼容 aria2 secret token 场景：未配置用户名时，把 password 当 token。
    if (config.username.trim().isEmpty && config.password.trim().isNotEmpty) {
      callParams.insert(0, 'token:${config.password.trim()}');
    }

    final request = {
      'jsonrpc': '2.0',
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'method': method,
      'params': callParams,
    };

    final headers = <String, String>{'Content-Type': 'application/json'};
    if (config.username.trim().isNotEmpty) {
      final raw = '${config.username.trim()}:${config.password.trim()}';
      headers['Authorization'] = 'Basic ${base64Encode(utf8.encode(raw))}';
    }

    final response = await _dio.post(
      rpcUrl,
      data: request,
      options: Options(headers: headers),
    );

    final data = response.data;
    final map = _toMap(data);
    if (map == null) {
      throw Exception('aria2 RPC 返回格式异常');
    }

    if (map['error'] != null) {
      final err = map['error'];
      if (err is Map) {
        final errMap = err.cast<String, dynamic>();
        final message = (errMap['message'] ?? '未知错误').toString();
        final code = (errMap['code'] ?? '').toString();
        throw Exception('aria2 RPC 错误[$code] $message');
      }
      throw Exception('aria2 RPC 错误: $err');
    }

    return map['result'];
  }

  Map<String, dynamic>? _toMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return data.cast<String, dynamic>();
    if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    }
    return null;
  }

  int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
