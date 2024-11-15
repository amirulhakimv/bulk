import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';
import '../../components/my_chat_preview.dart';
import '../../components/my_chat_screen.dart';
import '../../components/my_group_suggestion.dart';
import '../../components/my_post_item.dart';
import 'upload_post_page.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for Following tab
  List<Map<String, dynamic>> posts = [
    {
      'username': 'Sam Sulek',
      'category': 'Daily Motivation',
      'content': 'I need help! I have no motivation to go to the gym anymore. Someone please help me with something that could get me going!',
      'comments': [
        {
          'id': '1',
          'username': 'John Doe',
          'text': 'You got this! Remember why you started!',
          'likes': 5,
          'likedBy': <String>{'user1', 'user2'},
          'replies': [
            {
              'id': '1.1',
              'username': 'Sam Sulek',
              'text': 'Thanks for the encouragement!',
              'likes': 2,
              'likedBy': <String>{'user3'},
            }
          ]
        },
        {
          'id': '2',
          'username': 'Jane Smith',
          'text': 'Try setting small, achievable goals to build momentum.',
          'likes': 3,
          'likedBy': <String>{'user3'},
          'replies': []
        },
      ],
      'likes': 5,
      'likedBy': <String>{'user1', 'user2', 'user3', 'user4', 'user5'},
      'image': null,
    },
    {
      'username': 'Bilal Faruq',
      'category': null,
      'content': 'WE GO GYM!!!',
      'comments': [
        {
          'id': '3',
          'username': 'Gym Enthusiast',
          'text': 'That\'s the spirit!',
          'likes': 2,
          'likedBy': <String>{'user4', 'user5'},
          'replies': []
        },
      ],
      'likes': 10,
      'likedBy': <String>{'user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7', 'user8', 'user9', 'user10'},
      'image': 'lib/images/apple.png',
    },
  ];

  // Sample data for Discover tab
  List<Map<String, dynamic>> discoverPosts = [
    {
      'username': 'Aubrey Drake Graham',
      'description': 'Big Guns',
      'comments': [
        {
          'id': '4',
          'username': 'Fan123',
          'text': 'Looking strong, Drake!',
          'likes': 10,
          'likedBy': <String>{'user1', 'user2'},
          'replies': []
        },
      ],
      'likes': 1000,
      'likedBy': <String>{},
      'image': 'lib/images/splashscreen.png',
    },
  ];

  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Alpha Sigma',
      'members': 'Ahmad Syerot, 2k others',
      'image': 'lib/images/apple.png',
    },
    {
      'name': 'Mike N',
      'members': 'Drizzle, 1.2k others',
      'image': 'lib/images/apple.png',
    },
  ];

  // Sample data for Friends tab
  Map<String, Map<String, dynamic>> chatData = {
    'Kanye East': {
      'messages': [
        {'sender': 'Kanye East', 'text': 'Yo bro, when are we going to get a sesh together', 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 1)),
    },
    'Ahmad Syerot': {
      'messages': [
        {'sender': 'Ahmad Syerot', 'text': 'weh kau tertinggal kunci Porsche dalam beg aku ni ha', 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 2)),
    },
    'Kloppo': {
      'messages': [
        {'sender': 'Kloppo', 'text': "I'm running out of energy", 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 3)),
    },
    'Chris Bumstead': {
      'messages': [
        {'sender': 'Chris Bumstead', 'text': 'You will never get big like me bro if u keep skipping gym', 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 4)),
    },
    'Zizan Razak': {
      'messages': [
        {'sender': 'Zizan Razak', 'text': 'otw', 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 5)),
    },
    'AC Mizal': {
      'messages': [
        {'sender': 'AC Mizal', 'text': 'peace yo!', 'isMe': false},
      ],
      'unreadCount': 1,
      'lastOpened': DateTime.now().subtract(Duration(days: 6)),
    },
  };

  String _replyingTo = '';
  String _replyingToId = '';
  bool _isReplyToReply = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Call setState to update the UI when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {}); // Remove listener to prevent memory leaks
    _tabController.dispose();
    super.dispose();
  }

  String formatLikes(int likes) {
    if (likes >= 1000) {
      double k = likes / 1000;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}k';
    }
    return likes.toString();
  }

  void addNewPost(Map<String, dynamic> newPost) {
    setState(() {
      newPost['comments'] = [];
      newPost['likes'] = 0;
      newPost['likedBy'] = <String>{};
      newPost['category'] = null; // Set category to null for posts from the 'following' tab
      posts.insert(0, newPost); // Insert the new post at the top of the list
    });
  }

  void updateLastMessage(String username, String message) {
    setState(() {
      chatData[username]!['messages'].add({'sender': 'Me', 'text': message, 'isMe': true});
      chatData[username]!['unreadCount'] = 0;
      chatData[username]!['lastOpened'] = DateTime.now();
      // Move the updated chat to the top of the list
      final updatedChat = chatData.remove(username)!;
      chatData = {username: updatedChat, ...chatData};
    });
  }

  int getTotalUnreadMessages() {
    return chatData.values.fold(0, (sum, chat) => sum + (chat['unreadCount'] as int));
  }

  void toggleLike(int index, String userId, {bool isDiscoverPost = false}) {
    setState(() {
      final targetPosts = isDiscoverPost ? discoverPosts : posts;
      if (targetPosts[index]['likedBy'].contains(userId)) {
        targetPosts[index]['likedBy'].remove(userId);
        targetPosts[index]['likes'] = (targetPosts[index]['likes'] as int) - 1;
      } else {
        targetPosts[index]['likedBy'].add(userId);
        targetPosts[index]['likes'] = (targetPosts[index]['likes'] as int) + 1;
      }
    });
  }

  void addComment(int postIndex, String commentText, {bool isDiscoverPost = false}) {
    setState(() {
      final targetPosts = isDiscoverPost ? discoverPosts : posts;
      targetPosts[postIndex]['comments'].add({
        'id': '${targetPosts[postIndex]['comments'].length + 1}',
        'username': 'CurrentUser',
        'text': commentText,
        'likes': 0,
        'likedBy': <String>{},
        'replies': [],
      });
    });
  }

  void _showCommentsDialog(BuildContext context, List<dynamic> comments, int postIndex, {bool isDiscoverPost = false}) {
    final TextEditingController _commentController = TextEditingController();
    _replyingTo = '';
    _replyingToId = '';
    _isReplyToReply = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
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
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return _buildCommentTile(
                                comments[index],
                                postIndex,
                                index,
                                setModalState,
                                    (username, parentId, isReplyToReply) {
                                  setModalState(() {
                                    _replyingTo = username;
                                    _replyingToId = parentId;
                                    _isReplyToReply = isReplyToReply;
                                  });
                                },
                                isDiscoverPost: isDiscoverPost,
                              );
                            },
                          ),
                        ),
                        _buildCommentInput(
                          postIndex,
                          setModalState,
                          _commentController,
                          isDiscoverPost: isDiscoverPost,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCommentTile(
      Map<String, dynamic> comment,
      int postIndex,
      int commentIndex,
      StateSetter setModalState,
      Function(String, String, bool) onReply,
      {bool isDiscoverPost = false}
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
              setModalState(() {
                toggleCommentLike(postIndex, commentIndex, 'currentUserId', isDiscoverPost: isDiscoverPost);
              });
            },
          ),
        ),
        if (comment['replies'] != null && comment['replies'].isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              children: comment['replies'].map<Widget>((reply) {
                return _buildReplyTile(
                  reply,
                  postIndex,
                  commentIndex,
                  comment['id'],
                  setModalState,
                  onReply,
                  isDiscoverPost: isDiscoverPost,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildReplyTile(
      Map<String, dynamic> reply,
      int postIndex,
      int commentIndex,
      String parentId,
      StateSetter setModalState,
      Function(String, String, bool) onReply,
      {bool isDiscoverPost = false}
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
          setModalState(() {
            toggleReplyLike(postIndex, commentIndex, parentId, reply['id'], 'currentUserId', isDiscoverPost: isDiscoverPost);
          });
        },
      ),
    );
  }

  Widget _buildCommentInput(
      int postIndex,
      StateSetter setModalState,
      TextEditingController controller,
      {bool isDiscoverPost = false}
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
                hintText: _replyingTo.isEmpty
                    ? 'Add a comment...'
                    : _isReplyToReply
                    ? 'Reply to @$_replyingTo...'
                    : 'Reply to $_replyingTo...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setModalState(() {
                  if (_replyingTo.isEmpty) {
                    addComment(postIndex, controller.text, isDiscoverPost: isDiscoverPost);
                  } else {
                    final targetPosts = isDiscoverPost ? discoverPosts : posts;
                    final commentIndex = targetPosts[postIndex]['comments']
                        .indexWhere((c) => c['id'] == _replyingToId);
                    if (commentIndex != -1) {
                      String replyText = _isReplyToReply
                          ? '@$_replyingTo ${controller.text}'
                          : controller.text;
                      addReply(postIndex, commentIndex, _replyingToId, replyText, isDiscoverPost: isDiscoverPost);
                    }
                  }
                  controller.clear();
                  _replyingTo = '';
                  _replyingToId = '';
                  _isReplyToReply = false;
                });
              }
            },
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void toggleCommentLike(int postIndex, int commentIndex, String userId, {bool isDiscoverPost = false}) {
    setState(() {
      final targetPosts = isDiscoverPost ? discoverPosts : posts;
      final comment = targetPosts[postIndex]['comments'][commentIndex];
      if (comment['likedBy'].contains(userId)) {
        comment['likedBy'].remove(userId);
        comment['likes'] = (comment['likes'] as int) - 1;
      } else {
        comment['likedBy'].add(userId);
        comment['likes'] = (comment['likes'] as int) + 1;
      }
    });
  }

  void addReply(int postIndex, int commentIndex, String parentId, String replyText, {bool isDiscoverPost = false}) {
    setState(() {
      final targetPosts = isDiscoverPost ? discoverPosts : posts;
      final comment = targetPosts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
      comment['replies'].add({
        'id': '${parentId}.${comment['replies'].length + 1}',
        'username': 'CurrentUser',
        'text': replyText,
        'likes': 0,
        'likedBy': <String>{},
      });
    });
  }

  void toggleReplyLike(int postIndex, int commentIndex, String parentId, String replyId, String userId, {bool isDiscoverPost = false}) {
    setState(() {
      final targetPosts = isDiscoverPost ? discoverPosts : posts;
      final comment = targetPosts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
      final reply = comment['replies'].firstWhere((r) => r['id'] == replyId);
      if (reply['likedBy'].contains(userId)) {
        reply['likedBy'].remove(userId);
        reply['likes'] = (reply['likes'] as int) - 1;
      } else {
        reply['likedBy'].add(userId);
        reply['likes'] = (reply['likes'] as int) + 1;
      }
    });
  }

  Widget _buildFollowingTab() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return MyPostItem(
          post: posts[index],
          postIndex: index,
          onLike: () => toggleLike(index, 'currentUserId'),
          onComment: (comment) => addComment(index, comment),
          onViewComments: _showCommentsDialog,
          formatLikes: formatLikes,
        );
      },
    );
  }

  Widget _buildDiscoverTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  discoverPosts.map((post) => MyPostItem(
                    post: post,
                    isDiscoverPost: true,
                    postIndex: discoverPosts.indexOf(post),
                    onLike: () => toggleLike(discoverPosts.indexOf(post), 'currentUserId', isDiscoverPost: true),
                    onComment: (comment) => addComment(discoverPosts.indexOf(post), comment, isDiscoverPost: true),
                    onViewComments: (context, comments, index) => _showCommentsDialog(context, comments, index, isDiscoverPost: true),
                    formatLikes: formatLikes,
                  )).toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(color: Colors.grey, height: 1),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Suggested Groups',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return MyGroupSuggestion(group: groups[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendsTab() {
    return ListView.builder(
      itemCount: chatData.length,
      itemBuilder: (context, index) {
        final username = chatData.keys.elementAt(index);
        final chat = chatData[username]!;
        final messages = chat['messages'] as List<Map<String, dynamic>>;
        final lastMessage = messages.last;
        final unreadCount = chat['unreadCount'] as int;
        final lastOpened = chat['lastOpened'] as DateTime;
        return MyChatPreview(
          chat: {
            'username': username,
            'lastMessage': lastMessage['text'] as String,
            'isLastMessageMine': lastMessage['isMe'] as bool,
            'unreadCount': unreadCount,
            'lastOpened': lastOpened,
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyChatScreen(
                  username: username,
                  onMessageSent: updateLastMessage,
                  initialMessages: messages,
                ),
              ),
            ).then((_) {
              setState(() {
                chatData[username]!['unreadCount'] = 0;
                chatData[username]!['lastOpened'] = DateTime.now();
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalUnreadMessages = getTotalUnreadMessages();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyAppbar(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Following'),
              Tab(text: 'Discover'),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Friends'),
                    if (totalUnreadMessages > 0)
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          totalUnreadMessages.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFollowingTab(),
                _buildDiscoverTab(),
                _buildFriendsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPostPage(
                onPostSubmitted: addNewPost,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}