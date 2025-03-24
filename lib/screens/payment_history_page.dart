import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PaymentHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> payments = [
    {'date': '2023-10-01', 'amount': 120.0, 'policy': 'Travel Insurance'},
    {'date': '2023-09-01', 'amount': 150.0, 'policy': 'Health Insurance'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('${payment['policy']} - \$${payment['amount']}'),
              subtitle: Text('Date: ${payment['date']}'),
              trailing: Icon(Icons.receipt),
            ),
          ).animate().fadeIn(delay: (index * 200).ms);
        },
      ),
    );
  }
}