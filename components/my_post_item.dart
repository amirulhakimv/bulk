import 'package:flutter/material.dart';

class MyPostItem extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isDiscoverPost;

  const MyPostItem({
    Key? key,
    required this.post,
    this.isDiscoverPost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isDiscoverPost
                        ? post['username']
                        : '${post['username']} > ${post['category']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isDiscoverPost)
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Follow'),
                  ),
              ],
            ),
          ),
          if (post['content'] != null && !isDiscoverPost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post['content'],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          if (post['image'] != null) ...[
            const SizedBox(height: 8),
            Image.network(
              post['image'],
              width: double.infinity,
              height: isDiscoverPost ? 300 : 200,
              fit: BoxFit.cover,
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${post['comments']} comments',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          if (!isDiscoverPost) const Divider(color: Colors.grey, height: 1),
        ],
      ),
    );
  }
}