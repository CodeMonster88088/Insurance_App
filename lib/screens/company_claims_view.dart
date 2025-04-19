import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CompanyClaimsView(),
  ));
}

class CompanyClaimsView extends StatelessWidget {
  // Mock data for claims
  final List<Map<String, dynamic>> claims = [
    {
      'claimNumber': 'CL-2023-1001',
      'status': 'pending',
      'claimType': 'Medical',
      'claimAmount': 1250.00,
      'incidentDate': '2023-05-15',
      'policyHolder': 'John Smith',
      'policyNumber': 'POL-1001',
      'description': 'Emergency room visit for severe headache'
    },
    {
      'claimNumber': 'CL-2023-1002',
      'status': 'approved',
      'claimType': 'Auto',
      'claimAmount': 3250.00,
      'incidentDate': '2023-06-22',
      'policyHolder': 'Sarah Johnson',
      'policyNumber': 'POL-1002',
      'description': 'Rear-end collision at traffic light'
    },
    {
      'claimNumber': 'CL-2023-1003',
      'status': 'rejected',
      'claimType': 'Property',
      'claimAmount': 8500.00,
      'incidentDate': '2023-07-10',
      'policyHolder': 'Michael Brown',
      'policyNumber': 'POL-1003',
      'description': 'Water damage from burst pipes'
    },
    {
      'claimNumber': 'CL-2023-1004',
      'status': 'processing',
      'claimType': 'Travel',
      'claimAmount': 1200.00,
      'incidentDate': '2023-08-05',
      'policyHolder': 'Emily Davis',
      'policyNumber': 'POL-1004',
      'description': 'Cancelled flight due to weather'
    },
  ];

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'processing':
        return Colors.orange;
      default: // pending
        return Colors.blue;
    }
  }

  // Build individual claim card
  Widget _buildClaimCard(Map<String, dynamic> claim, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected claim ${claim['claimNumber']}')),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Claim number and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Claim #${claim['claimNumber']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(claim['status']).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(claim['status']),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      claim['status'].toUpperCase(),
                      style: TextStyle(
                        color: _getStatusColor(claim['status']),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              
              // Policy holder info
              _buildInfoRow(Icons.person_outline, claim['policyHolder']),
              SizedBox(height: 8),
              
              // Policy number
              _buildInfoRow(Icons.assignment_outlined, 'Policy #${claim['policyNumber']}'),
              SizedBox(height: 8),
              
              // Incident date
              _buildInfoRow(Icons.calendar_today_outlined, 'Incident: ${claim['incidentDate']}'),
              SizedBox(height: 12),
              
              Divider(height: 1, thickness: 1),
              SizedBox(height: 12),
              
              // Claim details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Type:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    claim['claimType'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '\$${claim['claimAmount'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              
              // Description
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Text(
                claim['description'],
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for info rows with icons
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Insurance Claims',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filter options will appear here')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Search functionality will appear here')),
              );
            },
          ),
        ],
      ),
      body: claims.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No Claims Found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'When claims are submitted, they will appear here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: claims.length,
              itemBuilder: (context, index) {
                return _buildClaimCard(claims[index], context);
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add new claim button pressed')),
          );
        },
      ),
    );
  }
}