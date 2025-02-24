import 'package:flutter/material.dart';
import 'screens/insurance_search_filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsuranceSearchFilter(),
    );
  }
}