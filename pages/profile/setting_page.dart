import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppbar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Account Section
            const SectionTitle(title: 'Account'),
            SettingOption(
              icon: Icons.person,
              label: 'Profile',
              onTap: () {
                // Navigate to Profile page
              },
            ),
            SettingOption(
              icon: Icons.lock,
              label: 'Account',
              onTap: () {
                // Navigate to Account page
              },
            ),
            const SizedBox(height: 24),

            // Preferences Section
            const SectionTitle(title: 'Preferences'),
            SettingOption(
              icon: Icons.notifications,
              label: 'Notifications',
              onTap: () {
                // Navigate to Notifications settings
              },
            ),
            SettingOption(
              icon: Icons.color_lens,
              label: 'Theme',
              onTap: () {
                // Navigate to Theme settings
              },
            ),
            const SizedBox(height: 24),

            // Other Section
            const SectionTitle(title: 'Other'),
            SettingOption(
              icon: Icons.question_answer,
              label: 'FAQs',
              onTap: () {
                // Navigate to FAQs page
              },
            ),
            SettingOption(
              icon: Icons.info,
              label: 'About',
              onTap: () {
                // Navigate to About page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SettingOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SettingOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}