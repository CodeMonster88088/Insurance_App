import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'FAQs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            _buildFAQ('How do I file a claim?', 'Go to the Claims page and follow the instructions.'),
            _buildFAQ('How do I renew my policy?', 'Visit the My Policies page and select the policy to renew.'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Open live chat or contact form
              },
              child: Text('Contact Support'),
            ).animate().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
      ),
    ).animate().slideX(duration: 500.ms);
  }
}