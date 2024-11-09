import 'dart:async';

import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin FastPageMixin<T, F extends StatefulWidget> on State<F> {
  final data = <T>[];
  var page = 0;
  var loading = false;

  bool noMore = false;

  var error = false;

  int initializePage = 0;

  ///默认自动检查是否还有数据
  bool autoNoMore = true;

  int pageCount = 20;

  @override
  void initState() {
    page = initializePage;
    refresh();
    super.initState();
  }

  Future<List<T>> loadData(int page);

  Future<bool> refresh() async {
    error = false;
    page = initializePage;
    noMore = false;
    try {
      loading = true;
      final list = await loadData(page);
      loading = false;
      _onData(list, initializePage);
      dataAdded(true);
    } catch (e) {
      loading = false;
      onError(e);
    }
    return noMore;
  }

  void dataAdded(bool refresh) {}

  void onError(e) {
    fastPrint('$e');
    if (!mounted) return;
    setState(() {
      error = true;
      noMore = true;
    });
    throw e;
  }

  Future<bool> loadMore() async {
    try {
      loading = true;
      page++;
      final reqPage = page;
      final list = await loadData(page);
      loading = false;
      _onData(list, reqPage);
      dataAdded(false);
    } catch (e) {
      loading = false;
      onError(e);
    }
    return noMore;
  }

  void _onData(List<T>? list, int reqPage) {
    if (page != reqPage) return;
    if (page == initializePage) {
      data.clear();
    }
    if (list != null && list.isNotEmpty) {
      data.addAll(list);
    } else {
      page = page > (initializePage + 1) ? page - 1 : (initializePage + 1);
    }
    if (autoNoMore) {
      noMore = list == null || list.isEmpty || list.length < pageCount;
    }
    if (!mounted) return;
    setState(() {});
  }

  Widget errorWidget() => FastCode().config.errorWidget;

  Widget emptyWidget() => FastCode().config.emptyWidget;

  Widget loadingWidget() => FastCode().config.loadingWidget;

  bool get isNormal => !error && !loading && data.isNotEmpty;

  bool get isEmpty => data.isEmpty;

  Widget get otherWidget {
    if (error) {
      return errorWidget();
    } else if (loading && data.isEmpty) {
      return loadingWidget();
    } else if (isEmpty) {
      return emptyWidget();
    } else {
      return const SizedBox();
    }
  }
}
