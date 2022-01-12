import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm/module/shopping/model/cart.dart';
import 'package:sm/module/shopping/model/category_model.dart';
import 'package:sm/module/shopping/shop_const.dart';
import 'package:sm/module/shopping/views/shop_login.dart';


///此实例用于使用Shopping演示Provider的使用，单独作为一个application
class ShopAppPage extends StatelessWidget {

  const ShopAppPage({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    ShopConst.routes[ShopConst.home] = (context) =>  ShopLoginPage();
    return MultiProvider(
      providers: [
        Provider(create: (ctx)=>CategoryModel()),
        ChangeNotifierProxyProvider<CategoryModel,Cart>(create: (ctx) => Cart(),
          update: (_,category,cart){
          if(cart == null) {
            throw ArgumentError.value("Cart is null");
          }
           cart.category = category;
           return cart;
          },
        )
      ],
      child: MaterialApp(
        title: "Shopping",
        initialRoute: "/",
        routes: ShopConst.routes,
        // routes: {
        //   ShopConst.home: (context) => ShopLoginPage(),
        // },
      ),
    );
  }
}