import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/PolicyRequestModel.dart';
import 'package:intl/intl.dart';

class ActivePoliciesScreen extends StatefulWidget {
  @override
  _ActivePoliciesScreenState createState() => _ActivePoliciesScreenState();
}

class _ActivePoliciesScreenState extends State<ActivePoliciesScreen> {
  List<PolicyRequestModel> activePolicies = [
    PolicyRequestModel(
      id: 'req1',
      policyId: 'pol123',
      providerId: 'provider123',
      customerId: 'user001',
      customerName: 'Ali Abdulrasool',
      status: 'Active',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      numberOfTravelers: 2,
      totalPrice: 120.0,
      region: 'Europe'
    ),
    PolicyRequestModel(
      id: 'req2',
      policyId: 'pol456',
      providerId: 'provider456',
      customerId: 'user002',
      customerName: 'Fatima Ali',
      status: 'Active',
      startDate: DateTime.now().subtract(Duration(days: 10)),
      endDate: DateTime.now().add(Duration(days: 5)),
      numberOfTravelers: 1,
      totalPrice: 85.0,
      region: 'Asia'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Active Policies'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: activePolicies.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: activePolicies.length,
              itemBuilder: (context, index) => _buildPolicyCard(activePolicies[index], index),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to add/browse policies screen
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
            'No Active Policies',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Get started by purchasing a travel insurance policy',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to insurance search
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
          // Navigate to view policy document screen if needed
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
                    backgroundColor: policy.status == 'Active'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildPolicyDetailRow('Policy ID', policy.policyId),
              _buildPolicyDetailRow('Travelers', policy.numberOfTravelers.toString()),
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
                    onPressed: () => _showPolicyActions(policy, index),
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

  void _showPolicyActions(PolicyRequestModel policy, int index) {
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
                  title: Text('Cancel Policy', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    _confirmCancelPolicy(index);
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

  void _confirmCancelPolicy(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Policy'),
        content: Text('Are you sure you want to cancel this policy? You may be eligible for a partial refund.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelPolicy(index);
            },
            child: Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _cancelPolicy(int index) {
    setState(() {
      activePolicies[index] = activePolicies[index].copyWith(status: 'Cancelled');
    });
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
}
