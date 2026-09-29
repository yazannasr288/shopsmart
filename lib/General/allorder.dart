import 'package:flutter/material.dart';

class Allorder extends StatelessWidget {
  const Allorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All orders')),
      body: Center(
        child: Text(
          'All orders will be connected to your Firebase data source.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
