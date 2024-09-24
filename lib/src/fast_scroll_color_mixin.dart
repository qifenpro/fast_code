import 'package:flutter/material.dart';

mixin FastScrollColorMixin<T extends StatefulWidget> on State<T> {
  ValueNotifier<Color> appBarColor = ValueNotifier(Colors.transparent);
  ScrollController? scroll;

  double scrollThreshold = 200; // 下滑高度

  @override
  void initState() {
    super.initState();
    scroll?.addListener(_onScroll);
  }

  Color gradColor = Colors.white;

  void _onScroll() {
    if (scroll == null) return;

    double offset = scroll!.offset;
    if (offset <= 0) {
      appBarColor.value = Colors.transparent;
    } else if (offset >= scrollThreshold) {
      appBarColor.value = gradColor;
    } else {
      double opacity = (offset / scrollThreshold).clamp(0.0, 1.0);
      appBarColor.value = gradColor.withOpacity(opacity);
    }
  }

  @override
  void dispose() {
    scroll?.removeListener(_onScroll);
    appBarColor.dispose();
    super.dispose();
  }
}
