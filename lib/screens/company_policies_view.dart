import 'package:flutter/material.dart';

class CompanyPoliciesView extends StatefulWidget {
  @override
  _CompanyPoliciesViewState createState() => _CompanyPoliciesViewState();
}

class _CompanyPoliciesViewState extends State<CompanyPoliciesView> {
  final List<Map<String, dynamic>> _allPolicies = [
    {
      'policyNumber': 'POL-1001',
      'status': 'pending',
      'userData': {
        'fullName': 'John Smith',
        'email': 'john.smith@example.com',
        'phone': '+1 (555) 123-4567',
        'idNumber': 'ID-789456',
        'address': '123 Main St, Anytown, USA',
      },
      'policyType': 'Health Insurance',
      'coverageAmount': 500000.00,
      'premiumAmount': 250.00,
      'startDate': '2023-01-01',
      'endDate': '2024-01-01',
      'documents': [
        {'name': 'ID Proof.pdf', 'uploaded': '2023-01-01'},
        {'name': 'Medical Report.pdf', 'uploaded': '2023-01-01'},
      ],
      'createdAt': '2023-01-01T10:30:00Z',
    },
    {
      'policyNumber': 'POL-1002',
      'status': 'pending',
      'userData': {
        'fullName': 'Sarah Johnson',
        'email': 'sarah.j@example.com',
        'phone': '+1 (555) 987-6543',
        'idNumber': 'ID-321654',
        'address': '456 Oak Ave, Somewhere, USA',
      },
      'policyType': 'Auto Insurance',
      'coverageAmount': 50000.00,
      'premiumAmount': 120.00,
      'startDate': '2023-03-15',
      'endDate': '2024-03-15',
      'documents': [
        {'name': 'Driver License.pdf', 'uploaded': '2023-03-15'},
        {'name': 'Vehicle Registration.pdf', 'uploaded': '2023-03-15'},
      ],
      'createdAt': '2023-03-15T14:45:00Z',
    },
    {
      'policyNumber': 'POL-1003',
      'status': 'approved',
      'userData': {
        'fullName': 'Michael Brown',
        'email': 'michael.b@example.com',
        'phone': '+1 (555) 456-7890',
        'idNumber': 'ID-654987',
        'address': '789 Pine Rd, Nowhere, USA',
      },
      'policyType': 'Life Insurance',
      'coverageAmount': 1000000.00,
      'premiumAmount': 500.00,
      'startDate': '2023-02-10',
      'endDate': '2033-02-10',
      'documents': [
        {'name': 'Medical Exam.pdf', 'uploaded': '2023-02-10'},
        {'name': 'Beneficiary Form.pdf', 'uploaded': '2023-02-10'},
      ],
      'createdAt': '2023-02-10T09:15:00Z',
      'approvedAt': '2023-02-12T11:30:00Z',
    },
  ];

  String _filter = 'pending';

  List<Map<String, dynamic>> get _filteredPolicies {
    if (_filter == 'all') return _allPolicies;
    return _allPolicies.where((policy) => policy['status'] == _filter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Colors.orange;
      case 'approved': return Colors.green;
      case 'rejected': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Icons.pending;
      case 'approved': return Icons.check_circle;
      case 'rejected': return Icons.cancel;
      default: return Icons.help_outline;
    }
  }

  Future<void> _refreshPolicies() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    Icon(Icons.all_inbox, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('All Policies'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'pending',
                child: Row(
                  children: [
                    Icon(Icons.pending, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Pending Approval'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'approved',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Approved'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'rejected',
                child: Row(
                  children: [
                    Icon(Icons.cancel, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Rejected'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPolicies,
        child: _filteredPolicies.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.policy, size: 64, color: Colors.grey),
                    Text('No Policies Found'),
                    TextButton(
                      child: Text('Reset Filters'),
                      onPressed: () {
                        setState(() {
                          _filter = 'all';
                        });
                      },
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _filteredPolicies.length,
                itemBuilder: (context, index) => _buildPolicyCard(_filteredPolicies[index], context),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewPolicyDialog(context),
      ),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(_getStatusIcon(policy['status']), color: _getStatusColor(policy['status'])),
        title: Text(
          'Policy #${policy['policyNumber']}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${policy['policyType']} • \$${policy['coverageAmount'].toStringAsFixed(2)}'),
        trailing: Chip(
          label: Text(policy['status'].toUpperCase()),
          backgroundColor: _getStatusColor(policy['status']).withOpacity(0.2),
          labelStyle: TextStyle(
            color: _getStatusColor(policy['status']),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPolicyDetailItem('Policy Holder', policy['userData']['fullName']),
                _buildPolicyDetailItem('Email', policy['userData']['email']),
                _buildPolicyDetailItem('Phone', policy['userData']['phone']),
                _buildPolicyDetailItem('ID Number', policy['userData']['idNumber']),
                _buildPolicyDetailItem('Address', policy['userData']['address']),
                Divider(),
                _buildPolicyDetailItem('Coverage Amount', '\$${policy['coverageAmount'].toStringAsFixed(2)}'),
                _buildPolicyDetailItem('Premium Amount', '\$${policy['premiumAmount'].toStringAsFixed(2)}'),
                _buildPolicyDetailItem('Policy Period', '${policy['startDate']} to ${policy['endDate']}'),
                Divider(),
                if (policy['documents'] != null && policy['documents'].isNotEmpty) ...[
                  Text('Documents:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ...policy['documents'].map((doc) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.insert_drive_file),
                    title: Text(doc['name']),
                    subtitle: Text('Uploaded: ${doc['uploaded']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () {},
                    ),
                  )).toList(),
                ],
                SizedBox(height: 16),
                if (policy['status'] == 'pending') ...[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.check),
                          label: Text('Approve'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              policy['status'] = 'approved';
                              policy['approvedAt'] = DateTime.now().toIso8601String();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Policy ${policy['policyNumber']} approved')));
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.close),
                          label: Text('Reject'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              policy['status'] = 'rejected';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Policy ${policy['policyNumber']} rejected')));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Policies'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Policy Number',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Policy Holder',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(value: 'all', child: Text('All Types')),
                DropdownMenuItem(value: 'Health', child: Text('Health Insurance')),
                DropdownMenuItem(value: 'Auto', child: Text('Auto Insurance')),
                DropdownMenuItem(value: 'Life', child: Text('Life Insurance')),
              ],
              decoration: InputDecoration(
                labelText: 'Policy Type',
                prefixIcon: Icon(Icons.policy),
              ),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Search'),
            onPressed: () {
              // Implement search logic
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showNewPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Policy Application'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Policy Type'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Coverage Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Premium Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Start Date'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('New policy application submitted')));
            },
          ),
        ],
      ),
    );
  }
}