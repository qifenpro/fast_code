import 'package:fast_code/fast_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin PageMixin<T, F extends StatefulWidget> on State<F> {
  final data = <T>[];
  var page = 0;
  var loading = false;

  //未实现
  var noMore = false;

  var error = false;

  int initializePage = 0;

  int pageCount = 20;

  @override
  void initState() {
    page = initializePage;
    refresh();
    super.initState();
  }

  Future<List<T>> loadData(int page);

  Future<void> refresh() async {
    error = false;
    page = initializePage;
    try {
      loading = true;
      final list = await loadData(page);
      loading = false;
      _onData(list, initializePage);
    } catch (e) {
      print(e);
      loading = false;
      onError(e);
    }
  }

  void onError(e) {
    if (!mounted) return;
    setState(() {
      error = true;
      noMore = true;
    });
  }

  Future<void> loadMore() async {
    try {
      loading = true;
      page++;
      final reqPage = page;
      final list = await loadData(page);
      loading = false;
      _onData(list, reqPage);
    } catch (e) {
      loading = false;
      onError(e);
    }
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
    noMore = list == null || list.isEmpty || list.length < pageCount;
    if (!mounted) return;
    setState(() {});
  }

  Widget errorWidget() => FastConfig.errorWidget;

  Widget emptyWidget() => FastConfig.emptyWidget;

  Widget loadingWidget() => FastConfig.loadingWidget;

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
