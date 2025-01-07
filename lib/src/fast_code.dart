import 'package:fast_code/src/fast_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FastCode {
  static final FastCode _instance = FastCode._internal();

  FastCode._internal();

  factory FastCode() {
    return _instance;
  }

  FastConfig config = FastConfig();

  init(FastConfig config) {
    this.config = config;
    if (config.loadingTaskWidget != null) {
      EasyLoading.instance
        ..maskType = EasyLoadingMaskType.black
        // ..displayDuration = const Duration(milliseconds: 2000)
        // ..indicatorType = EasyLoadingIndicatorType.circle
        ..loadingStyle = EasyLoadingStyle.custom
        // ..maskType = EasyLoadingMaskType.black
        // ..indicatorSize = 45.0
        // ..radius = 10.0
        ..progressColor = Colors.transparent
        ..backgroundColor = Colors.transparent
        ..boxShadow = const [
          BoxShadow(color: Colors.transparent),
        ]
        // ..animationStyle = EasyLoadingAnimationStyle.opacity
        ..maskType = EasyLoadingMaskType.none
        ..indicatorColor = Colors.transparent
        ..textColor = Colors.transparent
        ..maskColor = Colors.transparent
        ..userInteractions = false
        ..dismissOnTap = false;
    }
  }
}
