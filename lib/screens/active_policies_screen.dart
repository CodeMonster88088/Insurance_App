import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/PolicyRequestModel.dart';
import 'package:intl/intl.dart';

class ActivePoliciesScreen extends StatefulWidget {
  @override
  _ActivePoliciesScreenState createState() => _ActivePoliciesScreenState();
}

class _ActivePoliciesScreenState extends State<ActivePoliciesScreen> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Policies'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('policy_requests')
            .where('customerId', isEqualTo: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          List<PolicyRequestModel> policies = snapshot.data!.docs.map((doc) {
            return PolicyRequestModel.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: policies.length,
            itemBuilder: (context, index) =>
                _buildPolicyCard(policies[index], index),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'No Policies Found',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Start by purchasing a travel insurance policy.',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/policies');
            },
            child: Text('Browse Policies'),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(PolicyRequestModel policy, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to policy details screen
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    policy.customerName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Chip(
                    label: Text(
                      policy.status,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _getStatusColor(policy.status),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildPolicyDetailRow('Policy ID', policy.policyId),
              _buildPolicyDetailRow(
                  'Travelers', policy.numberOfTravelers.toString()),
              _buildPolicyDetailRow('Total Price', '${policy.totalPrice} BHD'),
              _buildPolicyDetailRow(
                'Period',
                '${DateFormat('MMM dd, yyyy').format(policy.startDate)} - ${DateFormat('MMM dd, yyyy').format(policy.endDate)}',
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _showPolicyActions(policy),
                    child: Text('ACTIONS'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showPolicyActions(PolicyRequestModel policy) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.receipt),
                title: Text('File a Claim'),
                onTap: () {
                  Navigator.pop(context);
                  _fileClaim(policy);
                },
              ),
              if (policy.status == 'Active')
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.red),
                  title: Text('Cancel Policy',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _confirmCancelPolicy(policy);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _fileClaim(PolicyRequestModel policy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirecting to claims form...')),
    );
  }

  void _confirmCancelPolicy(PolicyRequestModel policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Policy'),
        content: Text(
            'Are you sure you want to cancel this policy? You may be eligible for a partial refund.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelPolicy(policy);
            },
            child: Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelPolicy(PolicyRequestModel policy) async {
    await FirebaseFirestore.instance
        .collection('policy_requests')
        .doc(policy.id)
        .update({'status': 'Cancelled'});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Policy cancelled successfully')),
    );
  }

  void _showFilterOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Policies'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text('Active Policies'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Cancelled Policies'),
              value: false,
              onChanged: (value) {},
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
              // Apply filters here
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Expired':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }
}
