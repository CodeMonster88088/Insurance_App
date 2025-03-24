import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Flutter Animate

class RewardsPage extends StatelessWidget {
  // Dummy rewards data
  final List<Map<String, dynamic>> rewards = [
    {
      'title': '10% Off Next Premium',
      'points': 200,
      'image': 'assets/images/reward1.png', // Ensure this image exists
    },
    {
      'title': '\$5 Gift Card',
      'points': 300,
      'image': 'assets/images/reward2.png', // Ensure this image exists
    },
    {
      'title': 'Free Health Checkup',
      'points': 500,
      'image': 'assets/images/reward3.png', // Ensure this image exists
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Title
            Text(
              'Earn Rewards!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms), // Fade-in animation
            SizedBox(height: 20),

            // Description
            Text(
              'Collect points and redeem them for discounts and gifts.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),

            // Points Card
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Your Points',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '500', // Example points value
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.5, // Example progress (50%)
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You need 250 more points to unlock the next reward.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().scale(delay: 300.ms), // Scale animation
            SizedBox(height: 20),

            // Rewards Catalog
            Text(
              'Available Rewards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...rewards.map((reward) => _buildRewardItem(context, reward)).toList(),
          ],
        ),
      ),
    );
  }

  // Reward Item Widget
  Widget _buildRewardItem(BuildContext context, Map<String, dynamic> reward) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: ListTile(
        leading: Image.asset(
          reward['image'], // Use the image path from the rewards list
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          reward['title'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${reward['points']} points',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Add functionality to redeem the reward
            _showRedeemDialog(context, reward); // Pass the reward to the dialog
          },
          child: Text('Redeem'),
        ),
      ),
    );
  }

  // Helper method to show a redeem dialog
  void _showRedeemDialog(BuildContext context, Map<String, dynamic> reward) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Redeem Reward'),
          content: Text('Are you sure you want to redeem "${reward['title']}" for ${reward['points']} points?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add functionality to redeem the reward
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reward redeemed successfully!'),
                  ),
                );
              },
              child: Text('Redeem'),
            ),
          ],
        );
      },
    );
  }
}