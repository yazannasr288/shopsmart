import 'package:flutter/material.dart';

import '../consts/app_constants.dart';
import '../imgservices/assets_manager.dart';
import '../products/category_widget.dart';
import '../products/latest_arrival.dart';
import '../widget/app_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bannerController = PageController();
  int _bannerIndex = 0;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final scheme = Theme.of(context).colorScheme;
    final categoryColumns = width >= 900 ? 8 : width >= 600 ? 6 : 4;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppName(),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future<void>.delayed(const Duration(milliseconds: 500)),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          children: [
            AspectRatio(
              aspectRatio: width >= 700 ? 2.8 : 1.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _bannerController,
                      itemCount: AppConstants.bannerImages.length,
                      onPageChanged: (index) => setState(() => _bannerIndex = index),
                      itemBuilder: (context, index) => Image.asset(
                        AppConstants.bannerImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          AppConstants.bannerImages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _bannerIndex == index ? 20 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              color: _bannerIndex == index
                                  ? Colors.white
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppConstants.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: categoryColumns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final category = AppConstants.categories[index];
                return CategoryWidget(
                  name: category.name,
                  image: category.image,
                );
              },
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Latest arrivals',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                Icon(Icons.auto_awesome, color: scheme.primary),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 112,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => LatestArrival(
                  product: AppConstants.products[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
