import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import 'qty_button.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.product,
    required this.quantity,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const SizedBox(
                  width: 92,
                  height: 92,
                  child: Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet<int>(
                            context: context,
                            showDragHandle: false,
                            builder: (_) => QtyButton(
                              value: quantity,
                              onChanged: (newValue) => Navigator.pop(context, newValue),
                            ),
                          );
                          if (result != null) onQuantityChanged(result);
                        },
                        child: Text('Qty $quantity'),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Remove item',
                        onPressed: onRemove,
                        icon: const Icon(Icons.delete_outline),
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
