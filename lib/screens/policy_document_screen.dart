import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
import 'package:intl/intl.dart';

class PolicyDocumentScreen extends StatelessWidget {
  final InsuranceModel policy;

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
                _buildInfoRow('Provider', policy.provider),
                _buildInfoRow('Policy Number', policy.id.toString()),
                _buildInfoRow('Coverage Type', policy.coverageType),
                _buildInfoRow('Coverage Amount', '${policy.coverageAmount} BHD'),
                _buildInfoRow('Price', '${policy.price} BHD'),
                _buildInfoRow('Duration', '${policy.duration} days'),
                _buildInfoRow('Region', policy.region),
                _buildInfoRow('Start Date', DateFormat('MMM dd, yyyy').format(policy.startDate)),
                _buildInfoRow('End Date', DateFormat('MMM dd, yyyy').format(policy.endDate)),
                _buildInfoRow('Status', policy.status),

                SizedBox(height: 20),
                if (policy.familyMembers.isNotEmpty) ...[
                  _buildSectionTitle('Family Members'),
                  ...policy.familyMembers.map((member) => Text('• $member')).toList(),
                ],

                SizedBox(height: 20),
                _buildSectionTitle('Additional Info'),
                _buildInfoRow('Number of Travelers', policy.numberOfTravelers.toString()),
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
