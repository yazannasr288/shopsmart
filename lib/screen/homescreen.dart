import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopsmart/consts/appconstants.dart';
import 'package:shopsmart/imgservices/assetsmaneger.dart';
import 'package:shopsmart/products/ctgwidget.dart';
import 'package:shopsmart/products/lastarrival.dart';
import 'package:shopsmart/widget/Appnamed.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Appnamed(textappnamed: 'ShopSmart'),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(Assetsmaneger.shoppingcart),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future<void>.delayed(const Duration(milliseconds: 250)),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              sliver: SliverToBoxAdapter(
                child: _BannerCarousel(height: size.height * 0.24),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 4),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = AppConstant.categorieslist[index];
                    return Ctgwidget(name: category.name, img: category.img);
                  },
                  childCount: AppConstant.categorieslist.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Latest arrivals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.22,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) => const Lastarrival(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel({required this.height});

  final double height;

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients || AppConstant.banneersImages.length < 2) return;
      _index = (_index + 1) % AppConstant.banneersImages.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: widget.height,
            child: PageView.builder(
              controller: _controller,
              itemCount: AppConstant.banneersImages.length,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) {
                return Image.asset(
                  AppConstant.banneersImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                AppConstant.banneersImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: index == _index ? 18 : 7,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: index == _index ? 1 : 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
