import 'package:shared_preferences/shared_preferences.dart';

class Config {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getBaseUrl() async {
    final baseUrl = (await _prefs).getString("baseUrl");

    return baseUrl ?? "";
  }

  Future<void> setBaseUrl(String url) async {
    (await _prefs).setString("baseUrl", url);
  }
}
