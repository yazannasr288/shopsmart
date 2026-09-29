import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({super.key, this.text = 'ShopSmart'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
    );
  }
}
