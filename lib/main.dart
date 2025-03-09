import 'package:flutter/material.dart';
import 'package:flutter_app_test/data/sample_data.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
import 'package:intl/intl.dart';
import 'home.dart'; // Import the homepage
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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
  int _numberOfTravelers = 1;
  String? _selectedProvider;
  String? _selectedRegion;
  bool _isLoading = false;
  List<InsuranceModel> _filteredResults = [];
  String _searchQuery = "";

  // Define currency for each region
  final Map<String, String> _regionCurrency = {
    'Europe': 'EUR',
    'Middle East': 'BHD',
    'Asia': 'INR',
    'Africa': 'USD',
    'North America': 'USD',
    'South America': 'USD',
  };

  // Define price ranges for each region
  final Map<String, List<String>> _regionPriceRanges = {
    'Europe': ["0-50 EUR", "50-100 EUR", "100-150 EUR", "150-200 EUR"],
    'Middle East': ["0-50 BHD", "50-100 BHD", "100-150 BHD"],
    'Asia': ["0-50 INR", "50-100 INR"],
    'Africa': ["0-50 USD", "50-100 USD", "100-150 USD"],
    'North America': ["0-50 USD", "50-100 USD", "100-150 USD", "150-200 USD", "200+ USD"],
    'South America': ["0-50 USD", "50-100 USD", "100-150 USD"],
  };
  List<String> _priceRanges = [];
  String? _selectedPriceRange;

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  final List<String> providers = [
    "All",
    "Insurance Co. A",
    "Insurance Co. B",
    "Insurance Co. C",
    "Insurance Co. D"
  ];
  final List<String> regions = [
    'Europe',
    'Middle East',
    'Asia',
    'Africa',
    'North America',
    'South America'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize price ranges based on the default region (if any)
    if (_selectedRegion != null) {
      _priceRanges = _regionPriceRanges[_selectedRegion!] ?? [];
    }
  }

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
      _numberOfTravelers = 1;
      _selectedProvider = null;
      _selectedRegion = null;
      _selectedPriceRange = null;
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
      final matchesDestination = _destinationController.text.isEmpty ||
          insurance.destination
              .toLowerCase()
              .contains(_destinationController.text.toLowerCase());

      final matchesDuration = _durationController.text.isEmpty ||
          insurance.duration == int.tryParse(_durationController.text);

      final matchesRegion = _selectedRegion == null ||
          insurance.region.toLowerCase() == _selectedRegion!.toLowerCase();

      final matchesProvider = _selectedProvider == null ||
          insurance.provider.toLowerCase() == _selectedProvider!.toLowerCase();

      final matchesFromDate = _fromDate == null ||
          insurance.fromDate.isAtSameMomentAs(_fromDate!) ||
          insurance.fromDate.isAfter(_fromDate!);
      final matchesToDate = _toDate == null ||
          insurance.toDate.isAtSameMomentAs(_toDate!) ||
          insurance.toDate.isBefore(_toDate!);

      final matchesTravelers = _numberOfTravelers == 1 ||
          insurance.numberOfTravelers >= _numberOfTravelers;

      // Filter by selected price range
      final matchesPrice = _selectedPriceRange == null ||
          _isPriceInRange(insurance.price, _selectedPriceRange!);

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

  // Helper function to check if the price is within the selected range
  bool _isPriceInRange(double price, String range) {
    final currency = _regionCurrency[_selectedRegion] ?? 'USD'; // Default to USD
    final rangeValues = range.replaceAll(currency, '').split('-');
    final minPrice = double.tryParse(rangeValues[0]) ?? 0;
    final maxPrice = rangeValues[1].endsWith('+')
        ? double.infinity
        : double.tryParse(rangeValues[1]) ?? double.infinity;

    return price >= minPrice && price <= maxPrice;
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

            // Region Dropdown
            DropdownButtonFormField<String>(
              value: _selectedRegion,
              hint: const Text("Select Region"),
              items: regions.map((region) {
                return DropdownMenuItem(value: region, child: Text(region));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                  // Update price ranges based on the selected region
                  _priceRanges = _regionPriceRanges[value!] ?? [];
                  _selectedPriceRange = null; // Reset selected price range
                });
              },
            ),

            const SizedBox(height: 10),

            // Price Range Combo Box
            DropdownButtonFormField<String>(
              value: _selectedPriceRange,
              hint: const Text("Select Price Range"),
              items: _priceRanges.map((range) {
                return DropdownMenuItem(value: range, child: Text(range));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriceRange = value;
                });
              },
            ),

            const SizedBox(height: 10),

            // Provider Dropdown
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              hint: const Text("Select Insurance Provider"),
              items: providers.map((provider) {
                return DropdownMenuItem(value: provider, child: Text(provider));
              }).toList(),
              onChanged: (value) => setState(() => _selectedProvider = value),
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
                  ? Center(
                      child: CircularProgressIndicator(), // Show loading indicator
                    )
                  : _filteredResults.isEmpty
                      ? Center(
                          child: Text(
                              "No results found. Try adjusting your filters."), // No results message
                        )
                      : ListView.builder(
                          itemCount: _filteredResults.length,
                          itemBuilder: (context, index) {
                            final insurance = _filteredResults[index];
                            return InsuranceListItem(
                              insurance: insurance,
                              currency: _regionCurrency[_selectedRegion] ?? 'USD', // Pass currency
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

// Custom Widget for Insurance List Item
class InsuranceListItem extends StatelessWidget {
  final InsuranceModel insurance;
  final String currency;

  const InsuranceListItem({
    required this.insurance,
    required this.currency,
    Key? key,
  }) : super(key: key);

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
            Text('Price: ${insurance.price.toStringAsFixed(2)} $currency'), // Display price with currency
          ],
        ),
      ),
    );
  }
}


