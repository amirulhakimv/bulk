import 'package:flutter/material.dart';

class MyCommentSection extends StatefulWidget {
  final List<dynamic> comments;
  final int postIndex;
  final Function(int, int, String) toggleCommentLike;
  final Function(int, String) addComment;
  final Function(int, int, String, String) addReply;
  final Function(int, int, String, String, String) toggleReplyLike;

  const MyCommentSection({
    Key? key,
    required this.comments,
    required this.postIndex,
    required this.toggleCommentLike,
    required this.addComment,
    required this.addReply,
    required this.toggleReplyLike,
  }) : super(key: key);

  @override
  _MyCommentSectionState createState() => _MyCommentSectionState();
}

class _MyCommentSectionState extends State<MyCommentSection> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: widget.comments.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.comments.length) {
                      return _buildCommentInput();
                    }
                    return _buildCommentTile(widget.comments[index], index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment, int commentIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(comment['username'][0].toUpperCase(), style: TextStyle(color: Colors.white)),
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
              Text('${comment['likes']} likes', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _showReplyInput(commentIndex, comment['id']);
                },
                child: Text('Reply', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${comment['likes']}', style: TextStyle(color: Colors.white)),
              IconButton(
                icon: Icon(
                  comment['likedBy'].contains('currentUserId') ? Icons.favorite : Icons.favorite_border,
                  color: comment['likedBy'].contains('currentUserId') ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  widget.toggleCommentLike(widget.postIndex, commentIndex, 'currentUserId');
                },
              ),
            ],
          ),
        ),
        if (comment['replies'] != null && comment['replies'].isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              children: comment['replies'].map<Widget>((reply) {
                return _buildReplyTile(reply, commentIndex, comment['id']);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildReplyTile(Map<String, dynamic> reply, int commentIndex, String parentId) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 12,
        child: Text(reply['username'][0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 10)),
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
          Text('${reply['likes']} likes', style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              _showReplyInput(commentIndex, parentId);
            },
            child: Text('Reply', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${reply['likes']}', style: TextStyle(color: Colors.white, fontSize: 12)),
          IconButton(
            icon: Icon(
              reply['likedBy'].contains('currentUserId') ? Icons.favorite : Icons.favorite_border,
              color: reply['likedBy'].contains('currentUserId') ? Colors.red : Colors.white,
              size: 16,
            ),
            onPressed: () {
              widget.toggleReplyLike(widget.postIndex, commentIndex, parentId, reply['id'], 'currentUserId');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                widget.addComment(widget.postIndex, _commentController.text);
                _commentController.clear();
              }
            },
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void _showReplyInput(int commentIndex, String parentId) {
    final TextEditingController _replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Reply to comment', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _replyController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Type your reply...',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Reply', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                if (_replyController.text.isNotEmpty) {
                  widget.addReply(widget.postIndex, commentIndex, parentId, _replyController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}