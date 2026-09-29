import 'dart:developer';

import 'package:flutter/material.dart';

import '../consts/appconstants.dart';

class Productswidget extends StatelessWidget {
  const Productswidget({super.key, this.title = 'Product', this.price = 166.5});

  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: () => log('Open product: $title'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _NetworkProductImage(url: AppConstant.productimgUrl),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Add to wishlist',
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Add to cart',
                    onPressed: () {},
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NetworkProductImage extends StatelessWidget {
  const _NetworkProductImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stackTrace) => const ColoredBox(
        color: Color(0xFFEFEFEF),
        child: Center(child: Icon(Icons.image_not_supported_outlined)),
      ),
    );
  }
}
