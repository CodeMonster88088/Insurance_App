import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/PolicyRequestModel.dart';
import 'package:intl/intl.dart';

class PolicyDocumentScreen extends StatelessWidget {
  final PolicyRequestModel policy;

  const PolicyDocumentScreen({Key? key, required this.policy}) : super(key: key);

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
            _buildPolicyDetailRow('Customer Name', policy.customerName),
            _buildPolicyDetailRow('Customer ID', policy.customerId),
            _buildPolicyDetailRow('Provider ID', policy.providerId),
            _buildPolicyDetailRow('Policy ID', policy.policyId),
            _buildPolicyDetailRow('Number of Travelers', policy.numberOfTravelers.toString()),
            _buildPolicyDetailRow('Total Price', '${policy.totalPrice.toStringAsFixed(2)} BHD'),
            _buildPolicyDetailRow(
              'Period',
              '${DateFormat('MMM dd, yyyy').format(policy.startDate)} - ${DateFormat('MMM dd, yyyy').format(policy.endDate)}',
            ),
            _buildPolicyDetailRow('Status', policy.status),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
