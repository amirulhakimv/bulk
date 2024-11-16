import 'package:flutter/material.dart';
import 'package:bulkfitness/pages/challenge/challenges_page.dart';
import 'package:bulkfitness/pages/counter/counter_page.dart';
import 'package:bulkfitness/pages/home/home_page.dart';
import 'package:bulkfitness/pages/profile/profile_page.dart';
import 'package:bulkfitness/pages/social/social_page.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 2;

  // Add shared state for posts
  final List<Map<String, dynamic>> _sharedPosts = [];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Add method to handle new posts
  void _handleNewPost(Map<String, dynamic> newPost) {
    setState(() {
      _sharedPosts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      ChallengesPage(),
      CounterPage(),
      HomePage(),
      SocialPage(
        sharedPosts: _sharedPosts,
        onPostSubmitted: _handleNewPost,
      ),
      ProfilePage(
        posts: _sharedPosts,
        onPostSubmitted: _handleNewPost,
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.black,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Counter'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Social'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}