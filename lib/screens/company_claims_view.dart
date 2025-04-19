import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CompanyClaimsView extends StatefulWidget {
  @override
  _CompanyClaimsViewState createState() => _CompanyClaimsViewState();
}

class _CompanyClaimsViewState extends State<CompanyClaimsView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _claims = [];
  bool _isLoading = true;
  String _filterStatus = 'all'; // 'all', 'pending', 'approved', 'rejected'

  @override
  void initState() {
    super.initState();
    _fetchClaims();
  }

  Future<void> _fetchClaims() async {
    try {
      Query query = _firestore.collection('claims');

      if (_filterStatus != 'all') {
        query = query.where('status', isEqualTo: _filterStatus);
      }

      QuerySnapshot snapshot = await query
          .orderBy('submittedDate', descending: true)
          .get();

      List<Map<String, dynamic>> claims = [];
      for (var doc in snapshot.docs) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(doc['userId'])
            .get();
        
        DocumentSnapshot policyDoc = await _firestore
            .collection('policies')
            .doc(doc['policyId'])
            .get();

        if (userDoc.exists && policyDoc.exists) {
          claims.add({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
            'userData': userDoc.data() as Map<String, dynamic>,
            'policyData': policyDoc.data() as Map<String, dynamic>,
          });
        }
      }

      setState(() {
        _claims = claims;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching claims: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading claims: $e')),
      );
    }
  }

  Future<void> _updateClaimStatus(String claimId, String status, [String? notes]) async {
    try {
      await _firestore
          .collection('claims')
          .doc(claimId)
          .update({
            'status': status,
            'processedDate': FieldValue.serverTimestamp(),
            'processedBy': 'admin_user_id', // Replace with actual admin ID
            if (notes != null) 'adminNotes': notes,
          });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Claim status updated to $status')),
      );
      
      _fetchClaims();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update claim: $e')),
      );
    }
  }

  void _showStatusDialog(String claimId, String currentStatus) {
    String? notes;
    String? selectedStatus = currentStatus;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Claim Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: [
                  'pending',
                  'under_review',
                  'approved',
                  'rejected',
                  'paid',
                  'closed'
                ].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) => selectedStatus = value,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => notes = value,
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
                if (selectedStatus != null) {
                  _updateClaimStatus(claimId, selectedStatus!, notes);
                  Navigator.pop(context);
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildClaimCard(Map<String, dynamic> claim) {
    final userData = claim['userData'] ?? {};
    final policyData = claim['policyData'] ?? {};
    final claimData = claim;

    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final submittedDate = (claimData['submittedDate'] as Timestamp?)?.toDate();
    final processedDate = (claimData['processedDate'] as Timestamp?)?.toDate();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          'Claim #${claimData['claimNumber'] ?? 'N/A'}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User: ${userData['fullName'] ?? 'Unknown'}'),
            Text('Status: ${_getStatusChip(claimData['status'])}'),
            if (submittedDate != null)
              Text('Submitted: ${dateFormat.format(submittedDate)}'),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Claim Summary
                _buildSectionHeader('Claim Summary'),
                _buildInfoRow('Claim Type', claimData['claimType']),
                _buildInfoRow('Claim Amount', 
                  claimData['claimAmount'] != null 
                    ? '\$${claimData['claimAmount'].toStringAsFixed(2)}' 
                    : 'N/A'),
                _buildInfoRow('Description', claimData['description']),
                SizedBox(height: 16),

                // Policy Information
                _buildSectionHeader('Policy Information'),
                _buildInfoRow('Policy Number', policyData['policyNumber']),
                _buildInfoRow('Policy Type', policyData['policyType']),
                _buildInfoRow('Coverage Amount', 
                  policyData['coverageAmount'] != null 
                    ? '\$${policyData['coverageAmount']}' 
                    : 'N/A'),
                SizedBox(height: 16),

                // Incident Details
                _buildSectionHeader('Incident Details'),
                _buildInfoRow('Incident Date', 
                  claimData['incidentDate'] != null 
                    ? dateFormat.format((claimData['incidentDate'] as Timestamp).toDate()) 
                    : 'N/A'),
                _buildInfoRow('Incident Location', claimData['incidentLocation']),
                _buildInfoRow('Incident Description', claimData['incidentDescription']),
                SizedBox(height: 16),

                // Supporting Documents
                if (claimData['documents'] != null && (claimData['documents'] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Supporting Documents'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (claimData['documents'] as List).map<Widget>((doc) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Icon(Icons.insert_drive_file, size: 40),
                                  Text(doc['name'] ?? 'Document'),
                                  Text(
                                    doc['type'] ?? '',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),

                // Processing Information
                if (processedDate != null || claimData['adminNotes'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Processing Information'),
                      if (processedDate != null)
                        _buildInfoRow('Processed Date', dateFormat.format(processedDate)),
                      if (claimData['processedBy'] != null)
                        _buildInfoRow('Processed By', claimData['processedBy']),
                      if (claimData['adminNotes'] != null)
                        _buildInfoRow('Admin Notes', claimData['adminNotes']),
                      SizedBox(height: 16),
                    ],
                  ),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => _showStatusDialog(claim['id'], claimData['status']),
                      child: Text('Update Status'),
                    ),
                    if (claimData['status'] == 'pending' || claimData['status'] == 'under_review')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () => _updateClaimStatus(claim['id'], 'approved'),
                        child: Text('Approve'),
                      ),
                    if (claimData['status'] == 'pending' || claimData['status'] == 'under_review')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => _showStatusDialog(claim['id'], 'rejected'),
                        child: Text('Reject'),
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

  Widget _getStatusChip(String? status) {
    Color color;
    switch (status) {
      case 'approved':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      case 'paid':
        color = Colors.blue;
        break;
      case 'under_review':
        color = Colors.orange;
        break;
      case 'closed':
        color = Colors.grey;
        break;
      default: // pending
        color = Colors.amber;
    }

    return Chip(
      label: Text(
        status?.replaceAll('_', ' ')?.toUpperCase() ?? 'UNKNOWN',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
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
            width: 150,
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
        title: Text('Claim Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchClaims,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => _filterStatus = value);
              _fetchClaims();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Text('All Claims'),
              ),
              PopupMenuItem(
                value: 'pending',
                child: Text('Pending Claims'),
              ),
              PopupMenuItem(
                value: 'under_review',
                child: Text('Under Review'),
              ),
              PopupMenuItem(
                value: 'approved',
                child: Text('Approved Claims'),
              ),
              PopupMenuItem(
                value: 'rejected',
                child: Text('Rejected Claims'),
              ),
              PopupMenuItem(
                value: 'paid',
                child: Text('Paid Claims'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _claims.isEmpty
              ? Center(child: Text('No claims found'))
              : RefreshIndicator(
                  onRefresh: _fetchClaims,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: _claims.length,
                    itemBuilder: (context, index) {
                      return _buildClaimCard(_claims[index]);
                    },
                  ),
                ),
    );
  }
}