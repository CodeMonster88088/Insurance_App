import 'package:flutter/material.dart';
import '../data/sample_data.dart'; // Ensure this file uses InsuranceModel
import '../widgets/insurance_list_item.dart';
import '../models/insurance_model.dart'; // Import the InsuranceModel

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
  List<InsuranceModel> _filteredData = []; // Use InsuranceModel here

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fromDate) {
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
    if (picked != null && picked != _toDate) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _filteredData = filterInsuranceData(
          fromDate: _fromDate,
          toDate: _toDate,
          numberOfTravelers: _numberOfTravelers,
          maxPrice: _maxPrice,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Search Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  // Number of Travelers
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Number of Travelers'),
                    keyboardType: TextInputType.number,
                    initialValue: _numberOfTravelers.toString(),
                    onChanged: (value) {
                      setState(() {
                        _numberOfTravelers = int.tryParse(value) ?? 1;
                      });
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
                    },
                  ),
                  Text('Max Price: ${_maxPrice.toStringAsFixed(2)} BHD'),
                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
            // Display Filtered Results
            Expanded(
              child: ListView.builder(
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