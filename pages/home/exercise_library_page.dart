import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';

class ExerciseLibraryPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onExerciseSelected;

  const ExerciseLibraryPage({Key? key, required this.onExerciseSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> exercises = [
      {
        'title': 'Bench Press',
        'icon': Icons.fitness_center,
        'sets': <Map<String, dynamic>>[
          {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
        ],
      },
      {
        'title': 'Squat',
        'icon': Icons.fitness_center,
        'sets': <Map<String, dynamic>>[
          {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
        ],
      },
      {
        'title': 'Deadlift',
        'icon': Icons.fitness_center,
        'sets': <Map<String, dynamic>>[
          {'set': 1, 'weight': 0, 'reps': '0', 'multiplier': 'x'},
        ],
      },
    ];

    return Scaffold(
      appBar: const MyAppbar(
        showBackButton: true,
      ), // Using custom app bar
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Spacing below the app bar
            const Text(
              'Exercise Library',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Spacing below the title
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      title: Text(
                        exercises[index]['title'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      leading: Icon(
                        exercises[index]['icon'] as IconData,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        onExerciseSelected(exercises[index]);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
