import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 260,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 96,
                height: 110,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.category,
                        style: TextStyle(
                          color: scheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
