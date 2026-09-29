import 'package:flutter/material.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SimpleEmptyScreen(
      title: 'All orders',
      message: 'Your completed and active orders will appear here.',
      icon: Icons.receipt_long_outlined,
    );
  }
}

class _SimpleEmptyScreen extends StatelessWidget {
  const _SimpleEmptyScreen({required this.title, required this.message, required this.icon});

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 18),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
