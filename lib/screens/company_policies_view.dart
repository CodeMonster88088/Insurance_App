import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyPoliciesView extends StatefulWidget {
  @override
  _CompanyPoliciesViewState createState() => _CompanyPoliciesViewState();
}

class _CompanyPoliciesViewState extends State<CompanyPoliciesView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchPolicies() async {
    final snapshot = await _firestore.collection('policies').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> _refreshPolicies() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Policy Management'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.inbox), text: 'Policy Requests'),
              Tab(icon: Icon(Icons.list), text: 'My Policies'),
            ],
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchPolicies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No policies found.'));
            }

            final allPolicies = snapshot.data!;
            final pending =
                allPolicies.where((p) => p['status'] == 'pending').toList();
            final approved =
                allPolicies.where((p) => p['status'] != 'pending').toList();

            return TabBarView(
              children: [
                _buildPolicyList(pending),
                _buildPolicyList(approved),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showNewPolicyDialog(context),
        ),
      ),
    );
  }

  Widget _buildPolicyList(List<Map<String, dynamic>> policies) {
    if (policies.isEmpty) {
      return Center(child: Text('No policies to display.'));
    }
    return RefreshIndicator(
      onRefresh: _refreshPolicies,
      child: ListView.builder(
        itemCount: policies.length,
        itemBuilder: (context, index) =>
            _buildPolicyCard(policies[index], context),
      ),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(_getStatusIcon(policy['status']),
            color: _getStatusColor(policy['status'])),
        title: Text('Policy #${policy['policyNumber']}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            '${policy['policyType']} • \$${policy['coverageAmount'].toStringAsFixed(2)}'),
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
                _buildPolicyDetailItem(
                    'Policy Holder', policy['userData']['fullName'] ?? ''),
                _buildPolicyDetailItem(
                    'Email', policy['userData']['email'] ?? ''),
                _buildPolicyDetailItem(
                    'Phone', policy['userData']['phone'] ?? ''),
                _buildPolicyDetailItem(
                    'ID Number', policy['userData']['idNumber'] ?? ''),
                _buildPolicyDetailItem(
                    'Address', policy['userData']['address'] ?? ''),
                Divider(),
                _buildPolicyDetailItem('Coverage Amount',
                    '\$${policy['coverageAmount'].toStringAsFixed(2)}'),
                _buildPolicyDetailItem('Premium Amount',
                    '\$${policy['premiumAmount'].toStringAsFixed(2)}'),
                _buildPolicyDetailItem('Policy Period',
                    '${policy['startDate']} to ${policy['endDate']}'),
                Divider(),
                if (policy['documents'] != null &&
                    policy['documents'].isNotEmpty) ...[
                  Text('Documents:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ...policy['documents'].map<Widget>((doc) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.insert_drive_file),
                        title: Text(doc['name']),
                        subtitle: Text('Uploaded: ${doc['uploaded']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {},
                        ),
                      )),
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
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            await _firestore
                                .collection('policies')
                                .doc(policy['id'])
                                .update({
                              'status': 'approved',
                              'approvedAt': DateTime.now().toIso8601String(),
                            });
                            _refreshPolicies();
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.close),
                          label: Text('Reject'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            await _firestore
                                .collection('policies')
                                .doc(policy['id'])
                                .update({
                              'status': 'rejected',
                            });
                            _refreshPolicies();
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
              child: Text('$label:',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  void _addNewPolicy(Map<String, dynamic> policyData) async {
  try {
    await FirebaseFirestore.instance
        .collection('insurance_policies')
        .add(policyData); // Adds a new policy to Firestore

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Policy added successfully')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding policy: $e')),
    );
  }
}


  void _showNewPolicyDialog(BuildContext context) {
    final TextEditingController _policyTypeController = TextEditingController();
    final TextEditingController _fullNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Policy Application'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: _policyTypeController,
                  decoration: InputDecoration(labelText: 'Policy Type')),
              TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name')),
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email')),
              // Add other fields here
            ],
          ),
        ),
        actions: [
          TextButton(
              child: Text('Cancel'), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              Map<String, dynamic> newPolicy = {
                'policyNumber': 'POL-${DateTime.now().millisecondsSinceEpoch}',
                'status': 'pending',
                'policyType': _policyTypeController.text,
                'userData': {
                  'fullName': _fullNameController.text,
                  'email': _emailController.text,
                },
                'coverageAmount': 500000.00,
                'premiumAmount': 250.00,
                'startDate': DateTime.now().toIso8601String(),
                'endDate':
                    DateTime.now().add(Duration(days: 365)).toIso8601String(),
              };

              _addNewPolicy(newPolicy); // Add the new policy to Firebase
              Navigator.pop(context);
            },
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

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }
}
