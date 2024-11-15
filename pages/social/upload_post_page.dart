import 'package:bulkfitness/components/my_appbar.dart';
import 'package:flutter/material.dart';

class UploadPostPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onPostSubmitted;

  const UploadPostPage({super.key, required this.onPostSubmitted});

  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: MyAppbar(
        showBackButton: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView( // Allows scrolling when keyboard is visible
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title in the body section
              const Text(
                'Upload a Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Content input field
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey,
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),

              // Post button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Create a new post with just the content
                    Map<String, dynamic> newPost = {
                      'username': 'YourUsername', // Replace with actual username logic
                      'category': 'New Post', // You can make this dynamic if needed
                      'content': contentController.text,
                      'comments': '0',
                      'image': null,  // Optional: You can handle images if needed
                    };

                    onPostSubmitted(newPost); // Pass the new post to SocialPage
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
