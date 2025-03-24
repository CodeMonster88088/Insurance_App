import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PolicyDetailsPage extends StatelessWidget {
  final String policyName;
  final String coverage;
  final double premium;
  final String benefits;

  PolicyDetailsPage({
    required this.policyName,
    required this.coverage,
    required this.premium,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Details'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              policyName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            _buildDetailCard('Coverage', coverage),
            _buildDetailCard('Premium', '\$$premium/month'),
            _buildDetailCard('Benefits', benefits),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to purchase page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text('Purchase Now'),
              ).animate().scale(delay: 300.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ).animate().slideX(duration: 500.ms);
  }
}