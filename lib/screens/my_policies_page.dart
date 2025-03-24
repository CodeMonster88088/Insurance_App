import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyPoliciesPage extends StatelessWidget {
  final List<Map<String, dynamic>> policies = [
    {
      'name': 'Travel Insurance',
      'status': 'Active',
      'renewalDate': '2023-12-01',
    },
    {
      'name': 'Health Insurance',
      'status': 'Expired',
      'renewalDate': '2023-10-01',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Policies'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: policies.length,
        itemBuilder: (context, index) {
          final policy = policies[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(policy['name']),
              subtitle: Text('Status: ${policy['status']}'),
              trailing: Text('Renewal: ${policy['renewalDate']}'),
              onTap: () {
                // Navigate to policy details
              },
            ),
          ).animate().fadeIn(delay: (index * 200).ms);
        },
      ),
    );
  }
}