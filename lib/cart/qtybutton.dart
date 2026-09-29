import 'package:flutter/material.dart';

class Qtybutton extends StatelessWidget {
  const Qtybutton({super.key, this.initialQuantity = 1});

  final int initialQuantity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            const SizedBox(height: 6),
            Container(
              height: 5,
              width: 52,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select quantity',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final quantity = index + 1;
                  return ListTile(
                    title: Text('$quantity'),
                    trailing: quantity == initialQuantity
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () => Navigator.pop(context, quantity),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
