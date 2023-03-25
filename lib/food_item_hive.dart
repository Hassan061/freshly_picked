import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main.dart';

class FoodItemHive {
  static const String _boxName = 'foodItems';

  static Future<void> addFoodItem(FoodItem foodItem) async {
    final box = await Hive.openBox<FoodItem>(_boxName);
    await box.add(foodItem);
  }

  static Future<void> removeFoodItem(int index) async {
    final box = await Hive.openBox<FoodItem>(_boxName);
    await box.deleteAt(index);
  }

  static Future<List<FoodItem>> getAllFoodItems() async {
    final box = await Hive.openBox<FoodItem>(_boxName);
    return box.values.toList();
  }
}
