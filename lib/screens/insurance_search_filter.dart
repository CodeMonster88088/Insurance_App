import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/user_model';
import 'package:intl/intl.dart';
import '../models/insurance_model.dart';
import '../data/sample_data.dart';
import '../widgets/insurance_list_item.dart';
import '../utils/constants.dart';

class InsuranceSearchFilter extends StatefulWidget {
  final UserModel user;

  const InsuranceSearchFilter({required this.user, Key? key}) : super(key: key);
  @override
  _InsuranceSearchFilterState createState() => _InsuranceSearchFilterState();
}

class _InsuranceSearchFilterState extends State<InsuranceSearchFilter> {
  @override
  void initState() {
    super.initState();
    _loadDropdownOptions(); // This fetches providers and regions from Firestore
  }

  DateTime? _fromDate;
  DateTime? _toDate;
  RangeValues _priceRange = const RangeValues(1, 1000);
  bool _showPriceFilter = false; // Controls price filter toggle
  int _numberOfTravelers = 1;
  String? _selectedProvider;
  String? _selectedRegion;
  bool _isLoading = false;
  List<InsuranceModel> _filteredResults = [];
  List<String> _providers = [];
  List<String> _regions = [];

  final TextEditingController _durationController = TextEditingController();

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

        // Calculate duration in days
        int duration = _toDate!.difference(_fromDate!).inDays + 1;
        _durationController.text = duration.toString();
      });
    }
  }

  void _clearFilters() {
    setState(() {
      _fromDate = null;
      _toDate = null;
      _priceRange = const RangeValues(1, 100);
      _numberOfTravelers = 1;
      _selectedProvider = null;
      _selectedRegion = null;
      _durationController.clear();
      _filteredResults = [];
    });
  }

  Future<void> _loadDropdownOptions() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('insurance_policies')
          .get();

      final allData = snapshot.docs.map((doc) => doc.data()).toList();

      final providersSet = <String>{};
      final regionsSet = <String>{};

      for (final data in allData) {
        if (data['provider'] != null) providersSet.add(data['provider']);
        if (data['region'] != null) regionsSet.add(data['region'].toString());
      }

      setState(() {
        _providers = providersSet.toList()..sort();
        _regions = regionsSet.toList()..sort();
      });
    } catch (e) {
      print('Error loading dropdown options: $e');
    }
  }

  double _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  void _performSearch({bool showAll = false}) async {
    setState(() => _isLoading = true);

    try {
      Query query = FirebaseFirestore.instance.collection('insurance_policies');

      // if (!showAll) {
      //   query = query.where('status', isNull: true);
      // }

      final querySnapshot = await query.get();
      final allPolicies = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return InsuranceModel(
          id: data['id']?.toString() ?? '',
          provider: data['provider'] ?? '',
          providerId: data['provider_id'] ?? '',
          coverageAmount: _toDouble(data['coverageAmount']),
          duration: _toInt(data['duration']),
          region: data['region']?.toString() ?? '',
          price: _toDouble(data['price']),
          numberOfTravelers: _toInt(data['numberOfTravelers']),
          rating: 0.0,
        );
      }).toList();

      _filteredResults = showAll
          ? allPolicies
          : allPolicies.where((insurance) {
              final matchesDuration = _durationController.text.isEmpty ||
                  insurance.duration == int.tryParse(_durationController.text);

              final matchesRegion = _selectedRegion == null ||
                  insurance.region.toLowerCase() ==
                      _selectedRegion!.toLowerCase();

              final matchesProvider = _selectedProvider == null ||
                  _selectedProvider == "All" ||
                  insurance.provider.toLowerCase() ==
                      _selectedProvider!.toLowerCase();

              final matchesTravelers = _numberOfTravelers == 1 ||
                  insurance.numberOfTravelers >= _numberOfTravelers;

              final matchesPrice = !_showPriceFilter ||
                  (insurance.price >= _priceRange.start &&
                      insurance.price <= _priceRange.end);

              return matchesDuration &&
                  matchesRegion &&
                  matchesProvider &&
                  matchesTravelers &&
                  matchesPrice;
            }).toList();
    } catch (e) {
      print("Error fetching policies: $e");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Travel Insurance'),
        automaticallyImplyLeading: false, // This hides the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 15),
              _buildDateRangePicker(),
              const SizedBox(height: 15),
              _buildSlider("Number of Travelers", _numberOfTravelers, 1, 10,
                  (value) {
                setState(() => _numberOfTravelers = value.toInt());
              }),
              const SizedBox(height: 15),
              _buildPriceRangeSlider(),
              const SizedBox(height: 15),
              _buildDropdown(
                  "Select Insurance Provider", _selectedProvider, _providers,
                  (value) {
                setState(() => _selectedProvider = value);
              }),
              const SizedBox(height: 15),
              _buildDropdown("Select Region", _selectedRegion, _regions,
                  (value) {
                setState(() => _selectedRegion = value);
              }),
              const SizedBox(height: 20),
              _buildButtonRow(),
              const SizedBox(height: 20),
              _buildAllPoliciesButton(), // Button to show all policies
              const SizedBox(height: 20),
              _buildResultsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllPoliciesButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _performSearch(showAll: true),
      child: const Text("Show All Policies"),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : () => _performSearch(),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Search"),
        ),
        ElevatedButton(
          onPressed: _clearFilters,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Clear Filters"),
        ),
      ],
    );
  }

  Widget _buildResultsList() {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _filteredResults.isEmpty
            ? Center(child: Text("No results found. Adjust your filters."))
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredResults.length,
                itemBuilder: (context, index) => InsuranceListItem(
                  insurance: _filteredResults[index],
                  user: widget.user, // pass the user here
                ),
              );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return ListTile(
      title: Text(
        _fromDate == null || _toDate == null
            ? "Select Date Range"
            : "From: ${DateFormat('yyyy-MM-dd').format(_fromDate!)} - To: ${DateFormat('yyyy-MM-dd').format(_toDate!)}",
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: _selectDateRange,
    );
  }

  Widget _buildSlider(String label, int value, double min, double max,
      ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value.toDouble(),
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: '$value Travelers',
          onChanged: onChanged,
        ),
        Text('Selected: $value Travelers'),
      ],
    );
  }

  Widget _buildPriceRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Enable Price Filter"),
            Switch(
              value: _showPriceFilter,
              onChanged: (value) {
                setState(() {
                  _showPriceFilter = value;
                  if (!_showPriceFilter) {
                    _priceRange =
                        const RangeValues(1, 1000); // Reset if disabled
                  }
                });
              },
            ),
          ],
        ),
        if (_showPriceFilter) ...[
          const Text("Price Range (BHD)"),
          RangeSlider(
            values: _priceRange,
            min: 1,
            max: 1000,
            divisions: 18,
            labels: RangeLabels(
              "${_priceRange.start.toStringAsFixed(2)} BHD",
              "${_priceRange.end.toStringAsFixed(2)} BHD",
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          Text(
            "Selected: ${_priceRange.start.toStringAsFixed(2)} BHD - ${_priceRange.end.toStringAsFixed(2)} BHD",
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
