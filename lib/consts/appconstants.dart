import 'package:shopsmart/model/categorimodel.dart';

import '../imgservices/assetsmaneger.dart';

class AppConstant {
  static const String productimgUrl =
      'https://images.unsplash.com/photo-1465572089651-8fde36c892dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';

  static const List<String> banneersImages = [
    Assetsmaneger.banner1,
    Assetsmaneger.banner2,
  ];

  static final List<Categorymodel> categorieslist = [
    Categorymodel(name: 'Books', img: Assetsmaneger.book, id: Assetsmaneger.book),
    Categorymodel(name: 'Cosmetics', img: Assetsmaneger.cosmetics, id: Assetsmaneger.cosmetics),
    Categorymodel(name: 'Electronics', img: Assetsmaneger.elecronics, id: Assetsmaneger.elecronics),
    Categorymodel(name: 'Fashion', img: Assetsmaneger.fashion, id: Assetsmaneger.fashion),
    Categorymodel(name: 'Mobiles', img: Assetsmaneger.mobiles, id: Assetsmaneger.mobiles),
    Categorymodel(name: 'PC', img: Assetsmaneger.pc, id: Assetsmaneger.pc),
    Categorymodel(name: 'Shoes', img: Assetsmaneger.shoes, id: Assetsmaneger.shoes),
    Categorymodel(name: 'Watches', img: Assetsmaneger.watch, id: Assetsmaneger.watch),
  ];
}
