import 'package:flutter/material.dart';
import '../models/insurance_model.dart';

class InsuranceListItem extends StatelessWidget {
  final InsuranceModel insurance;

  const InsuranceListItem({required this.insurance});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(insurance.provider),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${insurance.fromDate.toLocal()}'.split(' ')[0]),
            Text('To: ${insurance.toDate.toLocal()}'.split(' ')[0]),
            Text('Travelers: ${insurance.numberOfTravelers}'),
            Text('Price: ${insurance.price} BHD'),
          ],
        ),
      ),
    );
  }
}