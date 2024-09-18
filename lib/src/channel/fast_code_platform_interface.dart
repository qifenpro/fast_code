import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fast_code_method_channel.dart';

abstract class FastCodePlatform extends PlatformInterface {
  /// Constructs a FastCodePlatform.
  FastCodePlatform() : super(token: _token);

  static final Object _token = Object();

  static FastCodePlatform _instance = MethodChannelFastCode();

  /// The default instance of [FastCodePlatform] to use.
  ///
  /// Defaults to [MethodChannelFastCode].
  static FastCodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FastCodePlatform] when
  /// they register themselves.
  static set instance(FastCodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
