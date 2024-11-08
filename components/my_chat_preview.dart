import 'package:flutter/material.dart';

class MyChatPreview extends StatelessWidget {
  final Map<String, dynamic> chat;

  const MyChatPreview({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            chat['username'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            chat['lastMessage'],
            style: const TextStyle(color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            // Handle chat tap
          },
        ),
        const Divider(color: Colors.grey, height: 1),
      ],
    );
  }
}