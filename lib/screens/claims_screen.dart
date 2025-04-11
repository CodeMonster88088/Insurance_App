import 'package:flutter/material.dart';

class ClaimsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File a Claim'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submit a New Claim',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            _buildClaimTypeCard(
              icon: Icons.medical_services,
              title: 'Medical Claim',
              subtitle: 'Submit claims for medical treatments',
              color: Colors.blue,
              onTap: () {
                _showClaimForm(context, 'Medical');
              },
            ),
            SizedBox(height: 16),
            _buildClaimTypeCard(
              icon: Icons.local_hospital,
              title: 'Hospitalization',
              subtitle: 'Claims for hospital stays',
              color: Colors.red,
              onTap: () {
                _showClaimForm(context, 'Hospitalization');
              },
            ),
            SizedBox(height: 16),
            _buildClaimTypeCard(
              icon: Icons.medication,
              title: 'Prescription',
              subtitle: 'Claims for medications',
              color: Colors.green,
              onTap: () {
                _showClaimForm(context, 'Prescription');
              },
            ),
            SizedBox(height: 30),
            Text(
              'My Claim History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 10),
            _buildClaimHistoryItem(
              status: 'Approved',
              amount: '\$250.00',
              date: 'May 15, 2023',
              type: 'Medical',
            ),
            _buildClaimHistoryItem(
              status: 'Processing',
              amount: '\$1,200.00',
              date: 'June 2, 2023',
              type: 'Hospitalization',
            ),
            _buildClaimHistoryItem(
              status: 'Rejected',
              amount: '\$45.00',
              date: 'April 10, 2023',
              type: 'Prescription',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          )),
      ),
    );
  }

  Widget _buildClaimHistoryItem({
    required String status,
    required String amount,
    required String date,
    required String type,
  }) {
    Color statusColor = Colors.grey;
    if (status == 'Approved') statusColor = Colors.green;
    if (status == 'Rejected') statusColor = Colors.red;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Amount: $amount',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            Text(
              'Date: $date',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClaimForm(BuildContext context, String claimType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Submit $claimType Claim',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Policy Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                Text('Upload Supporting Documents'),
                SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement file upload
                      },
                      icon: Icon(Icons.attach_file),
                      label: Text('Attach Files'),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$claimType claim submitted successfully!'),
                        ),
                      );
                    },
                    child: Text('Submit Claim'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}