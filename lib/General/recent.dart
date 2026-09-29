import 'package:flutter/material.dart';

class Recent extends StatelessWidget {
  const Recent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent')),
      body: Center(
        child: Text(
          'Recent will be connected to your Firebase data source.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
