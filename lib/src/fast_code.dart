import 'package:fast_code/src/fast_config.dart';

class FastCode {
  static final FastCode _instance = FastCode._internal();

  FastCode._internal();

  factory FastCode() {
    return _instance;
  }

  FastConfig config = FastConfig();

  init(FastConfig config) {
    this.config = config;
  }
}
