import 'dart:math';

import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum MediaFrom { gallery, camera }

class FastUtils {
  static Future<List<AssetEntity>> pickMedias(
      {required BuildContext context,
      required int maxImages,
      bool allowVideo = false,
      SpecialPickerType? specialPickerType,
      MediaFrom? from}) async {
    if (maxImages <= 0) return [];
    MediaFrom? source = from;
    if (source == null) {
      await FastUi.showIosDialog<MediaFrom>(context, textClick: [
            TextClick<MediaFrom>(
              text: FastCode().config.pickerMediaGallery,
              tap: () {
                source = MediaFrom.gallery;
              },
            ),
            TextClick<MediaFrom>(
              text: FastCode().config.pickerMediaCamera,
              tap: () {
                source = MediaFrom.camera;
              },
            ),
          ]) ??
          source;
    }

    if (source == null || !context.mounted) return [];

    List<AssetEntity> images = [];

    if (source == MediaFrom.camera) {
      final AssetEntity? entity = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(enableRecording: allowVideo),
      );
      if (entity != null) images.add(entity);
    } else if (source == MediaFrom.gallery) {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
            specialPickerType: specialPickerType,
            requestType: allowVideo ? RequestType.common : RequestType.image,
            maxAssets: maxImages),
      );
      images.addAll(result ?? []);
    }

    return images;
  }
}

fastPrint(dynamic dy) {
  if (kDebugMode) {
    try {
      print('Fast code: ${dy.toString()}');
    } catch (e) {
      print('Fast code: $e');
    }
  }
}

fastToast(dynamic dy) async {
  await EasyLoading.showToast(dy.toString());
}

extension FastIntExt on int {
  String get km {
    var number = this;
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  DateTime? get toDateTimeFromMillis =>
      DateTime.fromMillisecondsSinceEpoch(this);

  /// 格式化文件大小（自动转换为 B / KB / MB / GB / TB）
  String formatBytes({int decimals = 2}) {
    if (this <= 0) return "0 B";
    const units = ["B", "KB", "MB", "GB", "TB"];
    int unitIndex = (log(this) / log(1024)).floor();
    double size = this / pow(1024, unitIndex);
    return "${size.toStringAsFixed(decimals)} ${units[unitIndex]}";
  }

  String formatMill() {
    final seconds = (this / 1000).round();
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

extension FastStringExt on String {
  /// 获取路径最后的文件名，例如 "/storage/avatar.png" -> "avatar.png"
  String get pathFileName {
    if (isEmpty) return '';
    // 支持 / 和 \ 两种分隔符
    final index = lastIndexOf(RegExp(r'[\\/]+'));
    if (index == -1) return this; // 没有分隔符，直接返回自身
    return substring(index + 1);
  }
}

extension FastDateTimeExt on DateTime {
  String get ymd {
    return toIso8601String();
  }

  /// 转换为 yyyy-MM-dd HH:mm:ss 格式字符串
  String get ymdhms {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${year.toString().padLeft(4, '0')}-'
        '${twoDigits(month)}-'
        '${twoDigits(day)} '
        '${twoDigits(hour)}:'
        '${twoDigits(minute)}:'
        '${twoDigits(second)}';
  }
}
