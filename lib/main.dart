import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/insurance_search_filter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsuranceSearchFilter(),
    );
  }
}
