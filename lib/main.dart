import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/rootscreen.dart';

import 'auth/auth.dart';
import 'consts/themedate.dart';
import 'firebase_options.dart';
import 'provider/themeprovider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeProvider = Themeprovider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const ShopSmartApp(),
    ),
  );
}

class ShopSmartApp extends StatelessWidget {
  const ShopSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<Themeprovider>().getisDarkTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopSmart',
      theme: Styles.themeData(isDarktheme: false, context: context),
      darkTheme: Styles.themeData(isDarktheme: true, context: context),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const Rootscreen(),
    );
  }
}
