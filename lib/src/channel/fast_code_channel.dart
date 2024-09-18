import 'fast_code_platform_interface.dart';

class FastCodeChannel {
  Future<String?> getPlatformVersion() {
    return FastCodePlatform.instance.getPlatformVersion();
  }
}
