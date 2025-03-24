import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlogPage extends StatelessWidget {
  final List<Map<String, dynamic>> blogPosts = [
    {
      'title': 'Top 5 Tips for Choosing the Right Insurance',
      'date': '2023-10-01',
    },
    {
      'title': 'Understanding Health Insurance Coverage',
      'date': '2023-09-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final post = blogPosts[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(post['title']),
              subtitle: Text('Published on ${post['date']}'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ).animate().fadeIn(delay: (index * 200).ms);
        },
      ),
    );
  }
}