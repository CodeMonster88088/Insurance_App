import '../models/insurance_model.dart';

final List<InsuranceModel> sampleInsuranceData = [
  InsuranceModel(
    id: 1,
    provider: 'Insurance Co. A',
    duration: 10, // Duration in days
    numberOfTravelers: 2,
    price: 50.0,
    region: 'Europe',
  ),
  InsuranceModel(
    id: 2,
    provider: 'Insurance Co. B',
    duration: 10,
    numberOfTravelers: 4,
    price: 120.0,
    region: 'Middle East',
  ),
  InsuranceModel(
    id: 3,
    provider: 'Insurance Co. C',
    duration: 15,
    numberOfTravelers: 1,
    price: 80.0,
    region: 'Asia',
  ),
  InsuranceModel(
    id: 4,
    provider: 'Insurance Co. D',
    duration: 10,
    numberOfTravelers: 3,
    price: 90.0,
    region: 'Africa',
  ),
  InsuranceModel(
    id: 5,
    provider: 'Insurance Co. E',
    duration: 15,
    numberOfTravelers: 2,
    price: 75.0,
    region: 'North America',
  ),
  InsuranceModel(
    id: 6,
    provider: 'Insurance Co. F',
    duration: 10,
    numberOfTravelers: 5,
    price: 150.0,
    region: 'South America',
  ),
  InsuranceModel(
    id: 7,
    provider: 'Insurance Co. G',
    duration: 10,
    numberOfTravelers: 1,
    price: 60.0,
    region: 'Europe',
  ),
  InsuranceModel(
    id: 8,
    provider: 'Insurance Co. H',
    duration: 9,
    numberOfTravelers: 4,
    price: 110.0,
    region: 'Middle East',
  ),
  InsuranceModel(
    id: 9,
    provider: 'Insurance Co. I',
    duration: 10,
    numberOfTravelers: 2,
    price: 85.0,
    region: 'Asia',
  ),
  InsuranceModel(
    id: 10,
    provider: 'Insurance Co. J',
    duration: 9,
    numberOfTravelers: 3,
    price: 95.0,
    region: 'Africa',
  ),
  InsuranceModel(
    id: 11,
    provider: 'Insurance Co. K',
    duration: 10,
    numberOfTravelers: 1,
    price: 70.0,
    region: 'North America',
  ),
  InsuranceModel(
    id: 12,
    provider: 'Insurance Co. L',
    duration: 10,
    numberOfTravelers: 4,
    price: 130.0,
    region: 'South America',
  ),
  InsuranceModel(
    id: 13,
    provider: 'Insurance Co. M',
    duration: 9,
    numberOfTravelers: 2,
    price: 55.0,
    region: 'Europe',
  ),
  InsuranceModel(
    id: 14,
    provider: 'Insurance Co. N',
    duration: 10,
    numberOfTravelers: 3,
    price: 100.0,
    region: 'Middle East',
  ),
  InsuranceModel(
    id: 15,
    provider: 'Insurance Co. O',
    duration: 9,
    numberOfTravelers: 1,
    price: 65.0,
    region: 'Asia',
  ),
];

List<InsuranceModel> filterInsuranceData({
  int? duration, // Filter by trip duration
  int? numberOfTravelers,
  double? maxPrice,
  String? region,
  String? searchQuery, // Search by provider name
}) {
  return sampleInsuranceData.where((insurance) {
    // Filter by duration (if provided)
    final matchesDuration = duration == null || insurance.duration == duration;

    // Filter by numberOfTravelers (if provided)
    final matchesTravelers = numberOfTravelers == null || insurance.numberOfTravelers >= numberOfTravelers;

    // Filter by maxPrice (if provided)
    final matchesPrice = maxPrice == null || insurance.price <= maxPrice;

    // Filter by region (if provided)
    final matchesRegion = region == null || insurance.region.toLowerCase() == region.toLowerCase();

    // Filter by searchQuery (if provided)
    final matchesSearchQuery = searchQuery == null || insurance.provider.toLowerCase().contains(searchQuery.toLowerCase());

    // Combine all filters
    return matchesDuration &&
           matchesTravelers &&
           matchesPrice &&
           matchesRegion &&
           matchesSearchQuery;
  }).toList();
}
