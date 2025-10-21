import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin FastStatusMixin<T extends StatefulWidget> on State<T> {
  var statusLoading = false;

  var pageError = false;

  @override
  void initState() {
    statusRefresh();
    super.initState();
  }

  Future<dynamic> statusLoadData();

  Future<void> statusRefresh() async {
    pageError = false;
    try {
      statusLoading = true;
      final list = await statusLoadData();
      statusLoading = false;
      _statusOnData(list);
    } catch (e) {
      fastPrint(e);
      statusLoading = false;
      statusOnError(e);
    }
  }

  bool get statusEmpty => false;

  void statusOnError(e) {
    if (!mounted) return;
    setState(() {
      this.pageError = true;
    });
  }

  void _statusOnData(dynamic list) {
    if (!mounted) return;
    setState(() {});
  }

  Widget statusErrorWidget() => FastCode().config.errorWidget;

  Widget statusEmptyWidget() => FastCode().config.emptyWidget;

  Widget statusLoadingWidget() => FastCode().config.loadingWidget;

  bool get statusIsNormal => !pageError && !statusEmpty && !statusLoading;

  Widget get statusOtherWidget {
    if (pageError) {
      return statusErrorWidget();
    } else if (statusLoading && statusEmpty) {
      return statusLoadingWidget();
    } else if (statusEmpty) {
      return statusEmptyWidget();
    } else {
      return statusLoadingWidget();
    }
  }
}
