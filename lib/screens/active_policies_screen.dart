import 'package:flutter/material.dart';

class ActivePoliciesScreen extends StatefulWidget {
  @override
  _ActivePoliciesScreenState createState() => _ActivePoliciesScreenState();
}

class _ActivePoliciesScreenState extends State<ActivePoliciesScreen> {
  // Sample list of active policies
  final List<Map<String, dynamic>> _activePolicies = [
    {
      'policyNumber': 'POL-2023-001',
      'type': 'Health Insurance',
      'provider': 'Amaan Health',
      'startDate': '2023-01-15',
      'endDate': '2024-01-14',
      'premium': '\$120/month',
      'status': 'Active',
      'icon': Icons.health_and_safety,
      'color': Colors.blue,
    },
    {
      'policyNumber': 'POL-2023-045',
      'type': 'Auto Insurance',
      'provider': 'Amaan Auto',
      'startDate': '2023-03-10',
      'endDate': '2024-03-09',
      'premium': '\$85/month',
      'status': 'Active',
      'icon': Icons.directions_car,
      'color': Colors.green,
    },
    {
      'policyNumber': 'POL-2022-112',
      'type': 'Home Insurance',
      'provider': 'Amaan Home',
      'startDate': '2022-11-05',
      'endDate': '2023-11-04',
      'premium': '\$65/month',
      'status': 'Expiring Soon',
      'icon': Icons.home,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Policies'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _activePolicies.length,
        itemBuilder: (context, index) {
          final policy = _activePolicies[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: policy['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(policy['icon'], color: policy['color']),
              ),
              title: Text(
                policy['type'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Policy #${policy['policyNumber']}'),
                  Text('Provider: ${policy['provider']}'),
                  Text('Premium: ${policy['premium']}'),
                  Text('Valid: ${policy['startDate']} to ${policy['endDate']}'),
                ],
              ),
              trailing: Chip(
                label: Text(
                  policy['status'],
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: policy['status'] == 'Active'
                    ? Colors.green
                    : Colors.orange,
              ),
              onTap: () {
                _showPolicyDetails(context, policy);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewPolicy(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  void _showPolicyDetails(BuildContext context, Map<String, dynamic> policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(policy['type']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Policy Number', policy['policyNumber']),
              _buildDetailRow('Provider', policy['provider']),
              _buildDetailRow('Start Date', policy['startDate']),
              _buildDetailRow('End Date', policy['endDate']),
              _buildDetailRow('Premium', policy['premium']),
              _buildDetailRow('Status', policy['status']),
              SizedBox(height: 20),
              Text(
                'Policy Benefits:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Full coverage according to terms'),
              Text('• 24/7 customer support'),
              Text('• Easy claim process'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CLOSE'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Claim initiated for ${policy['policyNumber']}')),
              );
            },
            child: Text('MAKE A CLAIM'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _addNewPolicy(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add new policy functionality coming soon!')),
    );
  }
}