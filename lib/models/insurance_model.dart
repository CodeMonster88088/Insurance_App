class InsuranceModel {
  final int id;
  final String provider;
  final DateTime fromDate;
  final DateTime toDate;
  final int numberOfTravelers;
  final double price;
  final String region;
  final String coverage; // New field
  final String benefits; // New field
  final String destination; // Add this field
  final int duration; // Add this field

  InsuranceModel({
    required this.id,
    required this.provider,
    required this.fromDate,
    required this.toDate,
    required this.numberOfTravelers,
    required this.price,
    required this.region,
    required this.coverage,
    required this.benefits,
    required this.destination, // Add this field
    required this.duration, // Add this field
  });

  // Factory method to create an InsuranceModel from a Map
  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id'],
      provider: map['provider'],
      fromDate: DateTime.parse(map['fromDate']), // Convert from String to DateTime
      toDate: DateTime.parse(map['toDate']),     // Convert from String to DateTime
      numberOfTravelers: map['numberOfTravelers'],
      price: map['price'].toDouble(),
      region: map['region'],
      coverage: map['coverage'], // New field
      benefits: map['benefits'], // New field
      destination: map['destination'], // Add this field
      duration: map['duration'], // Add this field
    );
  }

  // Convert an InsuranceModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'fromDate': fromDate.toIso8601String(), // Convert DateTime to String
      'toDate': toDate.toIso8601String(),     // Convert DateTime to String
      'numberOfTravelers': numberOfTravelers,
      'price': price,
      'region': region,
      'coverage': coverage, // New field
      'benefits': benefits, // New field
      'destination': destination, // Add this field
      'duration': duration, // Add this field
    };
  }

  // Validate date range
  bool isValidDateRange() {
    return toDate.isAfter(fromDate) || toDate.isAtSameMomentAs(fromDate);
  }

  // Create a copy of the model with updated fields
  InsuranceModel copyWith({
    int? id,
    String? provider,
    DateTime? fromDate,
    DateTime? toDate,
    int? numberOfTravelers,
    double? price,
    String? region,
    String? coverage, // New field
    String? benefits, // New field
    String? destination, // Add this field
    int? duration, // Add this field
  }) {
    return InsuranceModel(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      numberOfTravelers: numberOfTravelers ?? this.numberOfTravelers,
      price: price ?? this.price,
      region: region ?? this.region,
      coverage: coverage ?? this.coverage, // New field
      benefits: benefits ?? this.benefits, // New field
      destination: destination ?? this.destination, // Add this field
      duration: duration ?? this.duration, // Add this field
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceModel &&
        other.id == id &&
        other.provider == provider &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.numberOfTravelers == numberOfTravelers &&
        other.price == price &&
        other.region == region &&
        other.coverage == coverage && // New field
        other.benefits == benefits && // New field
        other.destination == destination && // Add this field
        other.duration == duration; // Add this field
  }

  @override
  int get hashCode {
    return id.hashCode ^
        provider.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        numberOfTravelers.hashCode ^
        price.hashCode ^
        region.hashCode ^
        coverage.hashCode ^ // New field
        benefits.hashCode ^ // New field
        destination.hashCode ^ // Add this field
        duration.hashCode; // Add this field
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, provider: $provider, fromDate: $fromDate, toDate: $toDate, numberOfTravelers: $numberOfTravelers, price: $price, region: $region, coverage: $coverage, benefits: $benefits, destination: $destination, duration: $duration)';
  }
}