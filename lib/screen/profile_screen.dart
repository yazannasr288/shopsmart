import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../general/address.dart';
import '../general/all_orders.dart';
import '../general/recent.dart';
import '../general/wishlist.dart';
import '../imgservices/assets_manager.dart';
import '../provider/theme_provider.dart';
import '../widget/app_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = context.watch<ThemeProvider>();
    final photoUrl = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppName(),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: photoUrl == null
                        ? AssetImage(AssetsManager.logo)
                        : NetworkImage(photoUrl),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName?.trim().isNotEmpty == true
                              ? user!.displayName!
                              : 'ShopSmart customer',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'No email available',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Account',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          _ProfileTile(
            icon: Icons.receipt_long_outlined,
            title: 'All orders',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AllOrdersScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WishlistScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.history,
            title: 'Recent items',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const Recent()),
            ),
          ),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddressScreen()),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Preferences',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            secondary: Image.asset(AssetsManager.theme, width: 28, height: 28),
            title: const Text('Dark mode'),
            subtitle: Text(
              themeProvider.isDarkTheme ? 'Enabled' : 'Disabled',
            ),
            value: themeProvider.isDarkTheme,
            onChanged: themeProvider.setDarkTheme,
          ),
          const SizedBox(height: 18),
          FilledButton.tonalIcon(
            onPressed: () => _confirmSignOut(context),
            icon: const Icon(Icons.logout),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('You can sign back in at any time.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await AuthService().signOut();
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
