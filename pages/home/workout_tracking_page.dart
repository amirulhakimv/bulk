import 'package:bulkfitness/components/my_add_set.dart';
import 'package:bulkfitness/pages/home/exercise_library_page.dart';
import 'package:flutter/material.dart';
import 'package:bulkfitness/components/my_appbar.dart';
import 'package:bulkfitness/components/my_add_discard.dart';
import 'package:bulkfitness/components/my_timer.dart';

class WorkoutTrackingPage extends StatefulWidget {
  const WorkoutTrackingPage({Key? key}) : super(key: key);

  @override
  _WorkoutTrackingPageState createState() => _WorkoutTrackingPageState();
}

class _WorkoutTrackingPageState extends State<WorkoutTrackingPage> {
  List<Map<String, dynamic>> exercises = [
    {
      'title': 'Bench Press',
      'icon': Icons.fitness_center,
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 50, 'reps': '6', 'multiplier': 'x'},
        {'set': 2, 'weight': 50, 'reps': '6', 'multiplier': 'x'},
        {'set': 3, 'weight': 50, 'reps': '4', 'multiplier': 'x'},
      ],
    },
    {
      'title': 'Shoulder Press',
      'icon': Icons.fitness_center,
      'sets': <Map<String, dynamic>>[
        {'set': 1, 'weight': 20, 'reps': '8', 'multiplier': 'x'},
        {'set': 2, 'weight': 20, 'reps': '8', 'multiplier': 'x'},
      ],
    },
  ];

  bool isRestTimerRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppbar(
        showBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: MyTimer(initialSeconds: 0, isWorkoutTimer: true),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return _buildExerciseSection(exercises[index]);
              },
            ),
          ),
          MyAddDiscard(
            onAddExercise: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseLibraryPage(
                    onExerciseSelected: (exercise) {
                      setState(() {
                        exercises.add(_addInitialSetToExercise(exercise));
                      });
                    },
                  ),
                ),
              );
            },
            onDiscardWorkout: () {
              Navigator.pop(context);
            },
            onRestTimerComplete: () {
              setState(() {
                isRestTimerRunning = false;
              });
            },
            isRestTimerRunning: isRestTimerRunning,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseSection(Map<String, dynamic> exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(exercise['icon'] as IconData, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              exercise['title'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                _showExerciseOptions(exercise);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text('Set', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('History', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Reps', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('kg', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...(exercise['sets'] as List<Map<String, dynamic>>).map((set) => MyAddSet(
              set: set,
              onComplete: (isCompleted) {
                setState(() {
                  isRestTimerRunning = isCompleted;
                });
              },
            )).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    (exercise['sets'] as List<Map<String, dynamic>>).add({
                      'set': (exercise['sets'] as List).length + 1,
                      'weight': 0,
                      'reps': '0',
                      'multiplier': 'x'
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Add Set'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _showExerciseOptions(Map<String, dynamic> exercise) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey, // Set the background color to grey
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white), // White icon color
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog when "Back" is pressed
                    },
                  ),
                  const Text(
                    'Back',
                    style: TextStyle(fontSize: 18, color: Colors.white), // White text color
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _swapExercise(exercise);
                },
                icon: const Icon(Icons.swap_horiz, color: Colors.white), // White icon color
                label: const Text('Swap Exercise', style: TextStyle(fontSize: 24, color: Colors.white)), // White text color
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    exercises.remove(exercise);
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Colors.white), // White icon color
                label: const Text('Delete Exercise', style: TextStyle(fontSize: 24, color: Colors.white)), // White text color
              ),
            ],
          ),
        );
      },
    );
  }



  void _swapExercise(Map<String, dynamic> oldExercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseLibraryPage(
          onExerciseSelected: (newExercise) {
            setState(() {
              int index = exercises.indexOf(oldExercise);
              exercises[index] = _addInitialSetToExercise(newExercise);
            });
          },
        ),
      ),
    );
  }

  Map<String, dynamic> _addInitialSetToExercise(Map<String, dynamic> exercise) {
    if (!exercise.containsKey('sets') || (exercise['sets'] as List).isEmpty) {
      exercise['sets'] = <Map<String, dynamic>>[
        {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'}
      ];
    }
    return exercise;
  }
}