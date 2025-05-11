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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Policy Information'),
                _buildInfoRow('Policy ID', policy.policyId),
                _buildInfoRow('Provider ID', policy.providerId),
                _buildInfoRow('Customer Name', policy.customerName),
                _buildInfoRow('Number of Travelers', policy.numberOfTravelers.toString()),
                _buildInfoRow('Total Price', '${policy.totalPrice.toStringAsFixed(2)} BHD'),
                _buildInfoRow('Start Date', DateFormat('MMM dd, yyyy').format(policy.startDate)),
                _buildInfoRow('End Date', DateFormat('MMM dd, yyyy').format(policy.endDate)),
                _buildInfoRow('Status', policy.status),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
