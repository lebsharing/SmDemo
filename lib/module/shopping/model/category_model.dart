import 'package:flutter/material.dart';

class CategoryModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  CategoryItem getById(int id) =>
      CategoryItem(id, itemNames[id % itemNames.length]);

  CategoryItem getByPosition(int position) {
    return getById(position);
  }
}

class CategoryItem {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  CategoryItem(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    return other is CategoryItem && other.id == id;
  }
}
