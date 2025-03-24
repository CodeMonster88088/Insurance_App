import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Program'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Refer a Friend and Earn Rewards!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            Text(
              'Share your referral code and get discounts on your next policy.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Your Referral Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'AMAN123',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().scale(delay: 300.ms),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Share referral code
              },
              child: Text('Share Referral Code'),
            ).animate().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }
}