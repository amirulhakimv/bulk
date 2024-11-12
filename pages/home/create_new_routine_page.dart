import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';
import 'exercise_library_page.dart';

class CreateNewRoutinePage extends StatefulWidget {
  const CreateNewRoutinePage({Key? key}) : super(key: key);

  @override
  _CreateNewRoutinePageState createState() => _CreateNewRoutinePageState();
}

class _CreateNewRoutinePageState extends State<CreateNewRoutinePage> {
  final _routineNameController = TextEditingController();
  List<String> selectedExercises = [];

  @override
  void dispose() {
    _routineNameController.dispose();
    super.dispose();
  }

  void _navigateToExerciseLibrary() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseLibraryPage(
          onExerciseSelected: (exercise) {
            setState(() {
              selectedExercises.add(exercise['title']);
            });
          },
        ),
      ),
    );
  }

  void _saveRoutine() {
    if (_routineNameController.text.isNotEmpty && selectedExercises.isNotEmpty) {
      Navigator.pop(context, {
        'title': _routineNameController.text,
        'exercises': selectedExercises.join(', '),
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a routine name and add at least one exercise')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const MyAppbar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _routineNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Routine Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selected Exercises:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: selectedExercises.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      selectedExercises[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          selectedExercises.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _navigateToExerciseLibrary,
                child: const Text('Add Exercise'),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _saveRoutine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Save Routine',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}