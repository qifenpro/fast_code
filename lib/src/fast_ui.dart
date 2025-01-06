import 'dart:async';

import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FastUi {
  static FutureOr<T?> loadingTask<T>({
    Function(dynamic)? error,
    bool loading = true,
    FutureOr Function()? task,
  }) async {
    T? result;
    try {
      if (loading) {
        EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: FastCode().config.loadingTaskWidget,
        );
      }
      result = await task?.call();
    } catch (e) {
      fastPrint('$e');
      error?.call(e);
    } finally {
      if (loading) EasyLoading.dismiss();
    }
    return result;
  }

  static Future<T?> showIosDialog<T>(context,
      {showCancel = true, List<TextClick<T?>>? textClick}) {
    List<CupertinoActionSheetAction> list = [];

    textClick?.forEach((element) {
      list.add(CupertinoActionSheetAction(
          isDestructiveAction: element.red,
          onPressed: () async {
            if (element.tap != null) {
              T? result = await element.tap!();
              if (context.mounted) Navigator.pop(context, result);
            } else {
              Navigator.pop(context, element.returnValue);
            }
          },
          child: Text(element.text ?? '')));
    });

    return showCupertinoModalPopup<T>(
        context: context,
        builder: (c) {
          return CupertinoActionSheet(
            actions: list,
            cancelButton: showCancel
                ? CupertinoActionSheetAction(
                    //取消按钮
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(FastCode().config.iosDialogCancelText),
                  )
                : null,
          );
        });
  }
}

class TextClick<T> {
  FutureOr<T>? Function()? tap;
  String? text;
  bool red = false;
  T? returnValue;

  TextClick({this.tap, this.text, this.red = false, this.returnValue});
}
