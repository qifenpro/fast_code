import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_code/fast_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Automatically set the width and height by setting the image width, height and ratio separately

class FastImageWidget extends StatelessWidget {
  const FastImageWidget(
      {super.key,
      this.imageUrl,
      this.height,
      this.fit,
      this.width,
      this.ratio,
      this.placeholder,
      this.stackBuilder,
      this.borderRadius,
      this.errorWidget,
      this.cacheRatio,
      this.color,
      this.cacheKey,
      this.border});
  final String? imageUrl;
  final double? height, width, ratio;
  final double? cacheRatio;
  final BorderRadius? borderRadius;
  final Border? border;
  final BoxFit? fit;
  final Color? color;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final Widget Function(double width, double height)? stackBuilder;
  final String? cacheKey;

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

    var imageWidget = Container(
      decoration: BoxDecoration(border: border, borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: SizedBox(
          height: realHeight,
          width: realWidth,
          child: (imageUrl?.startsWith('assets') ?? false)
              ? Image.asset(
                  imageUrl ?? '',
                  height: realHeight,
                  width: realWidth,
                  fit: fit ?? BoxFit.contain,
                  color: color,
                )
              : CachedNetworkImage(
                  height: realHeight,
                  width: realWidth, cacheKey: cacheKey,
                  placeholder: placeholder,
                  errorWidget: errorWidget, color: color,
                  maxHeightDiskCache: cacheRatio == null
                      ? null
                      : (MediaQuery.of(context).size.height * cacheRatio!)
                          .toInt(),
                  maxWidthDiskCache: cacheRatio == null
                      ? null
                      : (MediaQuery.of(context).size.width * cacheRatio!)
                          .toInt(),
                  memCacheHeight: cacheRatio == null
                      ? null
                      : (MediaQuery.of(context).size.height * cacheRatio!)
                          .toInt(),
                  // memCacheWidth: AppUi.width.toInt(),
                  imageUrl: imageUrl ?? '',
                  fit: fit ?? BoxFit.contain,
                ),
        ),
      ),
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
