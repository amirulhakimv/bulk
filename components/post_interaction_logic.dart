import 'package:flutter/material.dart';

class PostInteractionLogic {
  static void toggleLike(List<Map<String, dynamic>> posts, int index, String userId) {
    if (posts[index]['likedBy'].contains(userId)) {
      posts[index]['likedBy'].remove(userId);
      posts[index]['likes'] = (posts[index]['likes'] as int) - 1;
    } else {
      posts[index]['likedBy'].add(userId);
      posts[index]['likes'] = (posts[index]['likes'] as int) + 1;
    }
  }

  static void addComment(List<Map<String, dynamic>> posts, int postIndex, String commentText) {
    posts[postIndex]['comments'].add({
      'id': '${posts[postIndex]['comments'].length + 1}',
      'username': 'CurrentUser',
      'text': commentText,
      'likes': 0,
      'likedBy': <String>{},
      'replies': [],
    });
  }

  static String formatLikes(int likes) {
    if (likes >= 1000) {
      double k = likes / 1000;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}k';
    }
    return likes.toString();
  }

  static void toggleCommentLike(List<Map<String, dynamic>> posts, int postIndex, int commentIndex, String userId) {
    final comment = posts[postIndex]['comments'][commentIndex];
    if (comment['likedBy'].contains(userId)) {
      comment['likedBy'].remove(userId);
      comment['likes'] = (comment['likes'] as int) - 1;
    } else {
      comment['likedBy'].add(userId);
      comment['likes'] = (comment['likes'] as int) + 1;
    }
  }

  static void addReply(List<Map<String, dynamic>> posts, int postIndex, int commentIndex, String parentId, String replyText) {
    final comment = posts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
    comment['replies'].add({
      'id': '${parentId}.${comment['replies'].length + 1}',
      'username': 'CurrentUser',
      'text': replyText,
      'likes': 0,
      'likedBy': <String>{},
    });
  }

  static void toggleReplyLike(List<Map<String, dynamic>> posts, int postIndex, int commentIndex, String parentId, String replyId, String userId) {
    final comment = posts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
    final reply = comment['replies'].firstWhere((r) => r['id'] == replyId);
    if (reply['likedBy'].contains(userId)) {
      reply['likedBy'].remove(userId);
      reply['likes'] = (reply['likes'] as int) - 1;
    } else {
      reply['likedBy'].add(userId);
      reply['likes'] = (reply['likes'] as int) + 1;
    }
  }

  static Widget buildCommentTile(
      Map<String, dynamic> comment,
      int postIndex,
      int commentIndex,
      List<Map<String, dynamic>> posts,
      Function(String, String, bool) onReply,
      Function setState,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(comment['username'][0].toUpperCase(),
                style: TextStyle(color: Colors.white)),
          ),
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: '${comment['username']} ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: comment['text']),
              ],
            ),
          ),
          subtitle: Row(
            children: [
              Text(formatLikes(comment['likes']) + ' likes',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () => onReply(comment['username'], comment['id'], false),
                child: Text('Reply', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              comment['likedBy'].contains('currentUserId')
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: comment['likedBy'].contains('currentUserId')
                  ? Colors.red
                  : Colors.white,
            ),
            onPressed: () {
              setState(() {
                toggleCommentLike(posts, postIndex, commentIndex, 'currentUserId');
              });
            },
          ),
        ),
        if (comment['replies'] != null && comment['replies'].isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              children: comment['replies'].map<Widget>((reply) {
                return buildReplyTile(
                  reply,
                  postIndex,
                  commentIndex,
                  comment['id'],
                  posts,
                  onReply,
                  setState,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  static Widget buildReplyTile(
      Map<String, dynamic> reply,
      int postIndex,
      int commentIndex,
      String parentId,
      List<Map<String, dynamic>> posts,
      Function(String, String, bool) onReply,
      Function setState,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 12,
        child: Text(reply['username'][0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
      title: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 14),
          children: [
            TextSpan(
              text: '${reply['username']} ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: reply['text']),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text(formatLikes(reply['likes']) + ' likes',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => onReply(reply['username'], parentId, true),
            child: Text('Reply', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          reply['likedBy'].contains('currentUserId')
              ? Icons.favorite
              : Icons.favorite_border,
          color: reply['likedBy'].contains('currentUserId')
              ? Colors.red
              : Colors.white,
          size: 16,
        ),
        onPressed: () {
          setState(() {
            toggleReplyLike(posts, postIndex, commentIndex, parentId, reply['id'], 'currentUserId');
          });
        },
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
      Function setState,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: replyingTo.isEmpty
                    ? 'Add a comment...'
                    : isReplyToReply
                    ? 'Reply to @$replyingTo...'
                    : 'Reply to $replyingTo...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  if (replyingTo.isEmpty) {
                    addComment(posts, postIndex, controller.text);
                  } else {
                    final commentIndex = posts[postIndex]['comments']
                        .indexWhere((c) => c['id'] == replyingToId);
                    if (commentIndex != -1) {
                      String replyText = isReplyToReply
                          ? '@$replyingTo ${controller.text}'
                          : controller.text;
                      addReply(posts, postIndex, commentIndex, replyingToId, replyText);
                    }
                  }
                  controller.clear();
                });
              }
            },
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}