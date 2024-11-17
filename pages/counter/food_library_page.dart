import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'add_custom_food_page.dart';

class FoodLibraryPage extends StatefulWidget {
  final String mealType;

  const FoodLibraryPage({Key? key, required this.mealType}) : super(key: key);

  @override
  _FoodLibraryPageState createState() => _FoodLibraryPageState();
}

class _FoodLibraryPageState extends State<FoodLibraryPage> {
  static List<Map<String, dynamic>> _defaultFoodLibrary = [
    {'name': 'Burger', 'description': '354 kcal, with cheese', 'calories': 354},
    {'name': 'Pizza', 'description': '285 kcal, 1 slice', 'calories': 285},
    {'name': 'Salad', 'description': '120 kcal, with dressing', 'calories': 120},
    {'name': 'Pasta', 'description': '200 kcal, tomato sauce', 'calories': 200},
    {'name': 'Grilled Chicken', 'description': '165 kcal, 100g', 'calories': 165},
  ];

  static List<Map<String, dynamic>> _customFoodLibrary = [];

  String _searchQuery = '';

  List<Map<String, dynamic>> get _foodLibrary => [..._defaultFoodLibrary, ..._customFoodLibrary];

  void _addCustomFood(Map<String, dynamic> newFood) {
    setState(() {
      _customFoodLibrary.add(newFood);
    });
  }

  void _openAddCustomFoodPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCustomFoodPage(onAddFood: _addCustomFood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFood = _foodLibrary
        .where((food) =>
        food['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: MyAppbar(showBackButton: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search Food',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: _openAddCustomFoodPage,
                  tooltip: 'Add Custom Food',
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFood.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredFood[index]['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    filteredFood[index]['description'],
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.pop(context, filteredFood[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}