import 'package:bulkfitness/components/my_custom_calendar.dart';
import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';
import '../../components/my_dropdown.dart';
import 'food_library_page.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> with AutomaticKeepAliveClientMixin {
  String? _selectedBreakfast;
  String? _selectedLunch;
  String? _selectedDinner;

  int _breakfastCalories = 0;
  int _lunchCalories = 0;
  int _dinnerCalories = 0;

  final int _goalCalories = 2200;

  List<Map<String, String>> _breakfastItems = [];
  List<Map<String, String>> _lunchItems = [];
  List<Map<String, String>> _dinnerItems = [];

  late DateTime _selectedDate;
  Map<DateTime, Map<String, List<Map<String, String>>>> _dateData = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _initializeDateData(_selectedDate);
  }

  void _initializeDateData(DateTime date) {
    if (!_dateData.containsKey(date)) {
      _dateData[date] = {
        'breakfast': [],
        'lunch': [],
        'dinner': [],
      };
    }
    _loadDataForDate(date);
  }

  void _loadDataForDate(DateTime date) {
    setState(() {
      _breakfastItems = _dateData[date]!['breakfast']!;
      _lunchItems = _dateData[date]!['lunch']!;
      _dinnerItems = _dateData[date]!['dinner']!;
      _updateCalories();
    });
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _saveCurrentData();
      _selectedDate = newDate;
      _initializeDateData(newDate);
    });
  }

  void _saveCurrentData() {
    _dateData[_selectedDate] = {
      'breakfast': _breakfastItems,
      'lunch': _lunchItems,
      'dinner': _dinnerItems,
    };
  }

  void _removeItem(String? mealType, String? itemName) {
    setState(() {
      if (mealType == 'breakfast') {
        _breakfastItems.removeWhere((item) => item['name'] == itemName);
      } else if (mealType == 'lunch') {
        _lunchItems.removeWhere((item) => item['name'] == itemName);
      } else if (mealType == 'dinner') {
        _dinnerItems.removeWhere((item) => item['name'] == itemName);
      }
      _updateCalories();
      _saveCurrentData();
    });
  }

  void _updateCalories() {
    _breakfastCalories = _calculateMealCalories(_breakfastItems);
    _lunchCalories = _calculateMealCalories(_lunchItems);
    _dinnerCalories = _calculateMealCalories(_dinnerItems);
  }

  int _calculateMealCalories(List<Map<String, String>> items) {
    return items.fold(0, (sum, item) {
      final calorieString = item['description']?.split(' ')[0] ?? '0';
      return sum + int.parse(calorieString);
    });
  }

  Future<void> _addFood(String mealType) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodLibraryPage(mealType: mealType),
      ),
    );

    if (result != null) {
      setState(() {
        switch (mealType) {
          case 'Breakfast':
            _breakfastItems.add({
              'name': result['name'],
              'description': '${result['calories']} kcal, ${result['description']}',
            });
            break;
          case 'Lunch':
            _lunchItems.add({
              'name': result['name'],
              'description': '${result['calories']} kcal, ${result['description']}',
            });
            break;
          case 'Dinner':
            _dinnerItems.add({
              'name': result['name'],
              'description': '${result['calories']} kcal, ${result['description']}',
            });
            break;
        }
        _updateCalories();
        _saveCurrentData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int totalCalories = _breakfastCalories + _lunchCalories + _dinnerCalories;
    int remainingCalories = _goalCalories - totalCalories;

    return Scaffold(
      appBar: const MyAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Calorie",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          MyCustomCalendar(onDateChanged: _onDateChanged,
          initialDate: _selectedDate,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text("$totalCalories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text("Taken", style: TextStyle(fontSize: 14, color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 140,
                      width: 140,
                      child: CircularProgressIndicator(
                        value: totalCalories / _goalCalories,
                        strokeWidth: 20,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 20,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$_goalCalories", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 4),
                        Text("Goal", style: TextStyle(fontSize: 16, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 13.0),
                        child: Text("$remainingCalories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      SizedBox(height: 8),
                      Text("Remaining", style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyDropdown(
                    title: "Breakfast",
                    subtitle: "$_breakfastCalories kcal",
                    selectedValue: _selectedBreakfast,
                    items: _breakfastItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedBreakfast = value;
                      });
                    },
                    onRemove: (itemName) {
                      _removeItem('breakfast', itemName);
                    },
                    onAdd: () => _addFood('Breakfast'),
                  ),
                  MyDropdown(
                    title: "Lunch",
                    subtitle: "$_lunchCalories kcal",
                    selectedValue: _selectedLunch,
                    items: _lunchItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedLunch = value;
                      });
                    },
                    onRemove: (itemName) {
                      _removeItem('lunch', itemName);
                    },
                    onAdd: () => _addFood('Lunch'),
                  ),
                  MyDropdown(
                    title: "Dinner",
                    subtitle: "$_dinnerCalories kcal",
                    selectedValue: _selectedDinner,
                    items: _dinnerItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedDinner = value;
                      });
                    },
                    onRemove: (itemName) {
                      _removeItem('dinner', itemName);
                    },
                    onAdd: () => _addFood('Dinner'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}