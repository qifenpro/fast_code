import 'package:flutter/material.dart';

class FastPopupMenu<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> menuItems;

  final T? initialValue;

  final void Function(T) onSelected;
  final Widget? child;
  final Offset offset;
  final double? radius;
  final BorderRadius? borderRadius;

  final BoxConstraints? box;

  const FastPopupMenu({
    super.key,
    required this.menuItems,
    this.initialValue,
    this.borderRadius,
    this.box,
    required this.onSelected,
    this.radius,
    this.offset = const Offset(0, 50),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      constraints: box,
      icon: Container(
        child: child,
      ),
      initialValue: initialValue,
      offset: offset,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 16),
      ),
      itemBuilder: (context) => menuItems,
      onSelected: onSelected,
    );
  }
}
