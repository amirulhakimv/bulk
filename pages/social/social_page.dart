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
  final List<Map<String, dynamic>> discoverPosts = [
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

  void toggleLike(int index, String userId) {
    setState(() {
      if (posts[index]['likedBy'].contains(userId)) {
        posts[index]['likedBy'].remove(userId);
        posts[index]['likes'] = (posts[index]['likes'] as int) - 1;
      } else {
        posts[index]['likedBy'].add(userId);
        posts[index]['likes'] = (posts[index]['likes'] as int) + 1;
      }
    });
  }

  void addComment(int postIndex, String commentText) {
    setState(() {
      posts[postIndex]['comments'].add({
        'id': '${posts[postIndex]['comments'].length + 1}',
        'username': 'CurrentUser',
        'text': commentText,
        'likes': 0,
        'likedBy': <String>{},
        'replies': [],
      });
    });
  }

  void toggleCommentLike(int postIndex, int commentIndex, String userId) {
    setState(() {
      final comment = posts[postIndex]['comments'][commentIndex];
      if (comment['likedBy'].contains(userId)) {
        comment['likedBy'].remove(userId);
        comment['likes'] = (comment['likes'] as int) - 1;
      } else {
        comment['likedBy'].add(userId);
        comment['likes'] = (comment['likes'] as int) + 1;
      }
    });
  }

  void addReply(int postIndex, int commentIndex, String parentId, String replyText) {
    setState(() {
      final comment = posts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
      comment['replies'].add({
        'id': '${parentId}.${comment['replies'].length + 1}',
        'username': 'CurrentUser',
        'text': replyText,
        'likes': 0,
        'likedBy': <String>{},
      });
    });
  }

  void toggleReplyLike(int postIndex, int commentIndex, String parentId, String replyId, String userId) {
    setState(() {
      final comment = posts[postIndex]['comments'].firstWhere((c) => c['id'] == parentId);
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
          toggleCommentLike: toggleCommentLike,
          addComment: addComment,
          addReply: addReply,
          toggleReplyLike: toggleReplyLike,
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
                    onLike: () {},
                    onComment: (comment) {},
                    toggleCommentLike: toggleCommentLike,
                    addComment: addComment,
                    addReply: addReply,
                    toggleReplyLike: toggleReplyLike,
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