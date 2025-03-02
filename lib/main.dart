import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsuranceSearchScreen(),
    );
  }
}

class InsuranceSearchScreen extends StatefulWidget {
  @override
  _InsuranceSearchScreenState createState() => _InsuranceSearchScreenState();
}

class _InsuranceSearchScreenState extends State<InsuranceSearchScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;
  RangeValues _priceRange = const RangeValues(20, 100);
  int _numberOfTravelers = 1;
  String? _selectedProvider;
  String? _selectedRegion;  // Variable to store selected region

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  final List<String> providers = ["All", "Insurance Co. A", "Insurance Co. B", "Insurance Co. C", "Insurance Co. D"];
  final List<String> regions = ['Europe', 'Middle East', 'Asia', 'Africa', 'North America', 'South America']; // List of regions

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Insurance Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Input
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'Enter the destination',
              ),
            ),
            const SizedBox(height: 10),

            // Duration Input
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (Days)',
                hintText: 'Enter the duration of your trip in days',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Date Picker
            ListTile(
              title: Text(
                _fromDate == null || _toDate == null
                    ? "Select Date Range"
                    : "From: ${DateFormat.yMMMd().format(_fromDate!)} - To: ${DateFormat.yMMMd().format(_toDate!)}"
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDateRange,
            ),
            
            // Number of Travelers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Number of Travelers"),
                DropdownButton<int>(
                  value: _numberOfTravelers,
                  items: List.generate(10, (index) => index + 1).map((e) {
                    return DropdownMenuItem(value: e, child: Text(e.toString()));
                  }).toList(),
                  onChanged: (value) => setState(() => _numberOfTravelers = value!),
                ),
              ],
            ),
            
            // Price Range
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Price Range (BHD)"),
                RangeSlider(
                  values: _priceRange,
                  min: 20,
                  max: 200,
                  divisions: 18,
                  labels: RangeLabels("${_priceRange.start}", "${_priceRange.end}"),
                  onChanged: (values) => setState(() => _priceRange = values),
                ),
              ],
            ),

            // Provider Dropdown
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              hint: const Text("Select Insurance Provider"),
              items: providers.map((provider) {
                return DropdownMenuItem(value: provider, child: Text(provider));
              }).toList(),
              onChanged: (value) => setState(() => _selectedProvider = value),
            ),

            const SizedBox(height: 10),

            // Region Dropdown
            DropdownButtonFormField<String>(
              value: _selectedRegion,
              hint: const Text("Select Region"),
              items: regions.map((region) {
                return DropdownMenuItem(value: region, child: Text(region));
              }).toList(),
              onChanged: (value) => setState(() => _selectedRegion = value),
            ),

            const SizedBox(height: 20),
            
            // Search Button
            ElevatedButton(
              onPressed: () {
                String destination = _destinationController.text;
                String duration = _durationController.text;
                
                print('Destination: $destination');
                print('Duration: $duration');
                print('Selected Region: $_selectedRegion');
                print('Selected Provider: $_selectedProvider');
                
                if (destination.isNotEmpty && duration.isNotEmpty && _selectedRegion != null && _selectedProvider != null) {
                  // Perform your search logic here
                } else {
                  // Show message if any field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields!')),
                  );
                }
              },
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
