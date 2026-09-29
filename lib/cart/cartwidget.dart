import 'package:flutter/material.dart';

import 'qtybutton.dart';
import '../consts/appconstants.dart';

class Cartwidget extends StatelessWidget {
  const Cartwidget({super.key, this.quantity = 1});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                AppConstant.productimgUrl,
                height: 96,
                width: 96,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 96,
                  width: 96,
                  child: ColoredBox(
                    color: Color(0xFFEFEFEF),
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Product item',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {},
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$16.00',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await showModalBottomSheet<void>(
                            context: context,
                            showDragHandle: true,
                            builder: (_) => const Qtybutton(),
                          );
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        label: Text('Qty $quantity'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
