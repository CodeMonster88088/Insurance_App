import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insurance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CompanyPoliciesView(),
    );
  }
}

class CompanyPoliciesView extends StatefulWidget {
  const CompanyPoliciesView({super.key});

  @override
  State<CompanyPoliciesView> createState() => _CompanyPoliciesViewState();
}

class _CompanyPoliciesViewState extends State<CompanyPoliciesView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Approvals'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _showSnackbar(context, 'Refreshing policies...'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _policies.length,
        itemBuilder: (context, index) => _buildPolicyCard(_policies[index]),
      ),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          'Policy #${policy['policyNumber']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Status: ${policy['status']}',
          style: TextStyle(
            color: _getStatusColor(policy['status']),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('User Information'),
                _buildInfoRow('Full Name', policy['userData']['fullName']),
                _buildInfoRow('Email', policy['userData']['email']),
                _buildInfoRow('Phone', policy['userData']['phone']),
                _buildInfoRow('ID Number', policy['userData']['idNumber']),
                const SizedBox(height: 20),
                
                _buildSectionHeader('Policy Details'),
                _buildInfoRow('Policy Type', policy['policyType']),
                _buildInfoRow('Coverage Amount', '\$${policy['coverageAmount']}'),
                _buildInfoRow('Start Date', policy['startDate']),
                _buildInfoRow('End Date', policy['endDate']),
                const SizedBox(height: 20),
                
                if (policy['documents'] != null && policy['documents'].isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Attached Documents'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: policy['documents'].map<Widget>((doc) {
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.insert_drive_file, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(doc['name']),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _showSnackbar(context, 'Policy rejected'),
                        child: const Text('Reject', style: TextStyle(fontSize: 16)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _showSnackbar(context, 'Policy approved'),
                        child: const Text('Approve', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Not provided',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}