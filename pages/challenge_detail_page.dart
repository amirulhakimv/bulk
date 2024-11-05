import 'package:flutter/material.dart';
import 'package:bulkfitness/components/my_appbar.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isJoined;
  final Function(bool) onJoinStatusChanged;

  const ChallengeDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isJoined,
    required this.onJoinStatusChanged,
  }) : super(key: key);

  @override
  _ChallengeDetailPageState createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  late bool _isJoined;

  @override
  void initState() {
    super.initState();
    _isJoined = widget.isJoined;
  }

  void _toggleJoinStatus() {
    setState(() {
      _isJoined = !_isJoined;
    });
    widget.onJoinStatusChanged(_isJoined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Challenge Icon
                  Center(
                    child: Image.asset(
                      widget.imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Challenge Title
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date Range
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Goal
                  Row(
                    children: const [
                      Icon(Icons.track_changes, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Complete 1000 push-ups",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Badge
                  Row(
                    children: const [
                      Icon(Icons.emoji_events, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Earn a digital finisher's badge",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Overview Section
                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Push yourself to complete 1000 push-ups over the course of a week. Break it down however you like!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Rules Section
                  const Text(
                    "Rules and Guidelines",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• Push ups must be done with proper form.",
                          style: TextStyle(fontSize: 16, color: Colors.black87)),
                      SizedBox(height: 5),
                      Text("• You can do them in sets throughout the week.",
                          style: TextStyle(fontSize: 16, color: Colors.black87)),
                      SizedBox(height: 5),
                      Text("• Log your pushups daily in the app.",
                          style: TextStyle(fontSize: 16, color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Join Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _toggleJoinStatus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isJoined ? Colors.red : Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(200, 50),
                      ),
                      child: Text(
                        _isJoined ? "Leave" : "Join",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}