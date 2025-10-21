import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef Callback = FutureOr Function();

//上拉刷新 下拉加载
class FastRefreshWidget extends StatefulWidget {
  const FastRefreshWidget({
    super.key,
    this.child,
    this.onLoad,
    this.onRefresh,
    // this.noMore = false,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.noMoreText,
    this.controller,
    this.classicFooter,
    this.classicHeader,
  });

  final Widget? child;
  // final bool noMore;
  final Callback? onRefresh;
  final FutureOr<bool> Function()? onLoad;
  final bool enablePullDown;
  final RefreshController? controller;
  final String? noMoreText;
  final ClassicFooter? classicFooter;
  final ClassicHeader? classicHeader;
  final bool enablePullUp;

  @override
  State<FastRefreshWidget> createState() => FastRefreshWidgetState();
}

class FastRefreshWidgetState extends State<FastRefreshWidget> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = widget.controller ?? RefreshController();
  }

  FutureOr refreshData() async {
    await _refresh();
  }

  FutureOr _refresh() async {
    refreshController.requestRefresh();
    try {
      var noMore = await widget.onRefresh?.call() ?? true;
      if (noMore) {
        refreshController.loadNoData();
      }
    } catch (e) {
      refreshController.refreshFailed();
    }
    refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      footer:
          widget.classicFooter ?? ClassicFooter(noDataText: widget.noMoreText),
      header: widget.classicHeader ?? const ClassicHeader(),
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: _refresh,
      onLoading: () async {
        refreshController.requestLoading();
        try {
          var noMore = await widget.onLoad?.call() ?? true;
          if (noMore) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        } catch (e) {
          refreshController.loadFailed();
        }
      },
      controller: refreshController,
      child: widget.child ?? const SizedBox(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}
