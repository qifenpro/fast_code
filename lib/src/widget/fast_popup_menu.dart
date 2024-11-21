import 'package:flutter/material.dart';

// class FastPopupMenu<T> extends StatelessWidget {
//   final List<PopupMenuEntry<T>> menuItems;

//   final T? initialValue;

//   final void Function(T) onSelected;
//   final Widget? child;
//   final Offset? offset;
//   final double? radius;
//   final BorderRadius? borderRadius;

//   final BoxConstraints? box;

//   final EdgeInsets? padding;
//   final Color? color;
//   final void Function()? onOpened;

//   const FastPopupMenu({
//     super.key,
//     this.onOpened,
//     required this.menuItems,
//     this.initialValue,
//     this.borderRadius,
//     this.box,
//     required this.onSelected,
//     this.radius,
//     this.color,
//     this.padding,
//     this.offset,
//     this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<T>(
//       constraints: box,
//       padding: padding ?? const EdgeInsets.all(8),
//       color: color,
//       onOpened: (){

//         onOpened?.call();
//       },
//       icon: Container(
//         child: child,
//       ),
//       initialValue: initialValue,
//       offset: offset ?? Offset.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16),
//       ),
//       itemBuilder: (context) => menuItems,
//       onSelected: onSelected,
//     );
//   }
// }

class FastPopupMenu<T> extends StatefulWidget {
  const FastPopupMenu({
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
  State<FastPopupMenu<T>> createState() => _FastPopupMenuState<T>();
}

class _FastPopupMenuState<T> extends State<FastPopupMenu<T>> {
  Color? openColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      constraints: widget.box,
      padding: widget.padding ?? const EdgeInsets.all(8),
      color: widget.color,
      icon: Container(
        color: openColor,
        child: widget.child,
      ),
      onSelected: (T value) {
        // 菜单关闭后恢复颜色
        if (openColor != null) {
          setState(() {
            openColor = null;
          });
        }
        widget.onSelected.call(value);
      },
      onCanceled: () {
        // 如果用户取消选择也恢复颜色
        if (openColor != null) {
          setState(() {
            openColor = null;
          });
        }
        widget.onCanceled?.call();
      },
      onOpened: () {
        // 弹出时改变颜色
        if (openColor != null) {
          setState(() {
            openColor = widget.openColor;
          });
        }
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
