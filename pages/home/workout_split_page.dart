import 'package:flutter/material.dart';
import 'package:bulkfitness/components/my_appbar.dart';
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

  List<Map<String, dynamic>> allSplits = [];

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

  Widget _buildWorkoutCard(Map<String, dynamic> workout, int index) {
    return Dismissible(
      key: ValueKey(workout),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          allSplits.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${workout['title']} removed'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  allSplits.insert(index, workout);
                });
              },
            ),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: LongPressDraggable<Map<String, dynamic>>(
        data: workout,
        feedback: Material(
          elevation: 4.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: _buildWorkoutCardContent(workout, workout['isUserCreated'] == true),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: _buildWorkoutCardContent(workout, workout['isUserCreated'] == true),
        ),
        onDragStarted: () {
          // Optional: Add any logic you want to execute when dragging starts
        },
        onDragEnd: (details) {
          // Optional: Add any logic you want to execute when dragging ends
        },
        child: DragTarget<Map<String, dynamic>>(
          onWillAccept: (data) => data != null && data != workout,
          onAccept: (data) {
            setState(() {
              final fromIndex = allSplits.indexOf(data);
              final toIndex = allSplits.indexOf(workout);
              if (fromIndex != -1 && toIndex != -1) {
                final item = allSplits.removeAt(fromIndex);
                allSplits.insert(toIndex, item);
              }
            });
          },
          builder: (context, candidateData, rejectedData) {
            return _buildWorkoutCardContent(workout, workout['isUserCreated'] == true);
          },
        ),
      ),
    );
  }

  Widget _buildWorkoutCardContent(Map<String, dynamic> workout, bool isEditable) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: MediaQuery.of(context).size.width * 0.7,
        constraints: const BoxConstraints(minHeight: 80),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workout['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.drag_handle, color: Colors.grey[600], size: 20),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                workout['exercises'] is List
                    ? (workout['exercises'] as List).map((e) => e['title']).join(', ')
                    : workout['exercises'],
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isEditable)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _editRoutine(workout),
                    child: const Text('Edit', style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                ),
            ],
          ),
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
        int index = allSplits.indexOf(routine);
        if (index != -1) {
          allSplits[index] = result;
        }
      });
    }
  }

  Widget _buildMySplitTab() {
    return Scrollbar(
      thumbVisibility: true,
      thickness: 6,
      radius: Radius.circular(10),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'My Splits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...allSplits.asMap().entries.map((entry) => _buildWorkoutCard(entry.value, entry.key)),
            if (allSplits.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'No workouts added yet.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
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
                        result['isUserCreated'] = true;
                        allSplits.add(result);
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
                    'Create New Split',
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
      ),
    );
  }

  Widget _buildSearchTab() {
    return Scrollbar(
      thumbVisibility: true,
      thickness: 6,
      radius: Radius.circular(10),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Pick Your Split',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Don\'t know what to do for the day?\nTake a look at these routines created by other users',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ...workoutData.entries.map((entry) => _buildExpandableWorkout(entry.key, entry.value)),
          ],
        ),
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
                  if (!allSplits.contains(workout)) {
                    final newWorkout = Map<String, dynamic>.from(workout);
                    newWorkout['isUserCreated'] = false;
                    allSplits.add(newWorkout);
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${workout['title']} added to My Splits')),
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
              Tab(text: 'My Splits'),
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