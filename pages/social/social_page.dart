import 'package:bulkfitness/components/my_appbar.dart';
import 'package:bulkfitness/components/my_chat_preview.dart';
import 'package:bulkfitness/components/my_group_suggestion.dart';
import 'package:bulkfitness/components/my_post_item.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for Following tab
  final List<Map<String, dynamic>> posts = [
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
  final List<Map<String, dynamic>> chats = [
    {
      'username': 'Kanye East',
      'lastMessage': 'Yo bro, when are we going to get a sesh together',
    },
    {
      'username': 'Ahmad Syerot',
      'lastMessage': 'weh kau tertinggal kunci Porsche dalam beg aku ni ha',
    },
    {
      'username': 'Kloppo',
      'lastMessage': "I'm running out of energy",
    },
    {
      'username': 'Chris Bumstead',
      'lastMessage': 'You will never get big like me bro if u keep skipping gym',
    },
    {
      'username': 'Zizan Razak',
      'lastMessage': 'otw',
    },
    {
      'username': 'AC Mizal',
      'lastMessage': 'peace yo!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return MyChatPreview(chat: chats[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            tabs: const [
              Tab(text: 'Following'),
              Tab(text: 'Discover'),
              Tab(text: 'Friends'),
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
    );
  }
}