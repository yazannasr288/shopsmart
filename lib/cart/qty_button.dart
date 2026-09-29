import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  const QtyButton({super.key, required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select quantity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              children: List.generate(
                10,
                (index) {
                  final quantity = index + 1;
                  return ChoiceChip(
                    label: Text('$quantity'),
                    selected: value == quantity,
                    onSelected: (_) => onChanged(quantity),
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
