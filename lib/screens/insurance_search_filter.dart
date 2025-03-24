import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/sample_data.dart'; // Ensure this import is present
import '../widgets/insurance_list_item.dart';
import '../models/insurance_model.dart';

class InsuranceSearchFilter extends StatefulWidget {
  @override
  _InsuranceSearchFilterState createState() => _InsuranceSearchFilterState();
}

class _InsuranceSearchFilterState extends State<InsuranceSearchFilter> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fromDate;
  DateTime? _toDate;
  int _numberOfTravelers = 1;
  double _maxPrice = 100.0;
  List<InsuranceModel> _filteredData = sampleInsuranceData;
  String _searchQuery = "";
  bool _isLoading = false;
  String? _selectedRegion;
  bool _showPriceFilter = false;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: _fromDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (_fromDate != null && picked.isBefore(_fromDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('To date must be after or equal to from date')),
        );
      } else {
        setState(() {
          _toDate = picked;
        });
      }
    }
  }

  void _applyFilters() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulate delay

    List<InsuranceModel> filteredResults = filterInsuranceData(
      fromDate: _fromDate,
      toDate: _toDate,
      numberOfTravelers: _numberOfTravelers,
      maxPrice: _maxPrice,
      region: _selectedRegion,
      searchQuery: _searchQuery,
    );

    setState(() {
      _filteredData = filteredResults;
      _isLoading = false;
    });
  }

  void _clearFilters() {
    setState(() {
      _fromDate = null;
      _toDate = null;
      _numberOfTravelers = 1;
      _maxPrice = 100.0;
      _searchQuery = "";
      _selectedRegion = null;
      _filteredData = sampleInsuranceData;
    });
  }

  void _search(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Search & Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search Insurance Provider',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = "";
                          });
                          _applyFilters();
                        },
                      )
                    : null,
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // From Date Picker
                  ListTile(
                    title: Text(_fromDate == null
                        ? 'Select From Date'
                        : 'From: ${DateFormat('yyyy-MM-dd').format(_fromDate!)}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectFromDate(context),
                  ),
                  // To Date Picker
                  ListTile(
                    title: Text(_toDate == null
                        ? 'Select To Date'
                        : 'To: ${DateFormat('yyyy-MM-dd').format(_toDate!)}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectToDate(context),
                  ),
                  // Number of Travelers Dropdown
                  DropdownButton<int>(
                    value: _numberOfTravelers,
                    items: List.generate(10, (index) => index + 1).map((num) {
                      return DropdownMenuItem(value: num, child: Text('$num Travelers'));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _numberOfTravelers = value!;
                      });
                      _applyFilters();
                    },
                  ),
                  // Checkbox to show/hide price filter
                  Row(
                    children: [
                      Checkbox(
                        value: _showPriceFilter,
                        onChanged: (value) {
                          setState(() {
                            _showPriceFilter = value!;
                          });
                        },
                      ),
                      Text('Show Price Filter'),
                    ],
                  ),
                  // Conditionally render the price filter
                  if (_showPriceFilter) ...[
                    Slider(
                      value: _maxPrice,
                      min: 0,
                      max: 500,
                      divisions: 100,
                      label: _maxPrice.toStringAsFixed(2),
                      onChanged: (value) {
                        setState(() {
                          _maxPrice = value;
                        });
                        _applyFilters();
                      },
                    ),
                    Text('Max Price: ${_maxPrice.toStringAsFixed(2)} BHD'),
                  ],
                  // Region Dropdown
                  DropdownButton<String>(
                    value: _selectedRegion,
                    hint: Text('Select Region'),
                    items: ['Europe', 'Middle East', 'Asia', 'Africa', 'North America', 'South America']
                        .map((region) {
                      return DropdownMenuItem(value: region, child: Text(region));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRegion = value;
                      });
                      _applyFilters();
                    },
                  ),
                  // Apply and Clear Filters Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _applyFilters,
                        child: Text('Apply Filters'),
                      ),
                      ElevatedButton(
                        onPressed: _clearFilters,
                        child: Text('Clear Filters'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Display Filtered Results
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _filteredData.isEmpty
                      ? Center(child: Text("No results found. Try adjusting your filters."))
                      : ListView.builder(
                          itemCount: _filteredData.length,
                          itemBuilder: (context, index) {
                            final insurance = _filteredData[index];
                            return InsuranceListItem(insurance: insurance);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}