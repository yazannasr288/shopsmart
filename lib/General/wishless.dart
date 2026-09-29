import 'package:flutter/material.dart';

class Wishscreen extends StatelessWidget {
  const Wishscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Center(
        child: Text(
          'Wishlist will be connected to your Firebase data source.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
