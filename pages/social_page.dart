import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppbar(),
      body: Center(
        child: Text("Social Page",
          style: TextStyle(
              color: Colors.white),
        ),
      ),
    );
  }
}
