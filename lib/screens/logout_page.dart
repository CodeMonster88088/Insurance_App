import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Logout logic
              },
              child: Text('Logout'),
            ).animate().scale(delay: 300.ms),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Delete account logic
              },
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ).animate().fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}