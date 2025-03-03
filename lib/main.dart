import 'package:flutter/material.dart';
import 'package:flutter_app_test/data/sample_data.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
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
  List<InsuranceModel> _filteredResults = [];

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
      _filteredResults = [];
    });
  }

  void _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay (replace with actual search logic)
    await Future.delayed(const Duration(seconds: 2));

    // Filter the data based on the applied filters
    _filteredResults = sampleInsuranceData.where((insurance) {
      // Filter by destination (if provided)
      final matchesDestination = _destinationController.text.isEmpty ||
          insurance.destination.toLowerCase().contains(_destinationController.text.toLowerCase());

      // Filter by duration (if provided)
      final matchesDuration = _durationController.text.isEmpty ||
          insurance.duration == int.tryParse(_durationController.text);

      // Filter by region (if provided)
      final matchesRegion = _selectedRegion == null ||
          insurance.region.toLowerCase() == _selectedRegion!.toLowerCase();

      // Filter by provider (if provided)
      final matchesProvider = _selectedProvider == null ||
          insurance.provider.toLowerCase() == _selectedProvider!.toLowerCase();

      // Filter by date range (if provided)
      final matchesFromDate = _fromDate == null || insurance.fromDate.isAtSameMomentAs(_fromDate!) || insurance.fromDate.isAfter(_fromDate!);
      final matchesToDate = _toDate == null || insurance.toDate.isAtSameMomentAs(_toDate!) || insurance.toDate.isBefore(_toDate!);

      // Filter by number of travelers (if provided)
      final matchesTravelers = _numberOfTravelers == 1 || insurance.numberOfTravelers >= _numberOfTravelers;

      // Filter by price range (if provided)
      final matchesPrice = insurance.price >= _priceRange.start && insurance.price <= _priceRange.end;

      // Combine all filters
      return matchesDestination &&
             matchesDuration &&
             matchesRegion &&
             matchesProvider &&
             matchesFromDate &&
             matchesToDate &&
             matchesTravelers &&
             matchesPrice;
    }).toList();

    setState(() {
      _isLoading = false;
    });
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

            // Display Filtered Results
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _filteredResults.isEmpty
                      ? Center(child: Text("No results found. Try adjusting your filters."))
                      : ListView.builder(
                          itemCount: _filteredResults.length,
                          itemBuilder: (context, index) {
                            final insurance = _filteredResults[index];
                            return ListTile(
                              title: Text(insurance.provider),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Destination: ${insurance.destination}'),
                                  Text('Duration: ${insurance.duration} days'),
                                  Text('Region: ${insurance.region}'),
                                  Text('From: ${DateFormat('yyyy-MM-dd').format(insurance.fromDate)}'),
                                  Text('To: ${DateFormat('yyyy-MM-dd').format(insurance.toDate)}'),
                                  Text('Travelers: ${insurance.numberOfTravelers}'),
                                  Text('Price: ${insurance.price.toStringAsFixed(2)} BHD'),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}