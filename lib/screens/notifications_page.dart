import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> notifications = [
    'Your policy is due for renewal on 2023-12-01.',
    'Claim #12345 has been approved.',
    'New insurance plan available!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(notifications[index]),
              leading: Icon(Icons.notifications),
            ),
          ).animate().fadeIn(delay: (index * 200).ms);
        },
      ),
    );
  }
}