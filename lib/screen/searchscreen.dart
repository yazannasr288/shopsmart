import 'package:flutter/material.dart';

import '../imgservices/assetsmaneger.dart';
import '../products/productswidget.dart';
import '../widget/Appnamed.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _products = List<String>.generate(
    24,
    (index) => 'Product ${index + 1}',
  );

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products
        .where((item) => item.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Appnamed(textappnamed: 'ShopSmart'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(Assetsmaneger.shoppingcart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(Assetsmaneger.emptysearch, height: 140),
                          const SizedBox(height: 12),
                          const Text('No products found'),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: filteredProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        return Productswidget(title: filteredProducts[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
