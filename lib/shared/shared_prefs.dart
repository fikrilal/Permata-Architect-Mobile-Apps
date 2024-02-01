import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveidproyek(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getidproyek(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<void> deleteidproyek(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
