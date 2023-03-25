import 'package:flutter/material.dart';
import 'package:freshly_picked/food_item.dart';

class SearchPage extends StatefulWidget {
  final List<FoodItem> foodItems;

  SearchPage({required this.foodItems});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  ValueNotifier<List<String>> _suggestionsNotifier =
      ValueNotifier<List<String>>([]);

  @override
  void dispose() {
    _controller.dispose();
    _suggestionsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                _suggestionsNotifier.value =
                    searchSuggestions(value, widget.foodItems);
              },
              decoration: InputDecoration(
                labelText: 'Food Item',
              ),
            ),
          ),
          Expanded(
            child: FilteredList(suggestionsNotifier: _suggestionsNotifier),
          ),
        ],
      ),
    );
  }

  List<String> searchSuggestions(String query, List<FoodItem> foodItems) {
    List<String> suggestions = [];
    for (var foodItem in foodItems) {
      if (foodItem.title.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(foodItem.title);
        suggestions.addAll(foodItem.subItems.map((subItem) => subItem.name));
      }
    }
    return suggestions;
  }
}

class FilteredList extends StatelessWidget {
  final ValueNotifier<List<String>> suggestionsNotifier;

  FilteredList({required this.suggestionsNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: suggestionsNotifier,
      builder: (context, suggestions, child) {
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index]),
            );
          },
        );
      },
    );
  }
}
