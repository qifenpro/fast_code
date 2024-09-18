import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum MediaFrom { gallery, camera }

class FastUtils {
  static Future<List<AssetEntity>> pickMedias(
      {required BuildContext context,
      required int maxImages,
      bool allowVideo = false,
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
              text: FastCode().config.pickerMediaGallery,
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
