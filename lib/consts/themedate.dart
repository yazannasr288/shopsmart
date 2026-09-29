import 'package:flutter/material.dart';
import 'appcolors.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarktheme,
    required BuildContext context,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: isDarktheme ? Appcolors.darkprimary : Appcolors.lightprimary,
      brightness: isDarktheme ? Brightness.dark : Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDarktheme
          ? Appcolors.darkscaffoldcolor
          : Appcolors.ligtscaffoldcolor,
      cardColor: isDarktheme ? Appcolors.darkcardcolor : Appcolors.lightcardcolor,
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarktheme ? const Color(0x221FFFFFF) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: isDarktheme ? FontWeight.w500 : FontWeight.w600),
        ),
      ),
    );
  }
}
