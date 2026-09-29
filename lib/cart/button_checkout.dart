import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key, required this.total, required this.itemCount, required this.onCheckout});

  final double total;
  final int itemCount;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$itemCount items'),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: onCheckout,
                icon: const Icon(Icons.lock_outline),
                label: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
