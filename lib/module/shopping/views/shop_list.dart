import 'package:flutter/material.dart';
import 'package:sm/module/shopping/model/cart.dart';
import 'package:sm/module/shopping/model/category_model.dart';
import 'package:provider/provider.dart';
import 'package:sm/module/shopping/shop_const.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryModel model = context.watch<CategoryModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ShopConst.shopCart);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                CategoryItem item = model.getByPosition(index);
                return CategoryView(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final CategoryItem item;

  const CategoryView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 50),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: item.color,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(child: Text(item.name)),
          _AddButton(item: item)
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final CategoryItem item;

  const _AddButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isInCart = context.select<Cart, bool>((value) {
      return value.items.contains(item);
    });
    return TextButton(
      onPressed: () {
        if (isInCart) {
        } else {
          Cart cart = context.read<Cart>();
          cart.add(item);
        }
      },
      child: isInCart
          ? const Icon(Icons.add,semanticLabel: "ADDED",)
          : const Text(
              "ADD",
              style: TextStyle(color: Colors.yellow),
            ),
    );
  }
}
