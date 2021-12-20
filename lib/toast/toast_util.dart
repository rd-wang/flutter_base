import 'package:flutter_easyloading/flutter_easyloading.dart';

enum ToastType { Success, Info, Error, Toast, Loading, Progress }

class ToastUtil {

  static showToast(String msg, {ToastType type}) {
    if (type == null) {
      return EasyLoading.showInfo(msg);
    }
    switch (type) {
      case ToastType.Success:
        EasyLoading.showSuccess(msg);
        break;
      case ToastType.Info:
        EasyLoading.showInfo(msg);
        break;
      case ToastType.Error:
        EasyLoading.showError(msg);
        break;
      case ToastType.Toast:
        EasyLoading.showToast(msg);
        break;
      case ToastType.Loading:
        EasyLoading.show(status: msg);
        break;
      case ToastType.Progress:
        EasyLoading.showProgress(0.3, status: msg);
        break;
    }
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}