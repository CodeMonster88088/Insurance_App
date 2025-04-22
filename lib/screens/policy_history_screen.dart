import 'package:flutter/material.dart';

class PolicyHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history = [
    {
      'id': 'POL-123456',
      'type': 'Auto Insurance',
      'status': 'Expired',
      'period': 'May 15, 2020 - May 15, 2023',
      'premium': '\$115.50',
    },
    {
      'id': 'POL-789012',
      'type': 'Renters Insurance',
      'status': 'Cancelled',
      'period': 'June 1, 2019 - June 1, 2021',
      'premium': '\$45.00',
    },
    {
      'id': 'POL-345678',
      'type': 'Health Insurance',
      'status': 'Expired',
      'period': 'January 10, 2018 - January 10, 2020',
      'premium': '\$175.75',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy History'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final policy = history[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
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
                      _buildPolicyDetail('Period', policy['period']),
                      SizedBox(width: 16),
                      _buildPolicyDetail('Premium', policy['premium']),
                    ],
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _showPolicyDetails(context, policy),
                      child: Text('View Details'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
      case 'expired':
        return Colors.orange;
      case 'cancelled':
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
                _buildDetailRow('Coverage Period', policy['period']),
                _buildDetailRow('Monthly Premium', policy['premium']),
                SizedBox(height: 24),
                if (policy['status'] == 'Expired')
                  Text(
                    'This policy has expired. Would you like to renew it?',
                    style: TextStyle(color: Colors.orange),
                  ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ),
                    if (policy['status'] == 'Expired') ...[
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Renewal process started')),
                            );
                          },
                          child: Text('Renew'),
                        ),
                      ),
                    ],
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
}