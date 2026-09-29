import 'package:flutter/material.dart';

import '../consts/app_constants.dart';
import '../imgservices/assets_manager.dart';
import '../model/product_model.dart';
import '../widget/app_name.dart';
import '../widget/empty_bag.dart';
import 'button_checkout.dart';
import 'cart_widget.dart';

class CartLine {
  const CartLine({required this.product, this.quantity = 1});

  final ProductModel product;
  final int quantity;

  CartLine copyWith({int? quantity}) => CartLine(
        product: product,
        quantity: quantity ?? this.quantity,
      );
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartLine> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      CartLine(product: AppConstants.products[0], quantity: 1),
      CartLine(product: AppConstants.products[2], quantity: 2),
      CartLine(product: AppConstants.products[5], quantity: 1),
    ];
  }

  double get _total => _items.fold(
        0,
        (sum, item) => sum + item.product.price * item.quantity,
      );

  int get _itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void _updateQuantity(int index, int quantity) {
    setState(() => _items[index] = _items[index].copyWith(quantity: quantity));
  }

  void _removeItem(int index) => setState(() => _items.removeAt(index));

  void _clearCart() => setState(_items.clear);

  @override
  Widget build(BuildContext context) {
    final isEmpty = _items.isEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppName(),
        actions: [
          if (!isEmpty)
            IconButton(
              tooltip: 'Clear cart',
              onPressed: () => _confirmClearCart(context),
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: isEmpty
          ? EmptyBag(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Your cart is empty',
              subtitle: 'Browse the store and add something you love.',
              buttonText: 'Continue shopping',
              onPressed: () {},
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 130),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = _items[index];
                return CartWidget(
                  product: item.product,
                  quantity: item.quantity,
                  onRemove: () => _removeItem(index),
                  onQuantityChanged: (value) => _updateQuantity(index, value),
                );
              },
            ),
      bottomNavigationBar: isEmpty
          ? null
          : CheckoutButton(
              total: _total,
              itemCount: _itemCount,
              onCheckout: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout is ready to connect to your payment flow.')),
                );
              },
            ),
    );
  }

  Future<void> _confirmClearCart(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('All current items will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) _clearCart();
  }
}
