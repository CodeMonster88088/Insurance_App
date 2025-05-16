import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
import 'package:flutter_app_test/models/user_model';
import 'package:flutter_app_test/screens/payment_screen.dart';
import 'package:intl/intl.dart';

final List<String> countries = [
  "Bahrain",
  "Saudi Arabia",
  "United Arab Emirates",
  "Kuwait",
  "Oman",
  "Qatar",
  "Egypt",
  "Jordan",
  "Lebanon",
  "USA",
  "UK",
].toSet().toList();

class ActivatePolicyScreen extends StatefulWidget {
  final InsuranceModel insurance;
  final UserModel user;  // <-- Add user here

  const ActivatePolicyScreen({
    required this.insurance,
    required this.user,  // <-- Add user to constructor
    Key? key,
  }) : super(key: key);

  @override
  State<ActivatePolicyScreen> createState() => _ActivatePolicyScreenState();
}

class _ActivatePolicyScreenState extends State<ActivatePolicyScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<Map<String, dynamic>> _travelers = [];
  bool _isLoading = false;
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    _travelers = [
      {
        'name': '',
        'passportNumber': '',
        'nationality': null,
        'dateOfBirth': null,
      }
    ];
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _travelers[index]['dateOfBirth'] = picked;
      });
    }
  }

  void _addTraveler() {
    if (_travelers.length >= widget.insurance.numberOfTravelers) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have reached the maximum number of travelers.')),
      );
      return;
    }
    setState(() {
      _travelers.add({
        'name': '',
        'passportNumber': '',
        'nationality': null,
        'dateOfBirth': null,
      });
    });
  }

  void _removeTraveler(int index) {
    setState(() {
      _travelers.removeAt(index);
    });
  }

  void _activatePolicy() async {
    if (!_formKey.currentState!.validate()) return;

    if (_travelers.any((t) => t['dateOfBirth'] == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of birth for all travelers')),
      );
      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          User: widget.user,
          insurance: widget.insurance,
          travelers: _travelers,
          totalAmount: widget.insurance.price * _travelers.length,
          familyMembers: _travelers.map((t) => t['name'] as String).toList(),
          onPaymentSuccess: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Successful!')),
            );
          },
        ),
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activate Policy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Need Help?"),
                  content: const Text(
                      "Fill in all traveler details to activate your policy. You'll be able to review and pay on the next screen."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Policy Summary", style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Text("Provider: ${widget.insurance.provider}"),
                        Text("Duration: ${widget.insurance.duration} days"),
                        Text("Region: ${widget.insurance.region}"),
                        Text("Travelers: ${widget.insurance.numberOfTravelers}"),
                        Text("Price: ${widget.insurance.price.toStringAsFixed(2)} BHD"),
                        const Divider(),
                        Text(
                          "Total for ${_travelers.length} traveler(s): ${(widget.insurance.price * _travelers.length).toStringAsFixed(2)} BHD",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (widget.insurance.region != "Domestic")
                  Card(
                    elevation: 2,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.assignment, color: Colors.blue),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Visa Requirements", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Check if you need a visa for ${widget.insurance.region}",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Visa Requirements"),
                                  content: const Text(
                                      "Based on your destination, you may need a visa. Please check with the embassy for the most current requirements."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text("Check"),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),
                const Text("Traveler Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _travelers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Traveler ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                if (index > 0)
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeTraveler(index),
                                  ),
                              ],
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: "Full Name", hintText: "As per passport"),
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Please enter traveler name' : null,
                              onChanged: (value) => _travelers[index]['name'] = value,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(labelText: "Passport Number", hintText: "Enter passport number"),
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Please enter passport number' : null,
                              onChanged: (value) => _travelers[index]['passportNumber'] = value,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(labelText: "Nationality"),
                              value: _travelers[index]['nationality'],
                              items: countries.map((country) => DropdownMenuItem(
                                value: country,
                                child: Text(country),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _travelers[index]['nationality'] = value;
                                });
                              },
                              validator: (value) => value == null ? 'Please select nationality' : null,
                            ),
                            ListTile(
                              title: Text(
                                _travelers[index]['dateOfBirth'] == null
                                    ? "Date of Birth"
                                    : "DOB: ${DateFormat('yyyy-MM-dd').format(_travelers[index]['dateOfBirth'])}",
                              ),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: () => _selectDate(context, index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                Center(
                  child: TextButton(
                    onPressed: _addTraveler,
                    child: const Text("+ Add Another Traveler"),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                    ),
                    const Expanded(
                      child: Text("I agree to the terms and conditions and privacy policy", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _activatePolicy,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("PROCEED TO PAYMENT"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}