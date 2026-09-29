import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: scheme.surface.withValues(alpha: 0.92),
                        shape: const CircleBorder(),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: _isFavorite ? 'Remove from wishlist' : 'Add to wishlist',
                          onPressed: () => setState(() => _isFavorite = !_isFavorite),
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? scheme.error : scheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.category,
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: scheme.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: 'Add to cart',
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('${widget.product.title} added to cart.'),
                          ),
                        );
                    },
                    icon: const Icon(Icons.add_shopping_cart_outlined),
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
