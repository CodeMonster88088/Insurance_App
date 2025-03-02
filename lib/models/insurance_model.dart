class InsuranceModel {
  final int id;
  final String provider;
  final DateTime fromDate;
  final DateTime toDate;
  final int numberOfTravelers;
  final double price;

  InsuranceModel({
    required this.id,
    required this.provider,
    required this.fromDate,
    required this.toDate,
    required this.numberOfTravelers,
    required this.price,
  });

  // Factory method to create an InsuranceModel from a Map (e.g., from JSON or sample data)
 factory InsuranceModel.fromMap(Map<String, dynamic> map) {
  return InsuranceModel(
    id: map['id'],
    provider: map['provider'],
    fromDate: DateTime.parse(map['fromDate']),  // Convert from String to DateTime
    toDate: DateTime.parse(map['toDate']),      // Convert from String to DateTime
    numberOfTravelers: map['numberOfTravelers'],
    price: map['price'].toDouble(),
  );
}

  // Convert an InsuranceModel to a Map (e.g., for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'fromDate': fromDate,
      'toDate': toDate,
      'numberOfTravelers': numberOfTravelers,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, provider: $provider, fromDate: $fromDate, toDate: $toDate, numberOfTravelers: $numberOfTravelers, price: $price)';
  }
}
