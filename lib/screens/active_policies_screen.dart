import 'package:flutter/material.dart';
import '../models/insurance_model.dart';

class ActivePoliciesScreen extends StatefulWidget {
  @override
  _ActivePoliciesScreenState createState() => _ActivePoliciesScreenState();
}

class _ActivePoliciesScreenState extends State<ActivePoliciesScreen> {
  List<InsuranceModel> activePolicies = []; // Store active policies

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Active Policies")),
      body: activePolicies.isEmpty
          ? const Center(child: Text("No active policies."))
          : ListView.builder(
              itemCount: activePolicies.length,
              itemBuilder: (context, index) {
                final policy = activePolicies[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(policy.provider),
                    subtitle: Text("Duration: ${policy.duration} days"),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          activePolicies.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
