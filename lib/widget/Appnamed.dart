import 'package:flutter/material.dart';

class Appnamed extends StatelessWidget {
  const Appnamed({super.key, required this.textappnamed});

  final String textappnamed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      textappnamed,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: -0.4,
      ),
    );
  }
}
