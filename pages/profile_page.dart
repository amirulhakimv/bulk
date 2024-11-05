import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppbar(),
      body: Center(
        child: Text("Profile Page",
          style: TextStyle(
              color: Colors.white),
        ),
      ),
    );
  }
}
