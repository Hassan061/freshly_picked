import 'package:flutter/material.dart';
import 'package:freshly_picked/food_item.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'search.dart';

class AddFoodPage extends StatefulWidget {
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  // Declare form key, controllers, and variables
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodController = TextEditingController();
  String? _selectedStorage;
  List<String> _suggestions = [];
  late List<FoodItem> _foodItems = [];
  String _expirationDate = '';

  @override
  void initState() {
    super.initState();
    _loadFoodItems().then((_)
        // initialized right away
        {
      setState(() {});
    });
  }

  Future<void> _loadFoodItems() async {
    _foodItems = await loadFoodItems();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Food')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildFoodTextField(),
              _buildStorageDropdown(),
              _buildExpirationDateText(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodTextField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _foodController,
        decoration: InputDecoration(labelText: 'Food Item'),
      ),
      suggestionsCallback: (pattern) {
        return _generateSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        _foodController.text = suggestion;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a food item';
        }
        return null;
      },
    );
  }

  // Placeholder function for generating suggestions
  List<String> _generateSuggestions(String query) {
    if (query.isEmpty) {
      return [];
    }

    return _foodItems
        .expand((foodItem) => foodItem.subItems)
        .where((subItem) =>
            subItem.name.toLowerCase().contains(query.toLowerCase()))
        .map((subItem) => subItem.name)
        .toList();
  }

  Widget _buildStorageDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStorage,
      onChanged: (newValue) {
        setState(() {
          _selectedStorage = newValue;
        });
      },
      items: [
        DropdownMenuItem(
          value: 'Pantry',
          child: Text('Pantry'),
        ),
        DropdownMenuItem(
          value: 'Fridge',
          child: Text('Fridge'),
        ),
        DropdownMenuItem(
          value: 'Freezer',
          child: Text('Freezer'),
        ),
      ],
      decoration: InputDecoration(labelText: 'Storage'),
      validator: (value) {
        if (value == null) {
          return 'Please select a storage method';
        }
        return null;
      },
    );
  }

  Widget _buildExpirationDateText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Text('Expiration Date: $_expirationDate'),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Perform submission logic
        }
      },
      child: Text('Submit'),
    );
  }
}
