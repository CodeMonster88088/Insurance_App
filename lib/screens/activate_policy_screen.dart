import 'package:flutter/material.dart';
import '../models/insurance_model.dart';

class ActivatePolicyScreen extends StatelessWidget {
  final InsuranceModel insurance;

  const ActivatePolicyScreen({required this.insurance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Activate Policy")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activate Insurance Policy",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text("Provider: ${insurance.provider}"),
            Text("Duration: ${insurance.duration} days"),
            Text("Region: ${insurance.region}"),
            Text("Travelers: ${insurance.numberOfTravelers}"),
            Text("Price: ${insurance.price.toStringAsFixed(2)} BHD"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement activated policies list
              },
              child: const Text("Activate Policy"),
            ),
          ],
        ),
      ),
    );
  }
}
