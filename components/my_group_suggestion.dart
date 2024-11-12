import 'package:flutter/material.dart';

class MyGroupSuggestion extends StatelessWidget {
  final Map<String, dynamic> group;

  const MyGroupSuggestion({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // Adjusted width
      margin: const EdgeInsets.symmetric(horizontal: 8), // Adjusted margin
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              group['image'],
              height: 100, // Adjusted height
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8), // Adjusted padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group Name
                Text(
                  group['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // Adjusted spacing

                // Members info with icon
                Row(
                  children: [
                    const Icon(
                      Icons.groups,
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        group['members'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Adjusted spacing

                // Join Group Button
                SizedBox(
                  width: double.infinity,
                  height: 30, // Fixed height for button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Join Group',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
