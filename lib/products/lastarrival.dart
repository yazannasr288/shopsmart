import 'dart:developer';

import 'package:flutter/material.dart';

import '../consts/appconstants.dart';

class Lastarrival extends StatelessWidget {
  const Lastarrival({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width * 0.78,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => log('Open latest product'),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    AppConstant.productimgUrl,
                    width: size.width * 0.27,
                    height: size.width * 0.27,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const ColoredBox(
                      color: Color(0xFFEFEFEF),
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Latest product',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {},
                            icon: const Icon(Icons.add_shopping_cart_rounded),
                          ),
                        ],
                      ),
                      Text(
                        '\$166.50',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
