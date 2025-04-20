import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> faqs = [
    {
      'question': 'How do I file a claim?',
      'answer':
          'To file a claim, go to the Policies section, select your policy, and click "File Claim". Follow the instructions to submit your claim details.',
    },
    {
      'question': 'What payment methods do you accept?',
      'answer':
          'We accept credit/debit cards (Visa, MasterCard, Amex), bank transfers, and PayPal for premium payments.',
    },
    {
      'question': 'How can I update my personal information?',
      'answer':
          'You can update your personal information in the Profile section under "Personal Information".',
    },
    {
      'question': 'What is your cancellation policy?',
      'answer':
          'You can cancel your policy at any time. Partial refunds may be available depending on how long the policy was active.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Center'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search help articles...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showContactDialog(context),
                        icon: Icon(Icons.chat),
                        label: Text('Live Chat'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...faqs.map((faq) => _buildFAQItem(faq)).toList(),
            SizedBox(height: 24),
            Text(
              'Contact Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '1-800-555-1234',
              onTap: () => _showCallConfirmation(context),
            ),
            _buildDivider(),
            _buildContactOption(
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'support@insuranceapp.com',
              onTap: () => _showEmailDialog(context),
            ),
            _buildDivider(),
            _buildContactOption(
              icon: Icons.location_on,
              title: 'Visit Office',
              subtitle: '123 Insurance St, Anytown',
              onTap: () => _showMapDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return ExpansionTile(
      title: Text(
        faq['question'],
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(faq['answer']),
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 72);
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Our support team is available 24/7 to assist you.'),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Describe your issue',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Support request submitted')),
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showCallConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call Support'),
        content: Text('Call 1-800-555-1234 now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, you would launch the phone dialer here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Launching phone app...')),
              );
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Send an email to support@insuranceapp.com'),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Email sent to support')),
              );
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showMapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Our Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('123 Insurance St, Anytown, USA'),
            SizedBox(height: 20),
            Container(
              height: 200,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: Icon(Icons.map, size: 50, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, you would launch maps here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Launching maps...')),
              );
            },
            child: Text('Directions'),
          ),
        ],
      ),
    );
  }
}