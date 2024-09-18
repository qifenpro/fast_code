import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Automatically set the width and height by setting the image width, height and ratio separately

class FastRatioWidget extends StatelessWidget {
  const FastRatioWidget({
    super.key,
    this.child,
    this.height,
    this.width,
    this.ratio,
    this.stackBuilder,
    this.color,
  });
  final double? height, width, ratio;
  final Color? color;
  final Widget Function(double width, double height)? stackBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double? realHeight = height;
    double? realWidth = width;

    try {
      if (ratio != null && height != null) {
        realWidth = height! / ratio!;
      }

      if (ratio != null && width != null) {
        realHeight = width! / ratio!;
      }
    } catch (e) {
      fastPrint('$e');
    }

    var imageWidget = SizedBox(
      height: realHeight,
      width: realWidth,
      child: child,
      // child: (imageUrl?.startsWith('assets') ?? false)
      //     ? Image.asset(
      //         imageUrl ?? '',
      //         height: realHeight,
      //         width: realWidth,
      //         fit: fit ?? BoxFit.contain,
      //         color: color,
      //       )
      //     : CachedNetworkImage(
      //         height: realHeight,
      //         width: realWidth,
      //         placeholder: placeholder,
      //         errorWidget: errorWidget, color: color,
      //         maxHeightDiskCache: (MediaQuery.of(context).size.height * cacheRatio).toInt(),
      //         maxWidthDiskCache: (MediaQuery.of(context).size.width * cacheRatio).toInt(),
      //         memCacheHeight: (MediaQuery.of(context).size.height * cacheRatio).toInt(),
      //         // memCacheWidth: AppUi.width.toInt(),
      //         imageUrl: imageUrl ?? '',
      //         fit: fit ?? BoxFit.contain,
      //       ),
    );

    if (stackBuilder != null) {
      return Stack(
        children: [
          imageWidget,
          Positioned.fill(
              child: stackBuilder!.call(realWidth ?? 0, realHeight ?? 0)),
        ],
      );
    } else {
      return imageWidget;
    }
  }
}
