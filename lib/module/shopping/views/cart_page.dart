import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sm/module/shopping/model/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Container(
        color: Colors.yellow[200],
        child: Column(
          children: [
            Expanded(
              child: _CartList(),
            ),
            const Divider(),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cart cart = context.watch<Cart>();

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListTile(
          leading: const Icon(Icons.done),
          title: Text(cart.items[index].name),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              cart.remove(cart.items[index]);
            },
          ),
        );
      },
      itemCount: cart.items.length,
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<Cart>(
            builder: (ctx, cart, child) {
              return Text(
                "\$${cart.totalPrice}",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("The buy function not support.")));
            },
            child: const Text(
              "Buy",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
