import 'package:bulkfitness/components/my_appbar.dart';
import 'package:bulkfitness/components/my_square.dart';
import 'package:flutter/material.dart';
import 'challenge_detail_page.dart';


class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final List<Map<String, dynamic>> _challenges = [
  {
  'title': 'Push Ups',
  'description': 'Apr 1 to June 15,2024',
  'imagePath': 'lib/images/apple.png',
  'isJoined': false,
  'detailedDescription': 'Challenge yourself to do push-ups every day for 30 days. Start with a number you are comfortable with and gradually increase. This challenge will help improve your upper body strength and endurance.',
},
{
'title': 'Plank-ton',
'description': 'Apr 3 to June 17,2024',
'imagePath': 'lib/images/apple.png',
'isJoined': false,
'detailedDescription': 'Hold a plank position for a set time each day, gradually increasing the duration. This challenge targets your core muscles and improves overall stability.',
},
{
'title': 'Sit-Ups',
'description': 'Apr 7 to June 30,2024',
'imagePath': 'lib/images/apple.png',
'isJoined': false,
'detailedDescription': 'Commit to doing a set number of sit-ups daily. This challenge will strengthen your core and improve your abdominal muscles.',
},
];

void _navigateToChallengeDetail(int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChallengeDetailPage(
        title: _challenges[index]['title'],
        description: _challenges[index]['description'],
        imagePath: _challenges[index]['imagePath'],
        isJoined: _challenges[index]['isJoined'],
        onJoinStatusChanged: (bool newStatus) {
          setState(() {
            _challenges[index]['isJoined'] = newStatus;
          });
        },
      ),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const MyAppbar(),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Challenges",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _challenges.length,
            itemBuilder: (context, index) {
              return MySquare(
                title: _challenges[index]['title'],
                description: _challenges[index]['description'],
                imagePath: _challenges[index]['imagePath'],
                onPressed: () => _navigateToChallengeDetail(index),
                isJoined: _challenges[index]['isJoined'],
              );
            },
          ),
        ),
      ],
    ),
  );
}
}