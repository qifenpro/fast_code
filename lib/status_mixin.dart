import 'package:fast_code/fast_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin StatusMixin<T extends StatefulWidget> on State<T> {
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
      print(e);
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

  Widget errorWidget() => FastConfig().errorWidget;

  Widget emptyWidget() => FastConfig().emptyWidget;

  Widget loadingWidget() => FastConfig().loadingWidget;

  bool get isNormal => !error && !empty && !loading;

  Widget get abnormalWidget {
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
