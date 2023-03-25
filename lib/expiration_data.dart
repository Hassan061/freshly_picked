import 'dart:convert';

List<ExpirationData> parseExpirationData(String jsonData) {
  final List<dynamic> parsedJson = json.decode(jsonData);
  return parsedJson
      .map<ExpirationData>((json) => ExpirationData.fromJson(json))
      .toList();
}

// Add fromJson constructors to your classes
class ExpirationData {
  final String title;
  final List<SubItem> subItems;

  ExpirationData({required this.title, required this.subItems});

  factory ExpirationData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> subItemsJson = json['subItems'];
    final List<SubItem> subItems = subItemsJson
        .map<SubItem>((subItemJson) => SubItem.fromJson(subItemJson))
        .toList();

    return ExpirationData(
      title: json['title'],
      subItems: subItems,
    );
  }
}

class SubItem {
  final String name;
  final Map<String, String> expiration;

  SubItem({required this.name, required this.expiration});

  factory SubItem.fromJson(Map<String, dynamic> json) {
    return SubItem(
      name: json['name'],
      expiration: Map<String, String>.from(json['expiration']),
    );
  }
}
