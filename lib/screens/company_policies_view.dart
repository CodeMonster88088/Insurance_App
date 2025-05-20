import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_test/models/user_model';
import 'package:intl/intl.dart';

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
        .where('providerId', isEqualTo: widget.user.uid)
        .where('status',
            whereIn: ['approved', 'pending']) // Only these statuses
        .get();
    return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  Future<List<Map<String, dynamic>>> _fetchMyPolicies() async {
    final snapshot = await _firestore
        .collection('insurance_policies')
        .where('provider_id', isEqualTo: widget.user.uid)
        .get();
    return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  Future<List<Map<String, dynamic>>> _fetchArchivedPolicyRequests() async {
    // Get all policy requests except approved and pending
    final snapshot = await _firestore
        .collection('policy_requests')
        .where('providerId', isEqualTo: widget.user.uid)
        .where('status', whereNotIn: ['approved', 'pending']).get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> _refreshPolicies() async => setState(() {});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Policy Management'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.inbox), text: 'Policy Requests'),
              Tab(icon: Icon(Icons.list), text: 'My Policies'),
              Tab(icon: Icon(Icons.archive), text: 'Archived'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchPolicyRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No policy requests found.'));
                }
                return _buildPolicyList(snapshot.data!, isRequestTab: true);
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchMyPolicies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No active policies found.'));
                }
                return _buildPolicyList(snapshot.data!, isRequestTab: false);
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchArchivedPolicyRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No archived requests found.'));
                }
                return _buildPolicyList(snapshot.data!, isRequestTab: true);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showNewPolicyDialog(context),
        ),
      ),
    );
  }

  Widget _buildPolicyList(List<Map<String, dynamic>> policies,
      {required bool isRequestTab}) {
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
    final dateFormat = DateFormat('dd MMM yyyy');
    final currencyFormat = NumberFormat.simpleCurrency();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ExpansionTile(
        leading: isRequestTab
            ? Icon(_getStatusIcon(policy['status']),
                color: _getStatusColor(policy['status']))
            : const Icon(Icons.policy, color: Colors.blue),
        title: Text(
          isRequestTab
              ? 'Request by ${policy['customerName'] ?? 'Unknown'}'
              : 'Policy #${policy['id']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_buildSubtitle(policy, isRequestTab, currencyFormat)),
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
          _buildPolicyDetails(policy, isRequestTab, dateFormat, currencyFormat)
        ],
      ),
    );
  }

  String _buildSubtitle(Map<String, dynamic> policy, bool isRequestTab,
      NumberFormat currencyFormat) {
    return isRequestTab
        ? '${policy['region'] ?? '-'} • ${policy['numberOfTravelers']} travelers • ${currencyFormat.format(policy['totalPrice'] ?? 0)}'
        : '${policy['region'] ?? '-'} • ${currencyFormat.format(policy['coverageAmount'] ?? 0)} • ${policy['duration']} days';
  }

  Widget _buildPolicyDetails(Map<String, dynamic> policy, bool isRequestTab,
      DateFormat dateFormat, NumberFormat currencyFormat) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRequestTab) ...[
            _buildPolicyDetailItem('Created At',
                dateFormat.format((policy['createdAt'] as Timestamp).toDate())),
            _buildPolicyDetailItem('Travel Dates',
                '${dateFormat.format((policy['startDate'] as Timestamp).toDate())} → ${dateFormat.format((policy['endDate'] as Timestamp).toDate())}'),
            _buildPolicyDetailItem(
                'Payment Method', policy['paymentMethod'] ?? 'N/A'),
            const Divider(),
            const Text('Traveler Info:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...((policy['travelers'] as List<dynamic>?) ?? [])
                .map((traveler) => _buildTravelerInfo(traveler, dateFormat)),
          ] else ...[
            _buildPolicyDetailItem('Coverage Amount',
                currencyFormat.format(policy['coverageAmount'] ?? 0)),
            _buildPolicyDetailItem(
                'Price', currencyFormat.format(policy['price'] ?? 0)),
            _buildPolicyDetailItem('Duration', '${policy['duration']} days'),
            _buildPolicyDetailItem('Region', policy['region'] ?? 'Unknown'),
            _buildPolicyDetailItem(
                'Travelers', '${policy['numberOfTravelers']}'),
            _buildPolicyDetailItem('Provider', policy['provider'] ?? 'Unknown'),

            // Add edit/delete buttons for My Policies tab
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _showEditPolicyDialog(context, policy),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                              'Are you sure you want to delete this policy? This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await _deletePolicy(policy['id']);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
          if (isRequestTab &&
              policy['documents'] != null &&
              (policy['documents'] as List).isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text('Documents:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...policy['documents'].map<Widget>((doc) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.insert_drive_file),
                  title: Text(doc['name'] ?? 'Document'),
                  subtitle: Text('Uploaded: ${doc['uploaded'] ?? 'N/A'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {},
                  ),
                )),
          ],
          if (isRequestTab && policy['status'] == 'pending')
            _buildApprovalButtons(policy['id'])
        ],
      ),
    );
  }

  Widget _buildTravelerInfo(
      Map<String, dynamic> traveler, DateFormat dateFormat) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyDetailItem('Name', traveler['name']),
          _buildPolicyDetailItem('Nationality', traveler['nationality']),
          _buildPolicyDetailItem('Passport', traveler['passportNumber']),
          _buildPolicyDetailItem(
              'DOB',
              dateFormat
                  .format((traveler['dateOfBirth'] as Timestamp).toDate())),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildApprovalButtons(String policyId) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Approve'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              await _firestore
                  .collection('policy_requests')
                  .doc(policyId)
                  .update({
                'status': 'approved',
                'approvedAt': DateTime.now().toIso8601String(),
              });
              _refreshPolicies();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Reject'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reject Policy Request'),
                  content: const Text(
                      'Are you sure you want to reject this request?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Reject'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await _firestore
                    .collection('policy_requests')
                    .doc(policyId)
                    .update({
                  'status': 'rejected',
                });
                _refreshPolicies();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text('$label:',
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _addNewPolicy(Map<String, dynamic> policyData) async {
    try {
      await _firestore.collection('insurance_policies').add(policyData);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Policy added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error adding policy: $e')));
    }
  }

  Future<void> _deletePolicy(String policyId) async {
    try {
      await _firestore.collection('insurance_policies').doc(policyId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Policy deleted successfully')));
      _refreshPolicies();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting policy: $e')));
    }
  }

  void _showEditPolicyDialog(
      BuildContext context, Map<String, dynamic> policy) {
    final controllers = {
      'coverageAmount':
          TextEditingController(text: policy['coverageAmount'].toString()),
      'duration': TextEditingController(text: policy['duration'].toString()),
      'region': TextEditingController(text: policy['region']),
      'price': TextEditingController(text: policy['price'].toString()),
      'numberOfTravelers':
          TextEditingController(text: policy['numberOfTravelers'].toString()),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Policy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: controllers.entries
                .map((e) => TextField(
                      controller: e.value,
                      keyboardType: e.key == 'region'
                          ? TextInputType.text
                          : TextInputType.number,
                      decoration: InputDecoration(
                          labelText: e.key
                              .replaceAll(RegExp(r'([A-Z])'), ' \$1')
                              .capitalize()),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final updatedPolicy = {
                'coverageAmount':
                    double.tryParse(controllers['coverageAmount']!.text) ?? 0,
                'duration': int.tryParse(controllers['duration']!.text) ?? 0,
                'region': controllers['region']!.text,
                'price': double.tryParse(controllers['price']!.text) ?? 0,
                'numberOfTravelers':
                    int.tryParse(controllers['numberOfTravelers']!.text) ?? 0,
                'updatedAt': Timestamp.now(),
              };

              _firestore
                  .collection('insurance_policies')
                  .doc(policy['id'])
                  .update(updatedPolicy)
                  .then((_) {
                Navigator.pop(context);
                _refreshPolicies();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Policy updated successfully')));
              });
            },
          ),
        ],
      ),
    );
  }

  void _showNewPolicyDialog(BuildContext context) {
    final controllers = {
      'coverageAmount': TextEditingController(),
      'duration': TextEditingController(),
      'region': TextEditingController(),
      'price': TextEditingController(),
      'numberOfTravelers': TextEditingController(),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Policy'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: controllers.entries
                .map((e) => TextField(
                      controller: e.value,
                      keyboardType: e.key == 'region'
                          ? TextInputType.text
                          : TextInputType.number,
                      decoration: InputDecoration(
                          labelText: e.key
                              .replaceAll(RegExp(r'([A-Z])'), ' \$1')
                              .capitalize()),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              final newPolicy = {
                'id': DateTime.now().millisecondsSinceEpoch.toString(),
                'provider': widget.user.fullName,
                'provider_id': widget.user.uid,
                'coverageAmount':
                    double.tryParse(controllers['coverageAmount']!.text) ?? 0,
                'duration': int.tryParse(controllers['duration']!.text) ?? 0,
                'region': controllers['region']!.text,
                'price': double.tryParse(controllers['price']!.text) ?? 0,
                'numberOfTravelers':
                    int.tryParse(controllers['numberOfTravelers']!.text) ?? 0,
                'rating': 0.0,
                'createdAt': Timestamp.now(),
              };

              _addNewPolicy(newPolicy).then((_) {
                Navigator.pop(context);
                setState(() {});
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

extension StringExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
