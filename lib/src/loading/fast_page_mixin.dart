import 'dart:async';

import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin FastPageMixin<T, F extends StatefulWidget> on State<F> {
  final pageListData = <T>[];
  var pageCurrentPage = 0;
  var pageLoading = false;

  bool pageNoMore = false;

  var pageError = false;

  int pageInitPage = 0;

  ///默认自动检查是否还有数据
  bool pageAutoNoMore = true;

  int pageCount = 20;

  @override
  void initState() {
    pageCurrentPage = pageInitPage;
    pageRefresh();
    super.initState();
  }

  Future<List<T>> pageLoadData(int page);

  Future<bool> pageRefresh() async {
    pageError = false;
    pageCurrentPage = pageInitPage;
    pageNoMore = false;
    try {
      pageLoading = true;
      final list = await pageLoadData(pageCurrentPage);
      pageLoading = false;
      _pageOnData(list, pageInitPage);
      pageDataAdded(true);
    } catch (e) {
      pageLoading = false;
      pageOnError(e);
    }
    return pageNoMore;
  }

  void pageDataAdded(bool refresh) {}

  void pageOnError(e) {
    fastPrint('$e');
    if (!mounted) return;
    setState(() {
      pageError = true;
      pageNoMore = true;
    });
    throw e;
  }

  Future<bool> pageLoadMore() async {
    try {
      pageLoading = true;
      pageCurrentPage++;
      final reqPage = pageCurrentPage;
      final list = await pageLoadData(pageCurrentPage);
      pageLoading = false;
      _pageOnData(list, reqPage);
      pageDataAdded(false);
    } catch (e) {
      pageLoading = false;
      pageOnError(e);
    }
    return pageNoMore;
  }

  void _pageOnData(List<T>? list, int reqPage) {
    if (pageCurrentPage != reqPage) return;
    if (pageCurrentPage == pageInitPage) {
      pageListData.clear();
    }
    if (list != null && list.isNotEmpty) {
      pageListData.addAll(list);
    } else {
      pageCurrentPage = pageCurrentPage > (pageInitPage + 1)
          ? pageCurrentPage - 1
          : (pageInitPage + 1);
    }
    if (pageAutoNoMore) {
      pageNoMore = list == null || list.isEmpty || list.length < pageCount;
    }
    if (!mounted) return;
    setState(() {});
  }

  Widget pageErrorWidget() => FastCode().config.errorWidget;

  Widget pageEmptyWidget() => FastCode().config.emptyWidget;

  Widget pageLoadingWidget() => FastCode().config.loadingWidget;

  bool get pageIsNormal =>
      !pageError && !pageLoading && pageListData.isNotEmpty;

  bool get pageIsEmpty => pageListData.isEmpty;

  Widget get pageOtherWidget {
    if (pageError) {
      return pageErrorWidget();
    } else if (pageLoading && pageListData.isEmpty) {
      return pageLoadingWidget();
    } else if (pageIsEmpty) {
      return pageEmptyWidget();
    } else {
      return const SizedBox();
    }
  }
}
