import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: Center(
        child: Text(
          'Address will be connected to your Firebase data source.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
