import 'package:flutter_test/flutter_test.dart';
import 'package:fast_code/src/channel/fast_code_channel.dart';
import 'package:fast_code/src/channel/fast_code_platform_interface.dart';
import 'package:fast_code/src/channel/fast_code_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFastCodePlatform
    with MockPlatformInterfaceMixin
    implements FastCodePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FastCodePlatform initialPlatform = FastCodePlatform.instance;

  test('$MethodChannelFastCode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFastCode>());
  });

  test('getPlatformVersion', () async {
    FastCodeChannel fastCodePlugin = FastCodeChannel();
    MockFastCodePlatform fakePlatform = MockFastCodePlatform();
    FastCodePlatform.instance = fakePlatform;

    expect(await fastCodePlugin.getPlatformVersion(), '42');
  });
}
