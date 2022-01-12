
import 'package:flutter/material.dart';
import 'package:sm/module/shopping/views/cart_page.dart';
import 'package:sm/module/shopping/views/shop_list.dart';
import 'package:sm/module/shopping/views/shop_login.dart';

class ShopConst {
  static const String home = "/";
  static const String shopLogin = "/shopLogin";
  static const String shopList = "/shopList";
  static const String shopCart = "/shopCart";

  static Map<String,WidgetBuilder> routes = {
    shopLogin:(context) => const ShopLoginPage(),
    shopList: (context) => const ShopListPage(),
    shopCart: (context) => const CartPage(),
  };
}