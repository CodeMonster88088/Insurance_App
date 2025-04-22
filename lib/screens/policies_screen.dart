import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> policies = [
    {
      'id': 'POL-123456',
      'type': 'Auto Insurance',
      'status': 'Active',
      'premium': '\$125.50',
      'renewalDate': 'May 15, 2024',
      'vehicle': '2020 Honda Accord',
    },
    {
      'id': 'POL-789012',
      'type': 'Home Insurance',
      'status': 'Active',
      'premium': '\$85.00',
      'renewalDate': 'June 1, 2024',
      'property': '123 Main St, Anytown',
    },
    {
      'id': 'POL-345678',
      'type': 'Life Insurance',
      'status': 'Active',
      'premium': '\$65.75',
      'renewalDate': 'July 10, 2024',
      'coverage': '\$500,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Policies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: policies.length,
        itemBuilder: (context, index) {
          final policy = policies[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _showPolicyDetails(context, policy),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          policy['type'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Chip(
                          label: Text(
                            policy['status'],
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _getStatusColor(policy['status']),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Policy #: ${policy['id']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        _buildPolicyDetail('Premium', policy['premium']),
                        SizedBox(width: 16),
                        _buildPolicyDetail('Renewal', policy['renewalDate']),
                      ],
                    ),
                    SizedBox(height: 8),
                    if (policy['vehicle'] != null)
                      Text('Vehicle: ${policy['vehicle']}'),
                    if (policy['property'] != null)
                      Text('Property: ${policy['property']}'),
                    if (policy['coverage'] != null)
                      Text('Coverage: ${policy['coverage']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPolicyDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPolicyDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showPolicyDetails(BuildContext context, Map<String, dynamic> policy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  policy['type'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Policy #: ${policy['id']}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 24),
                _buildDetailRow('Status', policy['status'],
                    color: _getStatusColor(policy['status'])),
                _buildDetailRow('Premium', policy['premium']),
                _buildDetailRow('Renewal Date', policy['renewalDate']),
                if (policy['vehicle'] != null)
                  _buildDetailRow('Vehicle', policy['vehicle']),
                if (policy['property'] != null)
                  _buildDetailRow('Property', policy['property']),
                if (policy['coverage'] != null)
                  _buildDetailRow('Coverage Amount', policy['coverage']),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showClaimsDialog(context, policy['id']);
                        },
                        child: Text('File Claim'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Policy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your new policy information'),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Policy Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Insurance Type',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Policy added successfully')),
              );
            },
            child: Text('Add Policy'),
          ),
        ],
      ),
    );
  }

  void _showClaimsDialog(BuildContext context, String policyId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('File a Claim'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You are filing a claim for policy $policyId'),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Claim Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Estimated Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Claim submitted successfully')),
              );
            },
            child: Text('Submit Claim'),
          ),
        ],
      ),
    );
  }
}