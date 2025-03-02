import 'package:flutter/material.dart';
import '../data/sample_data.dart'; // Ensure this file contains `sampleInsuranceData`
import '../widgets/insurance_list_item.dart';
import '../models/insurance_model.dart';
import '../data/sample_data.dart'; // Ensure this file contains sampleInsuranceData

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
  List<InsuranceModel> _filteredData = sampleInsuranceData; // Default to all data
  String _searchQuery = "";

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
      setState(() {
        _toDate = picked;
      });
    }
  }

  void _applyFilters() {
    List<InsuranceModel> filteredResults = filterInsuranceData(
      fromDate: _fromDate,
      toDate: _toDate,
      numberOfTravelers: _numberOfTravelers,
      maxPrice: _maxPrice,
    );

    // Apply search query on top of filters
    if (_searchQuery.isNotEmpty) {
      filteredResults = filteredResults
          .where((insurance) =>
              insurance.provider.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredData = filteredResults;
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
                        : 'From: ${_fromDate!.toLocal()}'.split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectFromDate(context),
                  ),
                  // To Date Picker
                  ListTile(
                    title: Text(_toDate == null
                        ? 'Select To Date'
                        : 'To: ${_toDate!.toLocal()}'.split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectToDate(context),
                  ),
                  // Number of Travelers Dropdown
                  DropdownButton<int>(
                    value: _numberOfTravelers,
                    items: List.generate(10, (index) => index + 1)
                        .map((num) => DropdownMenuItem(
                              value: num,
                              child: Text('$num Travelers'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _numberOfTravelers = value!;
                      });
                      _applyFilters();
                    },
                  ),
                  // Max Price Slider
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
                  // Apply Filters Button
                  ElevatedButton(
                    onPressed: _applyFilters,
                    child: Text('Apply Filters'),
                  ),
                ],
              ),
            ),
            // Display Filtered Results
            Expanded(
              child: _filteredData.isEmpty
                  ? Center(child: Text("No results found"))
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
