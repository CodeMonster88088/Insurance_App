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
  String? _selectedRegion;
  bool _isLoading = false;

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  final List<String> providers = ["All", "Insurance Co. A", "Insurance Co. B", "Insurance Co. C", "Insurance Co. D"];
  final List<String> regions = ['Europe', 'Middle East', 'Asia', 'Africa', 'North America', 'South America'];

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

  void _clearFilters() {
    setState(() {
      _fromDate = null;
      _toDate = null;
      _priceRange = const RangeValues(20, 100);
      _numberOfTravelers = 1;
      _selectedProvider = null;
      _selectedRegion = null;
      _destinationController.clear();
      _durationController.clear();
    });
  }

  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay (replace with actual search logic)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    String destination = _destinationController.text;
    String duration = _durationController.text;

    // Check if at least one filter is applied
    final hasFilters = destination.isNotEmpty ||
        duration.isNotEmpty ||
        _selectedRegion != null ||
        _selectedProvider != null ||
        _fromDate != null ||
        _toDate != null ||
        _numberOfTravelers != 1 ||
        _priceRange != const RangeValues(20, 100);

    if (hasFilters) {
      // Perform your search logic here
      print('Destination: $destination');
      print('Duration: $duration');
      print('Selected Region: $_selectedRegion');
      print('Selected Provider: $_selectedProvider');
      print('From Date: $_fromDate');
      print('To Date: $_toDate');
      print('Number of Travelers: $_numberOfTravelers');
      print('Price Range: ${_priceRange.start} - ${_priceRange.end}');
    } else {
      // Show an error message if no filters are applied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please apply at least one filter!')),
      );
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
                    : "From: ${DateFormat('yyyy-MM-dd').format(_fromDate!)} - To: ${DateFormat('yyyy-MM-dd').format(_toDate!)}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDateRange,
            ),

            // Number of Travelers Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Number of Travelers"),
                Slider(
                  value: _numberOfTravelers.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: '$_numberOfTravelers Travelers',
                  onChanged: (value) {
                    setState(() {
                      _numberOfTravelers = value.toInt();
                    });
                  },
                ),
                Text('Selected: $_numberOfTravelers Travelers'),
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
                Text('Selected: ${_priceRange.start.toStringAsFixed(2)} - ${_priceRange.end.toStringAsFixed(2)} BHD'),
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

            // Search and Clear Filters Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _performSearch,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Search"),
                ),
                ElevatedButton(
                  onPressed: _clearFilters,
                  child: const Text("Clear Filters"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}