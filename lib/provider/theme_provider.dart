import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = 'theme_status';

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    if (_isDarkTheme == value) return;
    _isDarkTheme = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }
}
