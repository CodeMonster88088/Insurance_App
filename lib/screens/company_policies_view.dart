import 'package:flutter/material.dart';

class CompanyPoliciesView extends StatelessWidget {
  final List<Map<String, dynamic>> _policies = [
    {
      'policyNumber': 'POL-1001',
      'status': 'pending',
      'userData': {
        'fullName': 'John Smith',
        'email': 'john.smith@example.com',
        'phone': '+1 (555) 123-4567',
        'idNumber': 'ID-789456',
      },
      'policyType': 'Health Insurance',
      'coverageAmount': '500,000',
      'startDate': '2023-01-01',
      'endDate': '2024-01-01',
      'documents': [
        {'name': 'ID Proof.pdf'},
        {'name': 'Medical Report.pdf'},
      ],
    },
    {
      'policyNumber': 'POL-1002',
      'status': 'pending',
      'userData': {
        'fullName': 'Sarah Johnson',
        'email': 'sarah.j@example.com',
        'phone': '+1 (555) 987-6543',
        'idNumber': 'ID-321654',
      },
      'policyType': 'Auto Insurance',
      'coverageAmount': '50,000',
      'startDate': '2023-03-15',
      'endDate': '2024-03-15',
      'documents': [
        {'name': 'Driver License.pdf'},
        {'name': 'Vehicle Registration.pdf'},
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Colors.orange;
      case 'approved': return Colors.green;
      case 'rejected': return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ExpansionTile(
        title: ListTile(
          title: Text('Policy #${policy['policyNumber']}'),
          subtitle: Text('Status: ${policy['status']}'),
          trailing: Chip(
            label: Text(policy['status'].toUpperCase()),
            backgroundColor: _getStatusColor(policy['status']).withOpacity(0.2),
            labelStyle: TextStyle(
              color: _getStatusColor(policy['status']),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Information', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Name: ${policy['userData']['fullName']}'),
                Text('Email: ${policy['userData']['email']}'),
                Text('Phone: ${policy['userData']['phone']}'),
                SizedBox(height: 16),
                Text('Policy Details', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Type: ${policy['policyType']}'),
                Text('Coverage: \$${policy['coverageAmount']}'),
                Text('Period: ${policy['startDate']} to ${policy['endDate']}'),
                SizedBox(height: 16),
                if (policy['documents'] != null && policy['documents'].isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...policy['documents'].map((doc) => ListTile(
                        leading: Icon(Icons.insert_drive_file),
                        title: Text(doc['name']),
                      )).toList(),
                    ],
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Reject'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Policy rejected')));
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text('Approve'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Policy approved')));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Approvals'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _policies.length,
        itemBuilder: (context, index) => _buildPolicyCard(_policies[index], context),
      ),
    );
  }
}