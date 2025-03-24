import 'package:flutter/material.dart';

class FinancesPage extends StatelessWidget {
  // Dummy payment history data
  final List<Map<String, String>> paymentHistory = [
    {
      'date': '2023-10-01',
      'amount': '\$150.00',
      'status': 'Paid',
      'description': 'Monthly Premium',
    },
    {
      'date': '2023-09-01',
      'amount': '\$150.00',
      'status': 'Paid',
      'description': 'Monthly Premium',
    },
    {
      'date': '2023-08-01',
      'amount': '\$150.00',
      'status': 'Paid',
      'description': 'Monthly Premium',
    },
  ];

  // Dummy upcoming payments data
  final List<Map<String, String>> upcomingPayments = [
    {
      'date': '2023-11-01',
      'amount': '\$150.00',
      'description': 'Monthly Premium',
    },
    {
      'date': '2023-12-01',
      'amount': '\$150.00',
      'description': 'Monthly Premium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finances'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment History Section
            Text(
              'Payment History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            ...paymentHistory.map((payment) => _buildPaymentHistoryItem(payment)).toList(),

            // Upcoming Payments Section
            SizedBox(height: 32),
            Text(
              'Upcoming Payments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            ...upcomingPayments.map((payment) => _buildUpcomingPaymentItem(payment)).toList(),

            // Policy Details Section
            SizedBox(height: 32),
            Text(
              'Policy Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            _buildPolicyDetails(),

            // Payment Methods Section
            SizedBox(height: 32),
            Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            _buildPaymentMethods(),
          ],
        ),
      ),
    );
  }

  // Payment History Item Widget
  Widget _buildPaymentHistoryItem(Map<String, String> payment) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              payment['description']!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${payment['date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Amount: ${payment['amount']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${payment['status']}',
              style: TextStyle(
                fontSize: 14,
                color: payment['status'] == 'Paid' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Upcoming Payment Item Widget
  Widget _buildUpcomingPaymentItem(Map<String, String> payment) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              payment['description']!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${payment['date']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Amount: ${payment['amount']}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Policy Details Widget
  Widget _buildPolicyDetails() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Policy Number: 123456789',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coverage: Comprehensive',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Premium: \$150.00/month',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Payment Methods Widget
  Widget _buildPaymentMethods() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.blue[800]),
              title: Text('Credit Card Ending in 1234'),
              subtitle: Text('Expires 12/25'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[800]),
                onPressed: () {
                  // Add functionality to edit payment method
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.blue[800]),
              title: Text('Bank Account Ending in 5678'),
              subtitle: Text('Checking Account'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[800]),
                onPressed: () {
                  // Add functionality to edit payment method
                },
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                // Add functionality to add a new payment method
              },
              child: Text('Add Payment Method'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}