import 'package:flutter/material.dart';

class MyPostItem extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isDiscoverPost;
  final VoidCallback onLike;
  final Function(String) onComment;
  final Function(BuildContext, List<dynamic>, int) onViewComments;
  final int postIndex;

  const MyPostItem({
    Key? key,
    required this.post,
    this.isDiscoverPost = false,
    required this.onLike,
    required this.onComment,
    required this.onViewComments,
    required this.postIndex,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['username'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (post['category'] != null)
                        Text(
                          post['category'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                    ],
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
            Image.asset(
              post['image'],
              width: double.infinity,
              height: isDiscoverPost ? 300 : 200,
              fit: BoxFit.cover,
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post['likedBy'].contains('currentUserId') ? Icons.favorite : Icons.favorite_border,
                        color: post['likedBy'].contains('currentUserId') ? Colors.red : Colors.white,
                      ),
                      onPressed: onLike,
                    ),
                    Text(
                      '${post['likes']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.white),
                      onPressed: () => onViewComments(context, post['comments'], postIndex),
                    ),
                    Text(
                      '${(post['comments'] as List).length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => onViewComments(context, post['comments'], postIndex),
                  child: Text(
                    'View all comments',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          if (!isDiscoverPost) const Divider(color: Colors.grey, height: 1),
        ],
      ),
    );
  }
}