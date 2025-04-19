import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyPoliciesView extends StatefulWidget {
  @override
  _CompanyPoliciesViewState createState() => _CompanyPoliciesViewState();
}

class _CompanyPoliciesViewState extends State<CompanyPoliciesView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _policies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPolicies();
  }

  Future<void> _fetchPolicies() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('policies')
          .where('status', isEqualTo: 'pending')
          .get();

      List<Map<String, dynamic>> policies = [];
      for (var doc in snapshot.docs) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(doc['userId'])
            .get();
        
        if (userDoc.exists) {
          policies.add({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
            'userData': userDoc.data() as Map<String, dynamic>,
          });
        }
      }

      setState(() {
        _policies = policies;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching policies: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading policies: $e')),
      );
    }
  }

  Future<void> _updatePolicyStatus(String policyId, String status) async {
    try {
      await _firestore
          .collection('policies')
          .doc(policyId)
          .update({'status': status});
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Policy status updated to $status')),
      );
      
      _fetchPolicies();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update policy: $e')),
      );
    }
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy) {
    final userData = policy['userData'] ?? {};
    final policyData = policy;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          'Policy #${policyData['policyNumber'] ?? 'N/A'}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'User: ${userData['fullName'] ?? 'Unknown'} | Status: ${policyData['status'] ?? 'unknown'}',
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Information Section
                _buildSectionHeader('Personal Information'),
                _buildInfoRow('Full Name', userData['fullName']),
                _buildInfoRow('Email', userData['email']),
                _buildInfoRow('Phone', userData['phone']),
                _buildInfoRow('Date of Birth', userData['dob']),
                _buildInfoRow('Gender', userData['gender']),
                _buildInfoRow('Nationality', userData['nationality']),
                _buildInfoRow('ID Type', userData['idType']),
                _buildInfoRow('ID Number', userData['idNumber']),
                _buildInfoRow('ID Expiry', userData['idExpiry']),
                SizedBox(height: 16),

                // Address Information
                _buildSectionHeader('Address Information'),
                _buildInfoRow('Address Line 1', userData['addressLine1']),
                _buildInfoRow('Address Line 2', userData['addressLine2']),
                _buildInfoRow('City', userData['city']),
                _buildInfoRow('State/Province', userData['state']),
                _buildInfoRow('Postal Code', userData['postalCode']),
                _buildInfoRow('Country', userData['country']),
                SizedBox(height: 16),

                // Employment Information
                _buildSectionHeader('Employment Information'),
                _buildInfoRow('Occupation', userData['occupation']),
                _buildInfoRow('Employer Name', userData['employerName']),
                _buildInfoRow('Annual Income', userData['annualIncome']),
                _buildInfoRow('Employment Status', userData['employmentStatus']),
                SizedBox(height: 16),

                // Policy Details
                _buildSectionHeader('Policy Details'),
                _buildInfoRow('Policy Type', policyData['policyType']),
                _buildInfoRow('Coverage Amount', 
                  policyData['coverageAmount'] != null 
                    ? '\$${policyData['coverageAmount']}' 
                    : 'N/A'),
                _buildInfoRow('Premium Amount', 
                  policyData['premiumAmount'] != null 
                    ? '\$${policyData['premiumAmount']}' 
                    : 'N/A'),
                _buildInfoRow('Start Date', policyData['startDate']),
                _buildInfoRow('End Date', policyData['endDate']),
                _buildInfoRow('Payment Frequency', policyData['paymentFrequency']),
                SizedBox(height: 16),

                // Documents Section
                if (policyData['documents'] != null && (policyData['documents'] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Attached Documents'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (policyData['documents'] as List).map<Widget>((doc) {
                          return ActionChip(
                            label: Text(doc['name'] ?? 'Document'),
                            onPressed: () {
                              // Implement document viewing
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),

                // Approval Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Changed from primary to backgroundColor
                      ),
                      onPressed: () => _updatePolicyStatus(policy['id'], 'rejected'),
                      child: Text('Reject'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Changed from primary to backgroundColor
                      ),
                      onPressed: () => _updatePolicyStatus(policy['id'], 'active'),
                      child: Text('Approve'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? 'Not provided'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Approvals'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchPolicies,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _policies.isEmpty
              ? Center(child: Text('No pending policies to review'))
              : RefreshIndicator(
                  onRefresh: _fetchPolicies,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: _policies.length,
                    itemBuilder: (context, index) {
                      return _buildPolicyCard(_policies[index]);
                    },
                  ),
                ),
    );
  }
}