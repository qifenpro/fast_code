import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin FastStatusMixin<T extends StatefulWidget> on State<T> {
  var loading = false;

  var error = false;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<dynamic> loadData();

  Future<void> refresh() async {
    error = false;
    try {
      loading = true;
      final list = await loadData();
      loading = false;
      _onData(list);
    } catch (e) {
      fastPrint(e);
      loading = false;
      onError(e);
    }
  }

  bool get empty;

  void onError(e) {
    if (!mounted) return;
    setState(() {
      this.error = true;
    });
  }

  void _onData(dynamic list) {
    if (!mounted) return;
    setState(() {});
  }

  Widget errorWidget() => FastCode().config.errorWidget;

  Widget emptyWidget() => FastCode().config.emptyWidget;

  Widget loadingWidget() => FastCode().config.loadingWidget;

  bool get isNormal => !error && !empty && !loading;

  Widget get otherWidget {
    if (error) {
      return errorWidget();
    } else if (loading && empty) {
      return loadingWidget();
    } else if (empty) {
      return emptyWidget();
    } else {
      return loadingWidget();
    }
  }
}
