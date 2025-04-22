import 'package:flutter/material.dart';

class CompanyClaimsView extends StatelessWidget {
  final List<Map<String, dynamic>> claims = [
    {
      'claimNumber': 'CL-2023-1001',
      'status': 'pending',
      'claimType': 'Medical',
      'claimAmount': 1250.00,
      'incidentDate': '2023-05-15',
      'policyHolder': 'John Smith',
      'policyNumber': 'POL-1001',
      'description': 'Emergency room visit for severe headache'
    },
    {
      'claimNumber': 'CL-2023-1002',
      'status': 'approved',
      'claimType': 'Auto',
      'claimAmount': 3250.00,
      'incidentDate': '2023-06-22',
      'policyHolder': 'Sarah Johnson',
      'policyNumber': 'POL-1002',
      'description': 'Rear-end collision at traffic light'
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved': return Colors.green;
      case 'rejected': return Colors.red;
      case 'processing': return Colors.orange;
      default: return Colors.blue; // pending
    }
  }

  Widget _buildClaimCard(Map<String, dynamic> claim, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text('Claim #${claim['claimNumber']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Policy Holder: ${claim['policyHolder']}'),
            Text('Type: ${claim['claimType']}'),
            Text('Amount: \$${claim['claimAmount'].toStringAsFixed(2)}'),
          ],
        ),
        trailing: Chip(
          label: Text(claim['status'].toUpperCase()),
          backgroundColor: _getStatusColor(claim['status']).withOpacity(0.2),
          labelStyle: TextStyle(
            color: _getStatusColor(claim['status']),
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Claim Details'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Claim #${claim['claimNumber']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Status: ${claim['status']}'),
                    Divider(),
                    Text('Policy Holder: ${claim['policyHolder']}'),
                    Text('Policy #: ${claim['policyNumber']}'),
                    Text('Type: ${claim['claimType']}'),
                    Text('Amount: \$${claim['claimAmount'].toStringAsFixed(2)}'),
                    Text('Incident Date: ${claim['incidentDate']}'),
                    Divider(),
                    Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(claim['description']),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Claims'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: claims.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
                  Text('No Claims Found'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: claims.length,
              itemBuilder: (context, index) => _buildClaimCard(claims[index], context),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}