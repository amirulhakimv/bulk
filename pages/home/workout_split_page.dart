import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'create_new_routine_page.dart';

class WorkoutSplitPage extends StatefulWidget {
  const WorkoutSplitPage({Key? key}) : super(key: key);

  @override
  _WorkoutSplitPageState createState() => _WorkoutSplitPageState();
}

class _WorkoutSplitPageState extends State<WorkoutSplitPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, bool> expandedState = {
    'PPL': false,
    'Bro Split': false,
    'Upper / Lower': false,
  };

  List<Map<String, dynamic>> mySplits = [];
  List<Map<String, dynamic>> addedSplits = [];

  final Map<String, List<Map<String, String>>> workoutData = {
    'PPL': [
      {
        'title': 'Push Day 1',
        'exercises': 'Bench Press, Shoulder Press,\nPec Fly, Lateral Raise, Tricep Pushdown',
      },
      {
        'title': 'Pull Day 1',
        'exercises': 'Deadlift, Lat Pulldown, Seated\nCable Row, Dumbbell Bicep Curl',
      },
      {
        'title': 'Leg Day 1',
        'exercises': 'Squat, Bulgarian Split Squat,\nSeated Leg Curl, Leg Extension, Calf Raises',
      },
    ],
    'Bro Split': [
      {
        'title': 'Chest Day',
        'exercises': 'Bench Press, Incline Dumbbell Press,\nCable Flyes, Pushups',
      },
      {
        'title': 'Back Day',
        'exercises': 'Deadlifts, Pull-ups, Bent Over Rows,\nLat Pulldowns',
      },
      {
        'title': 'Leg Day',
        'exercises': 'Squats, Leg Press, Romanian Deadlifts,\nLeg Extensions, Calf Raises',
      },
      {
        'title': 'Shoulder Day',
        'exercises': 'Military Press, Lateral Raises,\nFront Raises, Face Pulls',
      },
      {
        'title': 'Arm Day',
        'exercises': 'Barbell Curls, Tricep Pushdowns,\nHammer Curls, Skull Crushers',
      },
    ],
    'Upper / Lower': [
      {
        'title': 'Upper Day 1',
        'exercises': 'Bench Press, Rows, Overhead Press,\nLat Pulldowns, Bicep Curls, Tricep Extensions',
      },
      {
        'title': 'Lower Day 1',
        'exercises': 'Squats, Romanian Deadlifts,\nLeg Press, Leg Curls, Calf Raises',
      },
      {
        'title': 'Upper Day 2',
        'exercises': 'Incline Press, Pull-ups, Lateral Raises,\nFace Pulls, Hammer Curls, Tricep Pushdowns',
      },
      {
        'title': 'Lower Day 2',
        'exercises': 'Deadlifts, Front Squats,\nLunges, Leg Extensions, Hip Thrusts',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildWorkoutCard(Map<String, dynamic> workout, {bool isEditable = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  workout['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              workout['exercises'] is List
                  ? (workout['exercises'] as List).map((e) => e['title']).join(', ')
                  : workout['exercises'],
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
            if (isEditable)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _editRoutine(workout),
                  child: const Text('Edit', style: TextStyle(color: Colors.blue)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _editRoutine(Map<String, dynamic> routine) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNewRoutinePage(existingRoutine: routine),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        int index = mySplits.indexOf(routine);
        if (index != -1) {
          mySplits[index] = result;
        }
      });
    }
  }

  Widget _buildMySplitTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Split',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...mySplits.map((split) => _buildWorkoutCard(split, isEditable: true)),
          if (mySplits.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No custom workouts added yet.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'Added Split',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...addedSplits.map((split) => _buildWorkoutCard(split)),
          if (addedSplits.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No workouts added from search yet.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateNewRoutinePage()),
                  );
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      mySplits.add(result);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create New Routine',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pick Your Split',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Don\'t know what to do for the day?\nTake a look at these routines created by other users',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ...workoutData.entries.map((entry) => _buildExpandableWorkout(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildExpandableWorkout(String title, List<Map<String, String>> workouts) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              expandedState[title] = !(expandedState[title] ?? false);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  expandedState[title] ?? false
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        if (expandedState[title] ?? false)
          Column(
            children: workouts.map((workout) => _buildWorkoutItem(workout)).toList(),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildWorkoutItem(Map<String, String> workout) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  workout['exercises']!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (!addedSplits.contains(workout)) {
                    addedSplits.add(workout);
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${workout['title']} added to Added Split')),
                );
              },
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppbar(
        showBackButton: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'My Split'),
              Tab(text: 'Search'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMySplitTab(),
                _buildSearchTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}