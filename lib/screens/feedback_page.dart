import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'We Value Your Feedback!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ).animate().slideX(duration: 500.ms),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit feedback
              },
              child: Text('Submit Feedback'),
            ).animate().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }
}