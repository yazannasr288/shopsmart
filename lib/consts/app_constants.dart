import '../imgservices/assets_manager.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

abstract final class AppConstants {
  static const bannerImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static const categories = [
    CategoryModel(id: 'books', name: 'Books', image: AssetsManager.book),
    CategoryModel(id: 'cosmetics', name: 'Cosmetics', image: AssetsManager.cosmetics),
    CategoryModel(id: 'electronics', name: 'Electronics', image: AssetsManager.electronics),
    CategoryModel(id: 'fashion', name: 'Fashion', image: AssetsManager.fashion),
    CategoryModel(id: 'mobiles', name: 'Mobiles', image: AssetsManager.mobiles),
    CategoryModel(id: 'pc', name: 'PC', image: AssetsManager.pc),
    CategoryModel(id: 'shoes', name: 'Shoes', image: AssetsManager.shoes),
    CategoryModel(id: 'watch', name: 'Watches', image: AssetsManager.watch),
  ];

  static const products = [
    ProductModel(
      id: 'p1',
      title: 'Wireless Headphones',
      price: 49.99,
      category: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p2',
      title: 'Classic Watch',
      price: 79.00,
      category: 'Watches',
      imageUrl: 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p3',
      title: 'Minimal Sneakers',
      price: 64.50,
      category: 'Shoes',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p4',
      title: 'Modern Backpack',
      price: 42.00,
      category: 'Fashion',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p5',
      title: 'Smartphone',
      price: 599.00,
      category: 'Mobiles',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p6',
      title: 'Mechanical Keyboard',
      price: 89.99,
      category: 'PC',
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p7',
      title: 'Skincare Set',
      price: 35.00,
      category: 'Cosmetics',
      imageUrl: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=900&q=80',
    ),
    ProductModel(
      id: 'p8',
      title: 'Everyday Novel',
      price: 18.99,
      category: 'Books',
      imageUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=900&q=80',
    ),
  ];
}
