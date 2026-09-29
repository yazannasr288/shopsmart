import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cart/cartscreen.dart';
import 'screen/homescreen.dart';
import 'screen/profilescreen.dart';
import 'screen/searchscreen.dart';

class Rootscreen extends StatefulWidget {
  const Rootscreen({super.key});

  @override
  State<Rootscreen> createState() => _RootscreenState();
}

class _RootscreenState extends State<Rootscreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  DateTime? _lastBackPress;

  final List<Widget> _screens = const [
    Homescreen(),
    Searchscreen(),
    Cartscreen(),
    Profilescreen(),
  ];

  @override
  void initState() {
    super.initState();
    _verifyCurrentUser();
  }

  Future<void> _verifyCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final providerIds = user.providerData.map((provider) => provider.providerId);
    final isGoogleUser = providerIds.contains('google.com');

    if (!isGoogleUser && !user.emailVerified) {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          if (_lastBackPress == null ||
              now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
            _lastBackPress = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            return false;
          }
          return true;
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          itemBuilder: (context, index) => _screens[index],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOut,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
