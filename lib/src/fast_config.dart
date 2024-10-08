import 'package:flutter/cupertino.dart';

///全局配置
class FastConfig {
  FastConfig({
    this.emptyWidget = const Center(
      child: Text('No data'),
    ),
    this.errorWidget = const Center(
      child: Text('Error'),
    ),
    this.loadingWidget = const Center(
      child: CupertinoActivityIndicator(),
    ),
    this.iosDialogCancelText = 'Cancel',
    this.pickerMediaCamera = 'Camera',
    this.pickerMediaGallery = 'Gallery',
  });

  Widget errorWidget;

  Widget emptyWidget;

  Widget loadingWidget;

  String iosDialogCancelText, pickerMediaGallery, pickerMediaCamera;
}
