import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For animations
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For icons

class NearbyHospitalsPage extends StatelessWidget {
  // Dummy data for hospitals
  final List<Map<String, String>> hospitals = [
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
    {
      'name': 'Sunrise Medical Center',
      'address': '789 Oak St, City, Country',
      'phone': '+1 456 789 012',
      'distance': '5.1 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for hospitals...',
                prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ).animate().fadeIn(duration: 500.ms),
          ),

          // Hospital List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return _buildHospitalCard(hospital).animate().slideX(
                  delay: (200 * index).ms,
                  duration: 500.ms,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hospital Card Widget
  Widget _buildHospitalCard(Map<String, String> hospital) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Name
            Text(
              hospital['name']!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 8),

            // Hospital Address
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hospital['address']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Hospital Phone
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  hospital['phone']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Hospital Distance
            Row(
              children: [
                Icon(Icons.directions_walk, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  hospital['distance']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Call, Book Appointment, and Emergency Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality to call the hospital
                    },
                    icon: Icon(Icons.call, size: 16),
                    label: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Fixed: Added comma
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality to book an appointment
                    },
                    icon: Icon(Icons.calendar_today, size: 16),
                    label: Text('Book Appointment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Fixed: Added comma
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality to call the emergency number
                    },
                    icon: Icon(Icons.emergency, size: 16),
                    label: Text('Emergency'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}