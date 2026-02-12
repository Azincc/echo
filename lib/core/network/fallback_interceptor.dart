import 'package:dio/dio.dart';
import 'package:echo/core/network/address_pool.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FallbackInterceptor extends Interceptor {
  final AddressPool _addressPool;
  final Dio _dio; // The customized Dio instance (with this interceptor)

  int _consecutiveFailures = 0;

  FallbackInterceptor(this._addressPool, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final active = _addressPool.activeAddress;
    if (active != null) {
      options.baseUrl = active.url;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_isConnectionError(err)) {
      _consecutiveFailures++;
      if (_consecutiveFailures >= 2) {
        final currentAddress = _addressPool.activeAddress;
        if (currentAddress != null) {
          _addressPool.markFailed(currentAddress);

          final next = _addressPool.getNextAvailable();
          if (next != null) {
            // Try probing/switching to next
            final success = await _addressPool.switchTo(next);
            if (success) {
              _consecutiveFailures = 0;
              Fluttertoast.showToast(
                msg: "Switching to connection: ${next.label}",
              );

              // Retry with new address
              final opts = err.requestOptions;
              opts.baseUrl = next.url;

              try {
                final response = await _dio.fetch(opts);
                return handler.resolve(response);
              } catch (e) {
                // If retry fails, it might trigger onError again via the interceptor chain
                // So we just return here, letting the next error propagate if it wasn't resolved
                if (e is DioException) {
                  return handler.next(e);
                }
              }
            }
          }
        }
      }
    } else {
      _consecutiveFailures = 0;
    }

    super.onError(err, handler);
  }

  bool _isConnectionError(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.type == DioExceptionType.unknown &&
            err.message?.contains('SocketException') == true);
  }
}
