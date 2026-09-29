import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../General/adreess.dart';
import '../General/allorder.dart';
import '../General/recent.dart';
import '../General/wishless.dart';
import '../auth/google sign in.dart';
import '../imgservices/assetsmaneger.dart';
import '../provider/themeprovider.dart';
import '../widget/Appnamed.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = context.watch<Themeprovider>();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(Assetsmaneger.shoppingcart),
        ),
        title: const Appnamed(textappnamed: 'ShopSmart'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage(Assetsmaneger.logo) as ImageProvider,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? 'ShopSmart user',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user?.email ?? 'No email available',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'General',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          const SizedBox(height: 8),
          _ProfileTile(
            icon: Assetsmaneger.ordersvg,
            title: 'All orders',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Allorder()),
            ),
          ),
          _ProfileTile(
            icon: Assetsmaneger.wishlist,
            title: 'Wishlist',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Wishscreen()),
            ),
          ),
          _ProfileTile(
            icon: Assetsmaneger.recent,
            title: 'Recent',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Recent()),
            ),
          ),
          _ProfileTile(
            icon: Assetsmaneger.address,
            title: 'Address',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Address()),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            secondary: Image.asset(Assetsmaneger.theme, height: 30),
            title: Text(themeProvider.getisDarkTheme ? 'Dark mode' : 'Light mode'),
            value: themeProvider.getisDarkTheme,
            onChanged: (value) => themeProvider.setDarkTheme(themevalue: value),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          FilledButton.tonalIcon(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.title, required this.onTap});

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Image.asset(icon, height: 30, width: 30),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
