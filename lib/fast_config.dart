import 'package:flutter/cupertino.dart';

///全局配置
class FastConfig {
  static Widget errorWidget = const Center(
    child: Text('Error'),
  );

  static Widget emptyWidget = const Center(
    child: Text('No data'),
  );

  static Widget loadingWidget = const Center(
    child: CupertinoActivityIndicator(),
  );
}

class FastCode {
  FastConfig config = FastConfig();

  init(FastConfig config) {
    this.config = config;
  }
}
