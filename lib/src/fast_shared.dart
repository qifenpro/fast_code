import 'package:shared_preferences/shared_preferences.dart';

class FastShared {
  // 获取 SharedPreferences 实例
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  // 保存字符串
  static Future<bool> setString(String key, String value) async {
    final prefs = await _getInstance();
    return await prefs.setString(key, value);
  }

  // 获取字符串
  static Future<String?> getString(String key) async {
    final prefs = await _getInstance();
    return prefs.getString(key);
  }

  // 保存整型
  static Future<bool> setInt(String key, int value) async {
    final prefs = await _getInstance();
    return await prefs.setInt(key, value);
  }

  // 获取整型
  static Future<int?> getInt(String key) async {
    final prefs = await _getInstance();
    return prefs.getInt(key);
  }

  // 保存布尔值
  static Future<bool> setBool(String key, bool value) async {
    final prefs = await _getInstance();
    return await prefs.setBool(key, value);
  }

  // 获取布尔值
  static Future<bool?> getBool(String key) async {
    final prefs = await _getInstance();
    return prefs.getBool(key);
  }

  // 保存双精度浮点数
  static Future<bool> setDouble(String key, double value) async {
    final prefs = await _getInstance();
    return await prefs.setDouble(key, value);
  }

  // 获取双精度浮点数
  static Future<double?> getDouble(String key) async {
    final prefs = await _getInstance();
    return prefs.getDouble(key);
  }

  // 保存字符串列表
  static Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await _getInstance();
    return await prefs.setStringList(key, value);
  }

  // 获取字符串列表
  static Future<List<String>?> getStringList(String key) async {
    final prefs = await _getInstance();
    return prefs.getStringList(key);
  }

  // 删除某个键
  static Future<bool> remove(String key) async {
    final prefs = await _getInstance();
    return await prefs.remove(key);
  }

  // 清空所有数据
  static Future<bool> clear() async {
    final prefs = await _getInstance();
    return await prefs.clear();
  }
}
