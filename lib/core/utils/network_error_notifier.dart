import 'package:fluttertoast/fluttertoast.dart';

/// 网络异常提示（带节流，避免同一时刻重复弹出）
class NetworkErrorNotifier {
  static DateTime? _lastShownAt;

  static void show([String message = '网络异常']) {
    final now = DateTime.now();
    final last = _lastShownAt;
    if (last != null && now.difference(last) < const Duration(seconds: 2)) {
      return;
    }
    _lastShownAt = now;
    Fluttertoast.showToast(msg: message);
  }
}
