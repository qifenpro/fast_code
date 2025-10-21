import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_code/fast_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastImageWidget extends StatefulWidget {
  const FastImageWidget({
    super.key,
    this.imageUrl,
    this.height,
    this.fit,
    this.width,
    this.ratio,
    this.placeholder,
    this.stackBuilder,
    this.borderRadius,
    this.errorWidget,
    this.cacheRatio = 1.5, //默认图片加载缓存比例
    this.color,
    this.cacheKey,
    this.border,
    this.maxCacheWidth,
    this.autoClearCache = true, // Add auto clear cache option
    this.alignment,
  });

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
  final double? maxCacheWidth;
  final bool autoClearCache; // New parameter to control auto clear behavior
  final Alignment? alignment;

  @override
  State<FastImageWidget> createState() => _FastImageWidgetState();
}

class _FastImageWidgetState extends State<FastImageWidget> {
  String? _currentCacheKey;
  bool _hasClearedCache = false;

  @override
  void initState() {
    super.initState();
    _currentCacheKey = widget.cacheKey;
  }

  @override
  Widget build(BuildContext context) {
    double? realHeight = widget.height;
    double? realWidth = widget.width;

    try {
      if (widget.ratio != null && widget.height != null) {
        realWidth = widget.height! / widget.ratio!;
      }

      if (widget.ratio != null && widget.width != null) {
        realHeight = widget.width! / widget.ratio!;
      }
    } catch (e) {
      fastPrint('$e');
    }

    var imageWidget = Container(
      decoration: BoxDecoration(
        border: widget.border,
        borderRadius: widget.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: SizedBox(
          height: realHeight,
          width: realWidth,
          child: (widget.imageUrl?.startsWith('assets') ?? false)
              ? Image.asset(
                  widget.imageUrl ?? '',
                  height: realHeight,
                  width: realWidth,
                  fit: widget.fit ?? BoxFit.contain,
                  color: widget.color,
                  cacheWidth: widget.maxCacheWidth?.toInt() ??
                      (widget.cacheRatio == null
                          ? null
                          : (MediaQuery.of(context).size.width *
                                  widget.cacheRatio!)
                              .toInt()),
                )
              : CachedNetworkImage(
                  key: _currentCacheKey == null
                      ? null
                      : ValueKey(_currentCacheKey),
                  height: realHeight,
                  width: realWidth,
                  cacheKey: _currentCacheKey,
                  placeholder: widget.placeholder,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  errorListener: (value) {
                    _clearCacheAndRetry();
                  },
                  errorWidget: (context, url, error) {
                    // Auto clear cache on error if enabled
                    if (widget.autoClearCache &&
                        !_hasClearedCache &&
                        _currentCacheKey != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _clearCacheAndRetry();
                      });
                    }

                    // Use provided errorWidget or default
                    if (widget.errorWidget != null) {
                      return widget.errorWidget!(context, url, error);
                    }

                    return SizedBox();
                  },
                  color: widget.color,
                  maxWidthDiskCache: widget.maxCacheWidth?.toInt() ??
                      (widget.cacheRatio == null
                          ? null
                          : (MediaQuery.of(context).size.width *
                                  widget.cacheRatio!)
                              .toInt()),
                  memCacheWidth: widget.maxCacheWidth?.toInt() ??
                      (widget.cacheRatio == null
                          ? null
                          : (MediaQuery.of(context).size.width *
                                  widget.cacheRatio!)
                              .toInt()),
                  imageUrl: widget.imageUrl ?? '',
                  fit: widget.fit ?? BoxFit.contain,
                  alignment: widget.alignment ?? Alignment.center,
                ),
        ),
      ),
    );

    if (widget.stackBuilder != null) {
      return Stack(
        children: [
          imageWidget,
          Positioned.fill(
            child: widget.stackBuilder!.call(realWidth ?? 0, realHeight ?? 0),
          ),
        ],
      );
    } else {
      return imageWidget;
    }
  }

  @override
  void didUpdateWidget(covariant FastImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_currentCacheKey != widget.cacheKey) {
      setState(() {
        _currentCacheKey = widget.cacheKey;
      });
    }
  }

  void _clearCacheAndRetry() {
    if (_currentCacheKey != null) {
      setState(() {
        // Clear the cache and remove cacheKey to force fresh load
        CachedNetworkImage.evictFromCache(_currentCacheKey!);
        _currentCacheKey = null;
        _hasClearedCache = true;
      });
    }
  }
}
