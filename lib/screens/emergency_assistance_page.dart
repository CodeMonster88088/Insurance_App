import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmergencyAssistancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Assistance'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            _buildEmergencyContact('Police', '911'),
            _buildEmergencyContact('Ambulance', '112'),
            _buildEmergencyContact('Fire Department', '101'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Request immediate assistance
              },
              child: Text('Request Assistance'),
            ).animate().scale(delay: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(name),
        subtitle: Text(number),
        trailing: Icon(Icons.call),
      ),
    ).animate().slideX(duration: 500.ms);
  }
}