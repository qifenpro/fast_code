import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    this.loadingTaskWidget,
    this.classicFooter,
    this.classicHeader,
    this.iosDialogCancelText = 'Cancel',
    this.pickerMediaCamera = 'Camera',
    this.pickerMediaGallery = 'Gallery',
  });

  Widget errorWidget;

  Widget emptyWidget;

  Widget loadingWidget;

  Widget? loadingTaskWidget;

  ClassicFooter? classicFooter;

  ClassicHeader? classicHeader;

  String iosDialogCancelText, pickerMediaGallery, pickerMediaCamera;
}
