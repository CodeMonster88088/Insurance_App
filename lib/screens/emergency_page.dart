import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  // Dummy emergency contact data
  final List<Map<String, String>> emergencyContacts = [
    {
      'name': 'Police',
      'number': '911',
    },
    {
      'name': 'Ambulance',
      'number': '911',
    },
    {
      'name': 'Fire Department',
      'number': '911',
    },
  ];

  // Dummy nearby hospitals data
  final List<Map<String, String>> nearbyHospitals = [
    {
      'name': 'City General Hospital',
      'address': '123 Main St, City, Country',
      'phone': '+1 234 567 890',
      'distance': '2.5 km',
    },
    {
      'name': 'Green Valley Hospital',
      'address': '456 Elm St, City, Country',
      'phone': '+1 345 678 901',
      'distance': '3.7 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Assistance'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SOS Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add functionality to send SOS alert
                },
                icon: Icon(Icons.warning, size: 24),
                label: Text('SOS Emergency'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),

            // Emergency Contacts Section
            Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            ...emergencyContacts.map((contact) => _buildEmergencyContactItem(contact)).toList(),

            // Nearby Hospitals Section
            SizedBox(height: 32),
            Text(
              'Nearby Hospitals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            ...nearbyHospitals.map((hospital) => _buildNearbyHospitalItem(hospital)).toList(),

            // Emergency Instructions Section
            SizedBox(height: 32),
            Text(
              'Emergency Instructions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            _buildEmergencyInstructions(),
          ],
        ),
      ),
    );
  }

  // Emergency Contact Item Widget
  Widget _buildEmergencyContactItem(Map<String, String> contact) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.phone, color: Colors.red),
        title: Text(
          contact['name']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contact['number']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.call, color: Colors.red),
          onPressed: () {
            // Add functionality to call the emergency number
          },
        ),
      ),
    );
  }

  // Nearby Hospital Item Widget
  Widget _buildNearbyHospitalItem(Map<String, String> hospital) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.local_hospital, color: Colors.red),
        title: Text(
          hospital['name']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${hospital['address']!} | ${hospital['distance']!}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.directions, color: Colors.red),
          onPressed: () {
            // Add functionality to open directions
          },
        ),
      ),
    );
  }

  // Emergency Instructions Widget
  Widget _buildEmergencyInstructions() {
    return Card(
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          'What to do in case of a heart attack?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '1. Call emergency services immediately.\n'
              '2. Chew and swallow an aspirin (if available).\n'
              '3. Stay calm and rest while waiting for help.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}