import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; // Add a parameter to control the back button
  final bool showSettingButton;

  const MyAppbar({
    super.key,
    this.showBackButton = false,
    this.showSettingButton = false
  });

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
      child: SafeArea(
        child: Stack(
          children: [
            // Show back button if enabled
            if (showBackButton)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous page
                  },
                ),
              ),

            // show setting button if enabled
            if (showSettingButton)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the previous page
                    },
                  ),
                ),
              ),
            // Centered BULK text and icon
            Center(
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120); // Custom height
}
