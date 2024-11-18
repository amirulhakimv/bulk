import 'package:flutter/material.dart';

class PostInteractionLogic {
  static void toggleLike(List<Map<String, dynamic>> posts, int postIndex, String userId) {
    final post = posts[postIndex];
    final likedBy = post['likedBy'] as Set<String>;
    if (likedBy.contains(userId)) {
      likedBy.remove(userId);
      post['likes'] = (post['likes'] as int) - 1;
    } else {
      likedBy.add(userId);
      post['likes'] = (post['likes'] as int) + 1;
    }
  }

  static void addComment(List<Map<String, dynamic>> posts, int postIndex, String comment) {
    final post = posts[postIndex];
    final comments = post['comments'] as List<dynamic>;
    comments.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'username': 'CurrentUser',
      'text': comment,
      'likes': 0,
      'likedBy': <String>{},
      'replies': [],
    });
  }

  static String formatLikes(int likes) {
    if (likes >= 1000000) {
      return '${(likes / 1000000).toStringAsFixed(1)}M';
    } else if (likes >= 1000) {
      return '${(likes / 1000).toStringAsFixed(1)}K';
    } else {
      return likes.toString();
    }
  }

  static Widget buildCommentTile(
      Map<String, dynamic> comment,
      int postIndex,
      int commentIndex,
      List<Map<String, dynamic>> posts,
      Function(String, String, bool) onReply,
      StateSetter setState,
      Function(String) onViewProfile,
      ) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => onViewProfile(comment['username']),
        child: CircleAvatar(
          backgroundImage: AssetImage('lib/images/default_avatar.png'),
        ),
      ),
      title: GestureDetector(
        onTap: () => onViewProfile(comment['username']),
        child: Text(
          comment['username'],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment['text'], style: TextStyle(color: Colors.white)),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  onReply(comment['username'], comment['id'], false);
                },
                child: Text('Reply', style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    toggleLike(posts, postIndex, 'currentUserId');
                  });
                },
                child: Text(
                  'Like (${formatLikes(comment['likes'])})',
                  style: TextStyle(
                    color: (comment['likedBy'] as Set<String>).contains('currentUserId')
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          ...buildReplies(comment['replies'] as List<dynamic>, postIndex, commentIndex, posts, onReply, setState, onViewProfile),
        ],
      ),
    );
  }

  static List<Widget> buildReplies(
      List<dynamic> replies,
      int postIndex,
      int commentIndex,
      List<Map<String, dynamic>> posts,
      Function(String, String, bool) onReply,
      StateSetter setState,
      Function(String) onViewProfile,
      ) {
    return replies.asMap().entries.map((entry) {
      final int replyIndex = entry.key;
      final Map<String, dynamic> reply = entry.value;
      return buildReplyTile(reply, postIndex, commentIndex, replyIndex, posts, onReply, setState, onViewProfile);
    }).toList();
  }

  static Widget buildReplyTile(
      Map<String, dynamic> reply,
      int postIndex,
      int commentIndex,
      int replyIndex,
      List<Map<String, dynamic>> posts,
      Function(String, String, bool) onReply,
      StateSetter setState,
      Function(String) onViewProfile,
      ) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => onViewProfile(reply['username']),
        child: CircleAvatar(
          backgroundImage: AssetImage('lib/images/default_avatar.png'),
          radius: 15,
        ),
      ),
      title: GestureDetector(
        onTap: () => onViewProfile(reply['username']),
        child: Text(
          reply['username'],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reply['text'], style: TextStyle(color: Colors.white)),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  onReply(reply['username'], reply['id'], true);
                },
                child: Text('Reply', style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    toggleLike(posts, postIndex, 'currentUserId');
                  });
                },
                child: Text(
                  'Like (${formatLikes(reply['likes'])})',
                  style: TextStyle(
                    color: (reply['likedBy'] as Set<String>).contains('currentUserId')
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildCommentInput(
      int postIndex,
      List<Map<String, dynamic>> posts,
      TextEditingController controller,
      String replyingTo,
      String replyingToId,
      bool isReplyToReply,
      StateSetter setState,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: replyingTo.isNotEmpty ? 'Reply to ${replyingTo}...' : 'Add a comment...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  if (replyingTo.isEmpty) {
                    addComment(posts, postIndex, controller.text);
                  } else {
                    final comments = posts[postIndex]['comments'] as List<dynamic>;
                    if (isReplyToReply) {
                      for (var comment in comments) {
                        final replies = comment['replies'] as List<dynamic>;
                        final replyIndex = replies.indexWhere((reply) => reply['id'] == replyingToId);
                        if (replyIndex != -1) {
                          replies.add({
                            'id': DateTime.now().millisecondsSinceEpoch.toString(),
                            'username': 'CurrentUser',
                            'text': controller.text,
                            'likes': 0,
                            'likedBy': <String>{},
                          });
                          break;
                        }
                      }
                    } else {
                      final commentIndex = comments.indexWhere((comment) => comment['id'] == replyingToId);
                      if (commentIndex != -1) {
                        final replies = comments[commentIndex]['replies'] as List<dynamic>;
                        replies.add({
                          'id': DateTime.now().millisecondsSinceEpoch.toString(),
                          'username': 'CurrentUser',
                          'text': controller.text,
                          'likes': 0,
                          'likedBy': <String>{},
                        });
                      }
                    }
                  }
                });
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}