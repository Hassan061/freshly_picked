import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:freshly_picked/food_item.dart';

part 'food_item.g.dart';

int? getAverageExpirationDays(String expirationString) {
  final RegExp regExp = RegExp(r'\d+');
  final Iterable<Match> matches = regExp.allMatches(expirationString);
  final List<int> numbers = matches.map((m) => int.parse(m.group(0)!)).toList();

  if (numbers.isEmpty) {
    return null;
  }

  final int sum = numbers.reduce((a, b) => a + b);
  return sum ~/ numbers.length;
}

DateTime? getNewExpirationDate(String? expirationString) {
  if (expirationString == null) {
    return null;
  }

  final int? averageDays = getAverageExpirationDays(expirationString);
  if (averageDays == null) {
    return null;
  }

  return DateTime.now().add(Duration(days: averageDays));
}

@JsonSerializable()
class FoodItem {
  final String title;
  final List<SubItem> subItems;

  FoodItem({required this.title, required this.subItems});
  // The constructor is used to create new instances of the class.

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
  // new instance of the class from a json
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}

@JsonSerializable()
class SubItem {
  final String name;
  final Expiration expiration;

  SubItem({required this.name, required this.expiration});

  factory SubItem.fromJson(Map<String, dynamic> json) =>
      _$SubItemFromJson(json);
  Map<String, dynamic> toJson() => _$SubItemToJson(this);

  String? getExpirationByStorage(String storageType) {
    switch (storageType) {
      case 'Pantry':
        return expiration.Pantry;
      case 'Fridge':
        return expiration.Fridge;
      case 'Freezer':
        return expiration.Freezer;
      default:
        return null;
    }
  }
}

@JsonSerializable()
class Expiration {
  final String Pantry;
  final String Fridge;
  final String Freezer;

  Expiration(
      {required this.Pantry, required this.Fridge, required this.Freezer});

  factory Expiration.fromJson(Map<String, dynamic> json) =>
      _$ExpirationFromJson(json);
  Map<String, dynamic> toJson() => _$ExpirationToJson(this);
}

Future<List<FoodItem>> loadFoodItems() async {
  String jsonString = await rootBundle.loadString('assets/food-exp.json');
  List<dynamic> jsonResponse = jsonDecode(jsonString);
  return jsonResponse.map((item) => FoodItem.fromJson(item)).toList();
}
