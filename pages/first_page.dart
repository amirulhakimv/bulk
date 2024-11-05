import 'package:bulkfitness/pages/challenges_page.dart';
import 'package:bulkfitness/pages/counter_page.dart';
import 'package:bulkfitness/pages/home_page.dart';
import 'package:bulkfitness/pages/profile_page.dart';
import 'package:bulkfitness/pages/social_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
   FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
   // this keeps track of the current page to display
   int _selectedIndex = 2;

   // this method updates the new selected index
   void _navigateBottomBar (int index) {
     setState(() {
       _selectedIndex = index;
     });
   }

   final List _pages = [
     // challenges page
     ChallengesPage(),

     // counter page
     CounterPage(),

     // home page
     HomePage(),

     // social page
     SocialPage(),

     // profile page
     ProfilePage(),
   ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.black,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          items: [
            // challenges
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: 'Challenges',
            ),

            // counter
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Counter',
            ),

            // home
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            // social
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Social',
            ),

            // profile
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
