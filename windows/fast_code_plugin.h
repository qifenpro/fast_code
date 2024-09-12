#ifndef FLUTTER_PLUGIN_FAST_CODE_PLUGIN_H_
#define FLUTTER_PLUGIN_FAST_CODE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace fast_code {

class FastCodePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FastCodePlugin();

  virtual ~FastCodePlugin();

  // Disallow copy and assign.
  FastCodePlugin(const FastCodePlugin&) = delete;
  FastCodePlugin& operator=(const FastCodePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace fast_code

#endif  // FLUTTER_PLUGIN_FAST_CODE_PLUGIN_H_
