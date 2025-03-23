import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/insurance_model.dart';
import '../data/sample_data.dart';
import '../widgets/insurance_list_item.dart';
import '../utils/constants.dart';

class InsuranceSearchFilter extends StatefulWidget {
  @override
  _InsuranceSearchFilterState createState() => _InsuranceSearchFilterState();
}

class _InsuranceSearchFilterState extends State<InsuranceSearchFilter> {
  DateTime? _fromDate;
  DateTime? _toDate;
  RangeValues _priceRange = const RangeValues(20, 200);
    bool _showPriceFilter = false; // Controls price filter toggle
  int _numberOfTravelers = 1;
  String? _selectedProvider;
  String? _selectedRegion;
  bool _isLoading = false;
  List<InsuranceModel> _filteredResults = [];

  final TextEditingController _destinationController = TextEditingController();
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
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    _filteredResults = sampleInsuranceData.where((insurance) {
      final matchesDuration = _durationController.text.isEmpty ||
          insurance.duration == int.tryParse(_durationController.text);

      final matchesRegion = _selectedRegion == null ||
          insurance.region.toLowerCase() == _selectedRegion!.toLowerCase();

      final matchesProvider = _selectedProvider == null ||
          _selectedProvider == "All" || // Allow "All" to include all providers
          insurance.provider.toLowerCase() == _selectedProvider!.toLowerCase();

      final matchesTravelers = _numberOfTravelers == 1 ||
          insurance.numberOfTravelers >= _numberOfTravelers;

      final matchesPrice = insurance.price >= _priceRange.start &&
          insurance.price <= _priceRange.end;

      return matchesDuration &&
          matchesRegion &&
          matchesProvider &&
          matchesTravelers &&
          matchesPrice;
    }).toList();

    setState(() => _isLoading = false);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Travel Insurance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

              // Duration (Read-Only, Auto-Filled)
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duration (Days)',
                  hintText: 'Select a date range to calculate duration',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                readOnly: true,
                onTap: _selectDateRange, // Opens date picker when tapped
              ),
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
                  "Select Insurance Provider", _selectedProvider, providers,
                  (value) {
                setState(() => _selectedProvider = value);
              }),
              const SizedBox(height: 15),

              _buildDropdown("Select Region", _selectedRegion, regions,
                  (value) {
                setState(() => _selectedRegion = value);
              }),
              const SizedBox(height: 20),

              _buildButtonRow(),
              const SizedBox(height: 20),

              _buildResultsList(),
            ],
          ),
        ),
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
                    _priceRange = const RangeValues(20, 200); // Reset if disabled
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
            min: 20,
            max: 200,
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
            "Selected Range: ${_priceRange.start.toStringAsFixed(2)} BHD - ${_priceRange.end.toStringAsFixed(2)} BHD",
          ),
        ],
      ],
    );
  }


  Widget _buildDropdown(String label, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(label),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : _performSearch,
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
                itemBuilder: (context, index) =>
                    InsuranceListItem(insurance: _filteredResults[index]),
              );
  }
}
