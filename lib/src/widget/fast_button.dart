import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastButton extends StatelessWidget {
  const FastButton({
    super.key,
    this.child,
    this.tap,
    this.text,
  });

  final Widget? child;
  final VoidCallback? tap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: tap, child: child ?? Text(text ?? ''));
  }
}
