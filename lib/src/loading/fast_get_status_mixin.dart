import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//页面单次加载
mixin FastGetStatusMixin on GetxController {
  //加载中
  var statusLoaing = false;

  //加载出错
  var statusError = false;

  //是否空数据
  bool get statusEmpty => false;

  @override
  void onInit() {
    statusRefresh();
    super.onInit();
  }

  //数据加载
  Future<dynamic> statusLoadData();

  //数据刷新
  Future<void> statusRefresh() async {
    statusError = false;
    try {
      statusLoaing = true;
      final list = await statusLoadData();
      statusLoaing = false;
      _statusOnData(list);
    } catch (e) {
      fastPrint(e);
      statusLoaing = false;
      statusOnError(e);
    }
  }

  void statusOnError(e) {
    this.statusError = true;
    update();
  }

  void _statusOnData(dynamic list) {
    update();
  }

  Widget statusErrorWidget() => FastCode().config.errorWidget;

  Widget statusEmptyWidget() => FastCode().config.emptyWidget;

  Widget statusLoadingWidget() => FastCode().config.loadingWidget;

  bool get statusIsNormal => !statusError && !statusEmpty && !statusLoaing;

  // 当前状态： 异常、空数据、加载中
  Widget get statusOtherWidget {
    if (statusError) {
      return statusErrorWidget();
    } else if (statusLoaing && statusEmpty) {
      return statusLoadingWidget();
    } else if (statusEmpty) {
      return statusEmptyWidget();
    } else {
      return statusLoadingWidget();
    }
  }
}
