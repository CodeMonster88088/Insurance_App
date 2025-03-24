import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.png'),
            ).animate().scale(delay: 300.ms),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            _buildProfileField('Email', 'john.doe@example.com'),
            _buildProfileField('Phone', '+1 (123) 456-7890'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile
              },
              child: Text('Edit Profile'),
            ).animate().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    ).animate().slideX(duration: 500.ms);
  }
}