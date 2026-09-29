import 'package:flutter/material.dart';

import 'buttoncheckout.dart';
import 'cartwidget.dart';
import '../imgservices/assetsmaneger.dart';
import '../widget/Appnamed.dart';
import '../widget/emptybag.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  static const bool _isEmpty = false;

  @override
  Widget build(BuildContext context) {
    if (_isEmpty) {
      return Scaffold(
        body: Emptybag(
          imgpath: Assetsmaneger.shoppingcart,
          title: 'Your cart is empty',
          subtitle: 'Go to the home screen and start shopping.',
          buttonText: 'Start shopping',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Appnamed(textappnamed: 'ShopSmart'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(Assetsmaneger.shoppingcart),
        ),
        actions: [
          IconButton(
            tooltip: 'Clear cart',
            onPressed: () {},
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      bottomNavigationBar: const Checkoutbutton(),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 12),
        itemCount: 6,
        itemBuilder: (context, index) => const Cartwidget(quantity: 1),
      ),
    );
  }
}
