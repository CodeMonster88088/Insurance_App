import '../models/insurance_model.dart';

final List<InsuranceModel> sampleInsuranceData = [
  InsuranceModel(
    id: 1,
    provider: 'Insurance Co. A',
    fromDate: DateTime(2025, 10, 1),
    toDate: DateTime(2025, 10, 10),
    numberOfTravelers: 2,
    price: 50.0,
  ),
  InsuranceModel(
    id: 2,
    provider: 'Insurance Co. B',
    fromDate: DateTime(2023, 11, 15),
    toDate: DateTime(2023, 11, 25),
    numberOfTravelers: 4,
    price: 120.0,
  ),
  InsuranceModel(
    id: 3,
    provider: 'Insurance Co. C',
    fromDate: DateTime(2023, 12, 5),
    toDate: DateTime(2023, 12, 20),
    numberOfTravelers: 1,
    price: 80.0,
  ),
  InsuranceModel(
    id: 4,
    provider: 'Insurance Co. D',
    fromDate: DateTime(2023, 10, 10),
    toDate: DateTime(2023, 10, 20),
    numberOfTravelers: 3,
    price: 90.0,
  ),
];

List<InsuranceModel> filterInsuranceData({
  required DateTime? fromDate,
  required DateTime? toDate,
  required int numberOfTravelers,
  required double maxPrice,
}) {
  return sampleInsuranceData.where((insurance) {
    final matchesFromDate = fromDate == null || insurance.fromDate.isAfter(fromDate);
    final matchesToDate = toDate == null || insurance.toDate.isBefore(toDate);
    final matchesTravelers = insurance.numberOfTravelers >= numberOfTravelers;
    final matchesPrice = insurance.price <= maxPrice;

    return matchesFromDate && matchesToDate && matchesTravelers && matchesPrice;
  }).toList();
}