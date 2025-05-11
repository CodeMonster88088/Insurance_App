import 'package:flutter_app_test/data/sample_data.dart';

// Extract unique provider IDs dynamically
final List<String> providers = [
  ...{for (var policy in samplePolicyRequestData) policy.providerId}
];

// If you later add a `region` field to PolicyRequestModel, this is how you'd extract it:
final List<String> regions = [
  ...{for (var policy in samplePolicyRequestData) policy.region}
];
