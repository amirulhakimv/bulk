import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';
import 'exercise_detail_page.dart';

class ExerciseLibraryPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onExercisesSelected;
  final bool multiSelect;

  const ExerciseLibraryPage({
    Key? key,
    required this.onExercisesSelected,
    this.multiSelect = false,
  }) : super(key: key);

  @override
  State<ExerciseLibraryPage> createState() => _ExerciseLibraryPageState();
}

class _ExerciseLibraryPageState extends State<ExerciseLibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedMuscleGroup;
  List<Map<String, dynamic>> selectedExercises = [];

  final List<String> muscleGroups = [
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Legs',
    'Core',
  ];

  final List<Map<String, dynamic>> allExercises = [
    {
      'title': 'Bench Press',
      'icon': Icons.airline_seat_flat,
      'muscleGroup': 'Chest',
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
      ],
    },
    {
      'title': 'Shoulder Press',
      'icon': Icons.accessibility_new,
      'muscleGroup': 'Shoulders',
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
      ],
    },
    {
      'title': 'Dumbbell Bicep Curl',
      'icon': Icons.fitness_center,
      'muscleGroup': 'Arms',
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
      ],
    },
    {
      'title': 'Deadlift',
      'icon': Icons.fitness_center,
      'muscleGroup': 'Back',
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredExercises {
    return allExercises.where((exercise) {
      final matchesSearch = exercise['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesMuscle = _selectedMuscleGroup == null || exercise['muscleGroup'] == _selectedMuscleGroup;
      return matchesSearch && matchesMuscle;
    }).toList();
  }

  List<Map<String, dynamic>> get recentWorkouts {
    // In a real app, this would be fetched from a database
    return allExercises.take(3).toList();
  }

  void _showMuscleGroupFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Filter by Muscle Group',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select a muscle group to filter exercises:',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ...muscleGroups.map((group) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedMuscleGroup == group ? Colors.blue : Colors.grey[800],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      group,
                      style: const TextStyle(fontSize: 18),
                    ),
                    if (_selectedMuscleGroup == group)
                      const Icon(Icons.check, color: Colors.white),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _selectedMuscleGroup = _selectedMuscleGroup == group ? null : group;
                  });
                  Navigator.pop(context);
                },
              ),
            )),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              child: const Text(
                'Clear Filter',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              onPressed: () {
                setState(() {
                  _selectedMuscleGroup = null;
                });
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToExerciseDetail(Map<String, dynamic> exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailPage(exercise: exercise),
      ),
    );
  }

  Widget buildExerciseItem(Map<String, dynamic> exercise) {
    bool isSelected = selectedExercises.contains(exercise);
    return ListTile(
      leading: GestureDetector(
        onTap: () => _navigateToExerciseDetail(exercise),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            exercise['icon'] as IconData,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      title: GestureDetector(
        onTap: () => _navigateToExerciseDetail(exercise),
        child: Text(
          exercise['title'] as String,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      trailing: widget.multiSelect
          ? Checkbox(
        value: isSelected,
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              selectedExercises.add(exercise);
            } else {
              selectedExercises.remove(exercise);
            }
          });
        },
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return Colors.grey;
        }),
      )
          : IconButton(
        icon: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          widget.onExercisesSelected([exercise]);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        showBackButton: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey[600]),
                        hintText: 'Search workout',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _showMuscleGroupFilter,
                  icon: Icon(
                    Icons.filter_list,
                    color: _selectedMuscleGroup != null ? Colors.blue : Colors.grey[600],
                  ),
                  label: Text(
                    _selectedMuscleGroup ?? 'Filter',
                    style: TextStyle(
                      color: _selectedMuscleGroup != null ? Colors.blue : Colors.grey[600],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.multiSelect) ...[
                      const Text(
                        'Recent Workouts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...recentWorkouts.map((exercise) => buildExerciseItem(exercise)).toList(),
                      const SizedBox(height: 24),
                    ],
                    const Text(
                      'All Exercises',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...filteredExercises.map((exercise) => buildExerciseItem(exercise)).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.multiSelect
          ? FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          widget.onExercisesSelected(selectedExercises);
          Navigator.pop(context);
        },
      )
          : null,
    );
  }
}