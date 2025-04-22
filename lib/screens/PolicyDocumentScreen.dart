import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
import 'package:intl/intl.dart';

class PolicyDocumentScreen extends StatelessWidget {
  final InsuranceModel policy;

  // Constructor to accept the policy object
  PolicyDocumentScreen({required this.policy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Document'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Policy Number: ${policy.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildPolicyDetailRow('Provider', policy.provider),
            _buildPolicyDetailRow('Coverage Amount', '${policy.coverageAmount} BHD'),
            _buildPolicyDetailRow('Duration', '${policy.duration} days'),
            _buildPolicyDetailRow('Coverage Region', policy.region),
            _buildPolicyDetailRow(
              'Period',
              '${DateFormat('MMM dd, yyyy').format(policy.startDate)} - ${DateFormat('MMM dd, yyyy').format(policy.endDate)}',
            ),
            if (policy.familyMembers.isNotEmpty) ...[
              SizedBox(height: 16),
              Text('Family Members:', style: TextStyle(fontSize: 16)),
              for (var member in policy.familyMembers)
                Text(
                  '- $member',
                  style: TextStyle(fontSize: 16),
                ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here, you can implement a function to download the policy or show it in a different way
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Downloading the policy document...')),
                );
              },
              child: Text('Download Policy Document'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to display policy details
  Widget _buildPolicyDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
