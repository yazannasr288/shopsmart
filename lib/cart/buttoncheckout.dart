import 'package:flutter/material.dart';

class Checkoutbutton extends StatelessWidget {
  const Checkoutbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('6 products / 6 items'),
                  SizedBox(height: 2),
                  Text(
                    '\$96.00',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
