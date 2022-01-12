import 'package:flutter/foundation.dart';
import 'package:sm/module/shopping/model/category_model.dart';

class Cart extends ChangeNotifier {
  late CategoryModel _category;

  ///加入购物车的物品id
  final List<int> _ids = [];

  set category(CategoryModel category) {
    _category = category;
    notifyListeners();
  }

  CategoryModel get category => _category;

  List<CategoryItem> get items =>
      _ids.map((e) => _category.getById(e)).toList();

  int get totalPrice => items.fold<int>(
      0, (previousValue, element) => previousValue + element.price);

  void add(CategoryItem item) {
    _ids.add(item.id);
    notifyListeners();
  }

  void remove(CategoryItem item) {
    _ids.remove(item.id);
    notifyListeners();
  }
}
