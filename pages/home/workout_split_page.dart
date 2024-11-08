import 'package:bulkfitness/components/my_appbar.dart';
import 'package:bulkfitness/components/my_workout_card.dart';
import 'package:flutter/material.dart';

class WorkoutSplitPage extends StatefulWidget {
  const WorkoutSplitPage({Key? key}) : super(key: key);

  @override
  _WorkoutSplitPageState createState() => _WorkoutSplitPageState();
}

class _WorkoutSplitPageState extends State<WorkoutSplitPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  Widget _buildMySplitTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MyWorkoutCard(
            title: 'Push Day',
            exercises: 'Bench Press, Shoulder Press, Pec Fly,\nLateral Raise, Tricep Pushdown',
            onTap: () {
              // Navigate to workout details
            },
          ),
          MyWorkoutCard(
            title: 'Pull Day',
            exercises: 'Deadlift, Lat Pulldown, Seated Cable\nRow, Dumbbell Bicep Curl',
            onTap: () {
              // Navigate to workout details
            },
          ),
          MyWorkoutCard(
            title: 'Leg Day',
            exercises: 'Squat, Bulgarian Split Squat, Seated\nLeg Curl, Leg Extension, Calf Raises',
            onTap: () {
              // Navigate to workout details
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle create new routine
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Create New Routine'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return const Center(
      child: Text(
        'Search functionality coming soon',
        style: TextStyle(color: Colors.white),
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