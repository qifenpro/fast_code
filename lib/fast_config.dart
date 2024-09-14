import 'package:flutter/cupertino.dart';

///全局配置
class FastConfig {
  FastConfig(
      {this.emptyWidget = const Center(
        child: Text('No data'),
      ),
      this.errorWidget = const Center(
        child: Text('Error'),
      ),
      this.loadingWidget = const Center(
        child: CupertinoActivityIndicator(),
      )});

  Widget errorWidget;

  Widget emptyWidget;

  Widget loadingWidget;
}

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
