//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fast_code/fast_code_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) fast_code_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FastCodePlugin");
  fast_code_plugin_register_with_registrar(fast_code_registrar);
}
