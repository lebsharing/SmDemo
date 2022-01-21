import 'dart:math';

import 'package:sm/module/bloc/eg/complex_list/model/Item.dart';

class ListRepository {

  final Random _random = Random();

  int _randomDuration(int min,int max) {
    return _random.nextInt(max - min) + min;
  }

  Future<List<Item>> fetchList() async {
    await Future.delayed(Duration(seconds: _randomDuration(2, 6)));
    return _generateList(18);
  }

  List<Item> _generateList(int length) {
    return List.generate(length, (index) => Item(id: index, name: "index->$index"));
  }

  Future<void> deleteItem(int id) async {
    return Future.delayed(Duration(seconds: _randomDuration(2, 6)));
  }

}