import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import '../models/insurance_model.dart';

class InsuranceListItem extends StatelessWidget {
  final InsuranceModel insurance;

  const InsuranceListItem({required this.insurance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add shadow
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1), // Border
      ),
      child: ListTile(
        title: Text(insurance.provider),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${DateFormat('yyyy-MM-dd').format(insurance.fromDate)}'),
            SizedBox(height: 4), // Add spacing
            Text('To: ${DateFormat('yyyy-MM-dd').format(insurance.toDate)}'),
            SizedBox(height: 4), // Add spacing
            Text('Travelers: ${insurance.numberOfTravelers}'),
            SizedBox(height: 4), // Add spacing
            Row(
              children: [
                Icon(Icons.attach_money, size: 16),
                SizedBox(width: 4),
                Text('${insurance.price.toStringAsFixed(2)} BHD'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}