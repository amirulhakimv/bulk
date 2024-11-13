import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onPressed;
  final bool isJoined;

  const MySquare({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onPressed,
    required this.isJoined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isJoined ? Colors.green : Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.black,
              ),
              child: Text(isJoined ? "Joined" : "Join"),
            ),
          ],
        ),
      ),
    );
  }
}