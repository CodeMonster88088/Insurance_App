import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/insurance_model.dart';
import '../screens/policy_document_screen.dart';

class ActivePoliciesScreen extends StatefulWidget {
  @override
  _ActivePoliciesScreenState createState() => _ActivePoliciesScreenState();
}

class _ActivePoliciesScreenState extends State<ActivePoliciesScreen> {
  List<InsuranceModel> activePolicies = [
    InsuranceModel(
      id: 12345,
      provider: 'Gulf Insurance',
      coverageAmount: 50000,
      duration: 30,
      region: 'Worldwide',
      price: 120.0,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: 'Active',
      familyMembers: ['Spouse', 'Child 1'],
      numberOfTravelers: 2,
      coverageType: 'Comprehensive',
    ),
    InsuranceModel(
      id: 789012,
      provider: 'Takaful Insurance',
      coverageAmount: 100000,
      duration: 15,
      region: 'Schengen',
      price: 85.0,
      startDate: DateTime.now().subtract(Duration(days: 10)),
      endDate: DateTime.now().add(Duration(days: 5)),
      status: 'Active',
      familyMembers: [],
      numberOfTravelers: 1,
      coverageType: 'Basic',
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

  Widget _buildPolicyCard(InsuranceModel policy, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PolicyDocumentScreen(policy: policy),
            ),
          );
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
                    policy.provider,
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
              _buildPolicyDetailRow('Policy Number', policy.id.toString()),
              _buildPolicyDetailRow('Coverage', '${policy.coverageAmount} BHD'),
              _buildPolicyDetailRow('Duration', '${policy.duration} days'),
              _buildPolicyDetailRow('Coverage Region', policy.region),
              _buildPolicyDetailRow('Coverage Type', policy.coverageType),
              _buildPolicyDetailRow('Travelers', policy.numberOfTravelers.toString()),
              _buildPolicyDetailRow(
                'Period',
                '${DateFormat('MMM dd, yyyy').format(policy.startDate)} - ${DateFormat('MMM dd, yyyy').format(policy.endDate)}',
              ),
              if (policy.familyMembers.isNotEmpty) ...[
                SizedBox(height: 8),
                _buildPolicyDetailRow('Family Members', policy.familyMembers.join(', ')),
              ],
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

  void _showPolicyActions(InsuranceModel policy, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Download Policy Document'),
                onTap: () {
                  Navigator.pop(context);
                  _downloadPolicy(policy);
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email Policy Document'),
                onTap: () {
                  Navigator.pop(context);
                  _emailPolicy(policy);
                },
              ),
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
                    _confirmCancelPolicy(policy, index);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _downloadPolicy(InsuranceModel policy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading policy document...')),
    );
  }

  void _emailPolicy(InsuranceModel policy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending policy document to your email...')),
    );
  }

  void _fileClaim(InsuranceModel policy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirecting to claims form...')),
    );
  }

  void _confirmCancelPolicy(InsuranceModel policy, int index) {
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
      activePolicies[index].status = 'Cancelled';
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
              title: Text('Expired Policies'),
              value: false,
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