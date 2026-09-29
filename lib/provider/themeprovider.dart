import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprovider extends ChangeNotifier {
  static const String _themeStatusKey = 'theme_status';
  bool _darkTheme = false;

  bool get getisDarkTheme => _darkTheme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_themeStatusKey);
    if (value == null) return;
    _darkTheme = value;
    notifyListeners();
  }

  Future<void> setDarkTheme({required bool themevalue}) async {
    if (_darkTheme == themevalue) return;
    _darkTheme = themevalue;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeStatusKey, themevalue);
  }
}
