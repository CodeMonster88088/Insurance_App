import 'package:flutter/material.dart';

class ClaimStatusScreen extends StatefulWidget {
  @override
  _ClaimStatusScreenState createState() => _ClaimStatusScreenState();
}

class _ClaimStatusScreenState extends State<ClaimStatusScreen> {
  // Sample claim data
  Map<String, dynamic> claimData = {
    'claimNumber': 'CL-2023-78945',
    'status': 'Processing',
    'progress': 0.75,
    'lastUpdated': '2023-11-15',
    'estimatedCompletion': '2023-11-20',
    'documentsRequired': ['Police Report', 'Medical Bills', 'ID Proof'],
  };

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getStatusMessage(double progress, String status) {
    if (status.toLowerCase() == 'completed') return 'Claim Processed Successfully';
    if (status.toLowerCase() == 'rejected') return 'Claim Rejected';
    
    final percentage = (progress * 100).toInt();
    return '$status - $percentage% Complete';
  }

  Future<void> _refreshClaimData() async {
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      claimData['lastUpdated'] = DateTime.now().toString().substring(0, 10);
      claimData['progress'] = (claimData['progress'] + 0.1).clamp(0.0, 1.0);
      
      if (claimData['progress'] >= 1.0) {
        claimData['status'] = 'Completed';
      }
    });
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.phone, color: Colors.blue),
            title: Text('Call Support'),
            subtitle: Text('(800) 555-1234'),
            onTap: () {
              Navigator.pop(context);
              _showCallConfirmation(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.blue),
            title: Text('Email Support'),
            subtitle: Text('claims@example.com'),
            onTap: () {
              Navigator.pop(context);
              _showEmailConfirmation(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel, color: Colors.red),
            title: Text('Cancel'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCallConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call Support'),
        content: Text('Would you like to call our support team at (800) 555-1234?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Calling support... (simulated)')),
              );
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void _showEmailConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Support'),
        content: Text('Would you like to email our support team at claims@example.com?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening email client... (simulated)')),
              );
            },
            child: Text('Email'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim Status'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('Refreshing claim status...')),
              );
              
              await _refreshClaimData();
              
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('Claim status updated')),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshClaimData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Claim Status Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Claim #${claimData['claimNumber']}', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: claimData['progress'],
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getStatusColor(claimData['status']),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getStatusMessage(claimData['progress'], claimData['status']),
                        style: TextStyle(
                          color: _getStatusColor(claimData['status']),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildDetailRow('Last Updated', claimData['lastUpdated']),
                      _buildDetailRow('Estimated Completion', claimData['estimatedCompletion']),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Required Documents Section
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Required Documents',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ...claimData['documentsRequired'].map<Widget>((doc) => 
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 20),
                              SizedBox(width: 8),
                              Text(doc),
                            ],
                          ),
                        ),
                      ).toList(),
                    ],
                  ),
                ),
              ),
              
              // Help/Contact Section
              SizedBox(height: 20),
              Text('Need help with your claim?', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showContactOptions(context),
                child: Text('Contact Claims Support'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Changed from primary to backgroundColor
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}