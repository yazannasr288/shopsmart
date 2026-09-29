import 'package:flutter/material.dart';

import '../consts/app_constants.dart';
import '../imgservices/assets_manager.dart';
import '../products/product_widget.dart';
import '../widget/app_name.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = AppConstants.products.where((product) {
      final query = _query.trim().toLowerCase();
      return query.isEmpty ||
          product.title.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
    }).toList();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(9),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
          title: const AppName(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Search products or categories',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear search',
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                ),
              ),
            ),
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AssetsManager.emptySearch, width: 150),
                          const SizedBox(height: 12),
                          Text(
                            'No products found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth >= 1000 ? 4 : 2;
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.68,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) => ProductWidget(
                            product: products[index],
                          ),
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
