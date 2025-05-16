import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_test/models/user_model';

class CompanyPoliciesView extends StatefulWidget {
  final UserModel user;
  const CompanyPoliciesView({Key? key, required this.user}) : super(key: key);

  @override
  _CompanyPoliciesViewState createState() => _CompanyPoliciesViewState();
}

class _CompanyPoliciesViewState extends State<CompanyPoliciesView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchPolicyRequests() async {
    final snapshot = await _firestore
        .collection('policy_requests')
        .where('provider_id', isEqualTo: widget.user.fullName)
        .get();
print('Current user UID: ${widget.user.uid}');
print('Current user UID: ${widget.user.fullName}');


    final requests = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return requests;
  }

  Future<List<Map<String, dynamic>>> _fetchMyPolicies() async {
    final snapshot = await _firestore
        .collection('insurance_policies')
        .where('provider_id', isEqualTo: widget.user.uid)
        .get();

    final policies = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return policies;
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
        body: TabBarView(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchPolicyRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No policy requests found.'));
                }
                return _buildPolicyList(snapshot.data!, isRequestTab: true);
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchMyPolicies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No policies found.'));
                }
                return _buildPolicyList(snapshot.data!, isRequestTab: false);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showNewPolicyDialog(context),
        ),
      ),
    );
  }

  Widget _buildPolicyList(List<Map<String, dynamic>> policies,
      {bool isRequestTab = false}) {
    if (policies.isEmpty) {
      return Center(child: Text('No policies to display.'));
    }

    return RefreshIndicator(
      onRefresh: _refreshPolicies,
      child: ListView.builder(
        itemCount: policies.length,
        itemBuilder: (context, index) =>
            _buildPolicyCard(policies[index], context, isRequestTab),
      ),
    );
  }

  Widget _buildPolicyCard(
      Map<String, dynamic> policy, BuildContext context, bool isRequestTab) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ExpansionTile(
        leading: isRequestTab
            ? Icon(_getStatusIcon(policy['status']),
                color: _getStatusColor(policy['status']))
            : Icon(Icons.policy, color: Colors.blue),
        title: Text('Policy #${policy['policyNumber'] ?? policy['id']}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            '${policy['policyType'] ?? 'General'} • \$${(policy['coverageAmount'] ?? 0).toStringAsFixed(2)}'),
        trailing: isRequestTab
            ? Chip(
                label: Text(policy['status'].toUpperCase()),
                backgroundColor:
                    _getStatusColor(policy['status']).withOpacity(0.2),
                labelStyle: TextStyle(
                  color: _getStatusColor(policy['status']),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              )
            : null,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isRequestTab) ...[
                  _buildPolicyDetailItem(
                      'Policy Holder', policy['userData']?['fullName'] ?? ''),
                  _buildPolicyDetailItem(
                      'Email', policy['userData']?['email'] ?? ''),
                  _buildPolicyDetailItem(
                      'Phone', policy['userData']?['phone'] ?? ''),
                  _buildPolicyDetailItem(
                      'ID Number', policy['userData']?['idNumber'] ?? ''),
                  _buildPolicyDetailItem(
                      'Address', policy['userData']?['address'] ?? ''),
                  Divider(),
                ],
                _buildPolicyDetailItem('Coverage Amount',
                    '\$${(policy['coverageAmount'] ?? 0).toStringAsFixed(2)}'),
                _buildPolicyDetailItem('Premium Amount',
                    '\$${(policy['premiumAmount'] ?? 0).toStringAsFixed(2)}'),
                _buildPolicyDetailItem(
                    'Duration', '${policy['duration']} days'),
                Divider(),
                if (isRequestTab &&
                    policy['documents'] != null &&
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
                if (isRequestTab && policy['status'] == 'pending') ...[
                  SizedBox(height: 16),
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
                ]
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

  Future<void> _addNewPolicy(Map<String, dynamic> policyData) async {
    try {
      await FirebaseFirestore.instance
          .collection('insurance_policies')
          .add(policyData);

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
    final TextEditingController _coverageAmountController =
        TextEditingController();
    final TextEditingController _durationController = TextEditingController();
    final TextEditingController _regionController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _numberOfTravelersController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Policy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _coverageAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Coverage Amount'),
              ),
              TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Duration (in days)'),
              ),
              TextField(
                controller: _regionController,
                decoration: InputDecoration(labelText: 'Region'),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: _numberOfTravelersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of Travelers'),
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
              final newPolicy = {
                'id': DateTime.now().millisecondsSinceEpoch.toString(), //TODO
                'provider': widget.user.fullName,
                'provider_id': widget.user.uid,
                'coverageAmount':
                    double.tryParse(_coverageAmountController.text) ?? 0,
                'duration': int.tryParse(_durationController.text) ?? 0,
                'region': _regionController.text,
                'price': double.tryParse(_priceController.text) ?? 0,
                'numberOfTravelers':
                    int.tryParse(_numberOfTravelersController.text) ?? 0,

                // No 'status' field — this is a company-created policy
              };

              _addNewPolicy(newPolicy).then((_) {
                Navigator.pop(context);
                setState(
                    () {}); // this will re-trigger FutureBuilder to fetch policies again
              });
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
