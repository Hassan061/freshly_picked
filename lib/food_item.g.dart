// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
      title: json['title'] as String,
      subItems: (json['subItems'] as List<dynamic>)
          .map((e) => SubItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'title': instance.title,
      'subItems': instance.subItems,
    };

SubItem _$SubItemFromJson(Map<String, dynamic> json) => SubItem(
      name: json['name'] as String,
      expiration:
          Expiration.fromJson(json['expiration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubItemToJson(SubItem instance) => <String, dynamic>{
      'name': instance.name,
      'expiration': instance.expiration,
    };

Expiration _$ExpirationFromJson(Map<String, dynamic> json) => Expiration(
      Pantry: json['Pantry'] as String? ?? '',
      Fridge: json['Fridge'] as String? ?? '',
      Freezer: json['Freezer'] as String? ?? '',
    );

Map<String, dynamic> _$ExpirationToJson(Expiration instance) =>
    <String, dynamic>{
      'Pantry': instance.Pantry,
      'Fridge': instance.Fridge,
      'Freezer': instance.Freezer,
    };
