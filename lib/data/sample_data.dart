import '../models/insurance_model.dart'; // Ensure this import is present

final List<InsuranceModel> sampleInsuranceData = [
  InsuranceModel(
    id: 1,
    provider: 'Insurance Co. A',
    fromDate: DateTime(2025, 10, 1),
    toDate: DateTime(2025, 10, 10),
    numberOfTravelers: 2,
    price: 50.0,
    region: 'Europe',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Paris, France', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 2,
    provider: 'Insurance Co. B',
    fromDate: DateTime(2025, 11, 15),
    toDate: DateTime(2025, 11, 25),
    numberOfTravelers: 4,
    price: 120.0,
    region: 'Middle East',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Dubai, UAE', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 3,
    provider: 'Insurance Co. C',
    fromDate: DateTime(2025, 12, 5),
    toDate: DateTime(2025, 12, 20),
    numberOfTravelers: 1,
    price: 80.0,
    region: 'Asia',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Tokyo, Japan', // Add this field
    duration: 15, // Add this field
  ),
  InsuranceModel(
    id: 4,
    provider: 'Insurance Co. D',
    fromDate: DateTime(2025, 10, 10),
    toDate: DateTime(2025, 10, 20),
    numberOfTravelers: 3,
    price: 90.0,
    region: 'Africa',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Cairo, Egypt', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 5,
    provider: 'Insurance Co. E',
    fromDate: DateTime(2025, 1, 1),
    toDate: DateTime(2025, 1, 15),
    numberOfTravelers: 2,
    price: 75.0,
    region: 'North America',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'New York, USA', // Add this field
    duration: 14, // Add this field
  ),
  InsuranceModel(
    id: 6,
    provider: 'Insurance Co. F',
    fromDate: DateTime(2025, 2, 10),
    toDate: DateTime(2025, 2, 20),
    numberOfTravelers: 5,
    price: 150.0,
    region: 'South America',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Rio de Janeiro, Brazil', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 7,
    provider: 'Insurance Co. G',
    fromDate: DateTime(2025, 3, 5),
    toDate: DateTime(2025, 3, 15),
    numberOfTravelers: 1,
    price: 60.0,
    region: 'Europe',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Berlin, Germany', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 8,
    provider: 'Insurance Co. H',
    fromDate: DateTime(2025, 4, 1),
    toDate: DateTime(2025, 4, 10),
    numberOfTravelers: 4,
    price: 110.0,
    region: 'Middle East',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Riyadh, Saudi Arabia', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 9,
    provider: 'Insurance Co. I',
    fromDate: DateTime(2025, 5, 15),
    toDate: DateTime(2025, 5, 25),
    numberOfTravelers: 2,
    price: 85.0,
    region: 'Asia',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Beijing, China', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 10,
    provider: 'Insurance Co. J',
    fromDate: DateTime(2025, 6, 1),
    toDate: DateTime(2025, 6, 10),
    numberOfTravelers: 3,
    price: 95.0,
    region: 'Africa',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Nairobi, Kenya', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 11,
    provider: 'Insurance Co. K',
    fromDate: DateTime(2025, 7, 10),
    toDate: DateTime(2025, 7, 20),
    numberOfTravelers: 1,
    price: 70.0,
    region: 'North America',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Toronto, Canada', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 12,
    provider: 'Insurance Co. L',
    fromDate: DateTime(2025, 8, 5),
    toDate: DateTime(2025, 8, 15),
    numberOfTravelers: 4,
    price: 130.0,
    region: 'South America',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Buenos Aires, Argentina', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 13,
    provider: 'Insurance Co. M',
    fromDate: DateTime(2025, 9, 1),
    toDate: DateTime(2025, 9, 10),
    numberOfTravelers: 2,
    price: 55.0,
    region: 'Europe',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Madrid, Spain', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 14,
    provider: 'Insurance Co. N',
    fromDate: DateTime(2025, 10, 15),
    toDate: DateTime(2025, 10, 25),
    numberOfTravelers: 3,
    price: 100.0,
    region: 'Middle East',
    coverage: 'Partial Coverage', // New field
    benefits: 'Dental Coverage, Emergency Care, etc.', // New field
    destination: 'Doha, Qatar', // Add this field
    duration: 10, // Add this field
  ),
  InsuranceModel(
    id: 15,
    provider: 'Insurance Co. O',
    fromDate: DateTime(2025, 11, 1),
    toDate: DateTime(2025, 11, 10),
    numberOfTravelers: 1,
    price: 65.0,
    region: 'Asia',
    coverage: 'Full Coverage', // New field
    benefits: '24/7 Support, Medical Coverage, etc.', // New field
    destination: 'Seoul, South Korea', // Add this field
    duration: 10, // Add this field
  ),
];

List<InsuranceModel> filterInsuranceData({
  DateTime? fromDate,
  DateTime? toDate,
  int? numberOfTravelers,
  double? maxPrice,
  String? region,
  String? searchQuery, // Add this parameter
}) {
  return sampleInsuranceData.where((insurance) {
    // Filter by fromDate (if provided)
    final matchesFromDate = fromDate == null || insurance.fromDate.isAtSameMomentAs(fromDate) || insurance.fromDate.isAfter(fromDate);

    // Filter by toDate (if provided)
    final matchesToDate = toDate == null || insurance.toDate.isAtSameMomentAs(toDate) || insurance.toDate.isBefore(toDate);

    // Filter by numberOfTravelers (if provided)
    final matchesTravelers = numberOfTravelers == null || insurance.numberOfTravelers >= numberOfTravelers;

    // Filter by maxPrice (if provided)
    final matchesPrice = maxPrice == null || insurance.price <= maxPrice;

    // Filter by region (if provided)
    final matchesRegion = region == null || insurance.region.toLowerCase() == region.toLowerCase();

    // Filter by searchQuery (if provided)
    final matchesSearchQuery = searchQuery == null || insurance.provider.toLowerCase().contains(searchQuery.toLowerCase());

    // Combine all filters
    return matchesFromDate &&
           matchesToDate &&
           matchesTravelers &&
           matchesPrice &&
           matchesRegion &&
           matchesSearchQuery;
  }).toList();
}