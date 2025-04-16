import '../models/insurance_model.dart';
import 'package:intl/intl.dart';

final List<InsuranceModel> sampleInsuranceData = [
  InsuranceModel(
    id: 1,
    provider: 'Insurance Co. A',
    coverageAmount: 50000.0,
    duration: 10,
    region: 'Europe',
    price: 50.0,
    startDate: DateTime(2023, 6, 1),
    endDate: DateTime(2023, 6, 11),
    status: 'Active',
    familyMembers: ['John Doe', 'Jane Doe'],
    numberOfTravelers: 2,
    coverageType: 'Basic',
  ),
  InsuranceModel(
    id: 2,
    provider: 'Insurance Co. B',
    coverageAmount: 100000.0,
    duration: 10,
    region: 'Middle East',
    price: 120.0,
    startDate: DateTime(2023, 6, 1),
    endDate: DateTime(2023, 6, 11),
    status: 'Active',
    familyMembers: ['Alice Smith', 'Bob Smith', 'Charlie Smith', 'Dana Smith'],
    numberOfTravelers: 4,
    coverageType: 'Premium',
  ),
  InsuranceModel(
    id: 3,
    provider: 'Insurance Co. C',
    coverageAmount: 75000.0,
    duration: 15,
    region: 'Asia',
    price: 80.0,
    startDate: DateTime(2023, 6, 1),
    endDate: DateTime(2023, 6, 16),
    status: 'Active',
    familyMembers: ['Michael Brown'],
    numberOfTravelers: 1,
    coverageType: 'Standard',
  ),
  // Continue with all other entries following the same pattern
  InsuranceModel(
    id: 4,
    provider: 'Insurance Co. D',
    coverageAmount: 60000.0,
    duration: 10,
    region: 'Africa',
    price: 90.0,
    startDate: DateTime(2023, 6, 1),
    endDate: DateTime(2023, 6, 11),
    status: 'Active',
    familyMembers: ['David Wilson', 'Emma Wilson', 'Frank Wilson'],
    numberOfTravelers: 3,
    coverageType: 'Basic',
  ),
  InsuranceModel(
    id: 5,
    provider: 'Insurance Co. E',
    coverageAmount: 80000.0,
    duration: 15,
    region: 'North America',
    price: 75.0,
    startDate: DateTime(2023, 6, 1),
    endDate: DateTime(2023, 6, 16),
    status: 'Active',
    familyMembers: ['Grace Lee', 'Henry Lee'],
    numberOfTravelers: 2,
    coverageType: 'Standard',
  ),
  // Add remaining entries (6-15) with all required fields
];

List<InsuranceModel> filterInsuranceData({
  int? duration,
  int? numberOfTravelers,
  double? maxPrice,
  String? region,
  String? searchQuery,
}) {
  return sampleInsuranceData.where((insurance) {
    final matchesDuration = duration == null || insurance.duration == duration;
    final matchesTravelers = numberOfTravelers == null || insurance.numberOfTravelers >= numberOfTravelers;
    final matchesPrice = maxPrice == null || insurance.price <= maxPrice;
    final matchesRegion = region == null || insurance.region.toLowerCase() == region.toLowerCase();
    final matchesSearchQuery = searchQuery == null || insurance.provider.toLowerCase().contains(searchQuery.toLowerCase());

    return matchesDuration &&
        matchesTravelers &&
        matchesPrice &&
        matchesRegion &&
        matchesSearchQuery;
  }).toList();
}