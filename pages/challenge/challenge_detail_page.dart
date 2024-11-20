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
      appBar: MyAppbar(
        showBackButton: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Challenge Icon
                Center(
                  child: Image.asset(
                    widget.imagePath,
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),

                // Challenge Title
                Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Date Range
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Goal
                Row(
                  children: const [
                    Icon(Icons.track_changes, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Complete 1000 push-ups",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Badge
                Row(
                  children: const [
                    Icon(Icons.emoji_events, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Earn a digital finisher's badge",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Overview Section
                const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Push yourself to complete 1000 push-ups over the course of a week. Break it down however you like!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Rules Section
                const Text(
                  "Rules and Guidelines",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• Push ups must be done with proper form.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "• You can do them in sets throughout the week.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "• Log your pushups daily in the app.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Join Button
                Center(
                  child: ElevatedButton(
                    onPressed: _toggleJoinStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isJoined ? Colors.red : Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(180, 40),
                    ),
                    child: Text(
                      _isJoined ? "Leave" : "Join",
                      style: const TextStyle(
                        fontSize: 14,
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
    );
  }
}