import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For animations

class GalleriesPage extends StatelessWidget {
  // Dummy gallery data
  final List<Map<String, String>> galleries = [
    {
      'title': 'Travel Destinations',
      'image': 'assets/images/destination1.jpg', // Add image path
      'description': 'Explore popular travel destinations covered by your insurance.',
    },
    {
      'title': 'Health Tips',
      'image': 'assets/images/health_tips.jpg', // Add image path
      'description': 'Stay healthy and safe with these travel health tips.',
    },
    {
      'title': 'Wellness Activities',
      'image': 'assets/images/wellness.jpg', // Add image path
      'description': 'Practice wellness activities to stay fit during your travels.',
    },
    {
      'title': 'Emergency Assistance',
      'image': 'assets/images/emergency.jpg', // Add image path
      'description': 'Learn what to do in case of a medical emergency.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galleries'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Explore Galleries',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ).animate().fadeIn(duration: 500.ms), // Fade-in animation
            SizedBox(height: 16),

            // Description
            Text(
              'Discover helpful tips, destinations, and wellness activities to enhance your travel experience.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ).animate().fadeIn(delay: 200.ms), // Fade-in animation
            SizedBox(height: 32),

            // Gallery List
            ...galleries.map((gallery) => _buildGalleryItem(gallery)).toList(),
          ],
        ),
      ),
    );
  }

  // Gallery Item Widget
  Widget _buildGalleryItem(Map<String, String> gallery) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              gallery['image']!, // Add image path
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  gallery['title']!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ).animate().slideX(delay: 300.ms), // Slide-in animation
                SizedBox(height: 8),

                // Description
                Text(
                  gallery['description']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ).animate().fadeIn(delay: 400.ms), // Fade-in animation
                SizedBox(height: 16),

                // View More Button
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to view more details
                  },
                  child: Text('View More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ).animate().scale(delay: 500.ms), // Scale animation
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(delay: 200.ms); // Slide-up animation
  }
}