
import 'fast_code_platform_interface.dart';

class FastCode {
  Future<String?> getPlatformVersion() {
    return FastCodePlatform.instance.getPlatformVersion();
  }
}
