// screens/health_tips_page.dart
import 'package:flutter/material.dart';

class HealthTipsPage extends StatelessWidget {
  // Sample list of health tips
  final List<Map<String, String>> healthTips = [
    {
      'title': 'Stay Hydrated',
      'description': 'Drink at least 8 glasses of water a day to keep your body hydrated and healthy.',
      'image': 'assets/images/hydration.jpg', // Ensure this matches the file name
    },
    {
      'title': 'Eat a Balanced Diet',
      'description': 'Include fruits, vegetables, lean proteins, and whole grains in your daily meals.',
      'image': 'assets/images/balanced_diet.jpg', // Typo here for testing
    },
    {
      'title': 'Exercise Regularly',
      'description': 'Engage in at least 30 minutes of moderate exercise daily to maintain fitness.',
      'image': 'assets/images/exercise.jpg',
    },
    {
      'title': 'Get Enough Sleep',
      'description': 'Aim for 7-9 hours of sleep per night to allow your body to recover and recharge.',
      'image': 'assets/images/sleep.jpg',
    },
    {
      'title': 'Manage Stress',
      'description': 'Practice mindfulness, meditation, or yoga to reduce stress levels.',
      'image': 'assets/images/stress_management.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    print('Number of health tips: ${healthTips.length}'); // Debugging
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: healthTips.isEmpty
          ? Center(child: Text('No health tips available.'))
          : ListView.builder(
              itemCount: healthTips.length,
              itemBuilder: (context, index) {
                return HealthTipCard(
                  title: healthTips[index]['title']!,
                  description: healthTips[index]['description']!,
                  image: healthTips[index]['image']!,
                );
              },
            ),
    );
  }
}

// Health Tip Card Widget
class HealthTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const HealthTipCard({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top of the card
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  height: 150,
                  child: Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          // Title and Description
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}