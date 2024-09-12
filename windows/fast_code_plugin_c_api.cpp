#include "include/fast_code/fast_code_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fast_code_plugin.h"

void FastCodePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fast_code::FastCodePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
