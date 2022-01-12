import 'package:flutter/material.dart';
import 'package:sm/module/shopping/shop_const.dart';

class ShopLoginPage extends StatefulWidget {

  const ShopLoginPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShopLoginPageState();
  }
}

class _ShopLoginPageState extends State<ShopLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headline5,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Username"),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ShopConst.shopList);
                },
                child: const Text("ENTER"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
