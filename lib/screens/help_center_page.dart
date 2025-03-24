import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  // Dummy FAQ data
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I file a claim?',
      'answer': 'To file a claim, go to the Claims section in the app and follow the instructions.',
    },
    {
      'question': 'What documents do I need for a claim?',
      'answer': 'You will need your policy number, medical bills, and any relevant receipts.',
    },
    {
      'question': 'How do I contact customer support?',
      'answer': 'You can contact us via email at support@yourinsurance.com or call +1 234 567 890.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            ...faqs.map((faq) => _buildFAQItem(faq)).toList(),

            // Contact Support Section
            SizedBox(height: 32),
            Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            _buildContactSupport(),

            // Emergency Assistance Section
            SizedBox(height: 32),
            Text(
              'Emergency Assistance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            _buildEmergencyAssistance(),

            // Feedback Section
            SizedBox(height: 32),
            Text(
              'Feedback & Suggestions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            _buildFeedbackForm(),
          ],
        ),
      ),
    );
  }

  // FAQ Item Widget
  Widget _buildFAQItem(Map<String, String> faq) {
    return ExpansionTile(
      title: Text(
        faq['question']!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            faq['answer']!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }

  // Contact Support Widget
  Widget _buildContactSupport() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue[800]),
              title: Text('Email Support'),
              subtitle: Text('support@yourinsurance.com'),
              onTap: () {
                // Add functionality to open email
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue[800]),
              title: Text('Call Support'),
              subtitle: Text('+1 234 567 890'),
              onTap: () {
                // Add functionality to make a call
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.chat, color: Colors.blue[800]),
              title: Text('Live Chat'),
              subtitle: Text('Available 24/7'),
              onTap: () {
                // Add functionality to open live chat
              },
            ),
          ],
        ),
      ),
    );
  }

  // Emergency Assistance Widget
  Widget _buildEmergencyAssistance() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.emergency, color: Colors.red),
              title: Text('Emergency Contact'),
              subtitle: Text('Call +1 911 for immediate assistance.'),
              onTap: () {
                // Add functionality to call emergency services
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.red),
              title: Text('Find Nearby Hospitals'),
              subtitle: Text('Locate the nearest hospitals.'),
              onTap: () {
                // Add functionality to open nearby hospitals page
              },
            ),
          ],
        ),
      ),
    );
  }

  // Feedback Form Widget
  Widget _buildFeedbackForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                hintText: 'Enter your feedback or suggestions...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality to submit feedback
              },
              child: Text('Submit Feedback'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}