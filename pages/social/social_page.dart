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
      'comments': '120',
      'image': null,
    },
    {
      'username': 'Bilal Faruq',
      'category': 'Daily Motivation',
      'content': 'WE GO GYM!!!',
      'comments': '10',
      'image': 'lib/images/apple.png',
    },
  ];

  // Sample data for Discover tab
  final List<Map<String, dynamic>> discoverPosts = [
    {
      'username': 'Aubrey Drake Graham',
      'description': 'Big Guns',
      'comments': '420k',
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

  Widget _buildFollowingTab() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return MyPostItem(post: posts[index]);
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
                  discoverPosts.map((post) => MyPostItem(post: post, isDiscoverPost: true)).toList(),
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