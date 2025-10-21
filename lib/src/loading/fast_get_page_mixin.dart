import 'dart:async';

import 'package:fast_code/fast_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//分页加载数据
mixin FastGetPageMixin<T> on GetxController {
  final pageListData = <T>[];
  //页面当前加载的哪个分页
  var pageCurrentPage = 1;

  //页面是否在加载
  var pageLoading = false;

  //页面没有更多数据了
  bool pageNoMore = false;

  //页面是否异常
  var pageError = false;

  //默认开始的第几页
  int pageInitPage = 1;

  ///默认自动检查是否还有数据
  bool pageAutoNoMore = true;

  //默认一次20页
  int pageCount = 20;

  @override
  void onInit() {
    pageCurrentPage = pageInitPage;
    pageRefresh();
    super.onInit();
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
    pageError = true;
    pageNoMore = true;
    update();
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
    update();
  }

  Widget pageErrorWidget() => FastCode().config.errorWidget;

  Widget pageEmptyWidget() => FastCode().config.emptyWidget;

  Widget pageLoadingWidget() => FastCode().config.loadingWidget;

  //当前页面是否正常
  bool get pageIsNormal =>
      !pageError && !pageLoading && pageListData.isNotEmpty;

  //当前分页数据是否为空
  bool get pageIsEmpty => pageListData.isEmpty;

  // 当前状态： 异常、空数据、加载中
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
