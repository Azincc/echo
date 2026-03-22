import 'package:fluttertoast/fluttertoast.dart';

import 'logger.dart';

class ToastNotifier {
  static const _tag = 'TOAST';

  static void show(String message) {
    try {
      Fluttertoast.showToast(msg: message).catchError((error, stackTrace) {
        Logger.warnWithTag(_tag, 'toast unavailable msg="$message"', error);
        return false;
      });
    } catch (e) {
      Logger.warnWithTag(_tag, 'toast unavailable msg="$message"', e);
    }
  }
}
