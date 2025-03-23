import 'package:flutter_app_test/data/sample_data.dart';
import '../models/insurance_model.dart';


// Extract unique providers dynamically
final List<String> providers = [
  ...{for (var insurance in sampleInsuranceData) insurance.provider}
];

// Extract unique regions dynamically
final List<String> regions = [
  ...{for (var insurance in sampleInsuranceData) insurance.region}
];
