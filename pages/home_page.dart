import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppbar(),
      body: Center(
        child: Text("Home Page",
          style: TextStyle(
              color: Colors.white),
        ),
      ),
    );
  }
}
