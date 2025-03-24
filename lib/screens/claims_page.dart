import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ClaimsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claims'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to file a new claim
              },
              child: Text('File a New Claim'),
            ).animate().scale(delay: 300.ms),
            SizedBox(height: 20),
            Text(
              'Claim History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text('Claim #${index + 1}'),
                    subtitle: Text('Status: Pending'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ).animate().slideX(delay: (index * 200).ms);
              },
            ),
          ],
        ),
      ),
    );
  }
}