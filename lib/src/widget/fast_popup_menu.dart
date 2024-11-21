
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastPopupMenu1<T> extends StatefulWidget {
  const FastPopupMenu1({
    super.key,
    this.onOpened,
    required this.menuItems,
    this.initialValue,
    this.borderRadius,
    this.box,
    required this.onSelected,
    this.radius,
    this.color,
    this.padding,
    this.onCanceled,
    this.offset,
    this.child,
    this.openColor,
  });

  final List<PopupMenuEntry<T>> menuItems;

  final T? initialValue;

  final void Function(T) onSelected;
  final Widget? child;
  final Offset? offset;
  final double? radius;
  final BorderRadius? borderRadius;

  final BoxConstraints? box;

  final EdgeInsets? padding;
  final Color? color;
  final void Function()? onOpened;
  final void Function()? onCanceled;
  final Color? openColor;

  @override
  State<FastPopupMenu1<T>> createState() => _FastPopupMenu1State<T>();
}

class _FastPopupMenu1State<T> extends State<FastPopupMenu1<T>> {
  Color? openColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      constraints: widget.box,
      padding: widget.padding ?? const EdgeInsets.all(8),
      color: widget.color,
      icon: StatefulBuilder(builder: (context, s) {
        return Container(
          color: openColor,
          child: widget.child,
        );
      }),
      onSelected: (T value) {
        // 菜单关闭后恢复颜色
        setState(() {
          openColor = null;
        });
        widget.onSelected.call(value);
      },
      onCanceled: () {
        // 如果用户取消选择也恢复颜色
        setState(() {
          openColor = null;
        });
        widget.onCanceled?.call();
      },
      onOpened: () {
        // 弹出时改变颜色
        setState(() {
          openColor = widget.openColor;
        });
        widget.onOpened?.call();
      },
      initialValue: widget.initialValue,
      offset: widget.offset ?? const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius:
            widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 16),
      ),
      itemBuilder: (context) => widget.menuItems,
    );
  }
}
