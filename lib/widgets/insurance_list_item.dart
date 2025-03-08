import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/insurance_model.dart';

class InsuranceListItem extends StatelessWidget {
  final InsuranceModel insurance;

  const InsuranceListItem({required this.insurance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insurance.provider,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Destination: ${insurance.destination}'),
            Text('Duration: ${insurance.duration} days'),
            Text('Region: ${insurance.region}'),
            Text('From: ${DateFormat('yyyy-MM-dd').format(insurance.fromDate)}'),
            Text('To: ${DateFormat('yyyy-MM-dd').format(insurance.toDate)}'),
            Text('Travelers: ${insurance.numberOfTravelers}'),
            Text('Price: ${insurance.price.toStringAsFixed(2)} BHD'),
          ],
        ),
      ),
    );
  }
}