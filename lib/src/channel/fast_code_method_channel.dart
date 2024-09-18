import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fast_code_platform_interface.dart';

/// An implementation of [FastCodePlatform] that uses method channels.
class MethodChannelFastCode extends FastCodePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fast_code');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
