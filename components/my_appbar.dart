import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Set custom height here
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white, // Color of the line
            width: 1.0,          // Thickness of the line
          ),
        ),
      ),
      child: SafeArea( // Ensures content is within safe bounds for devices with notches
        child: Center( // Center the entire content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: const [
              Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 4),
              Text(
                "BULK",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120); // Custom height
}
