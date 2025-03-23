class InsuranceModel {
  final int id;
  final String provider;
  final int duration; // Duration in days
  final int numberOfTravelers;
  final double price;
  final String region;

  InsuranceModel({
    required this.id,
    required this.provider,
    required this.duration,
    required this.numberOfTravelers,
    required this.price,
    required this.region,
  });

  // Factory method to create an InsuranceModel from a Map
  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id'],
      provider: map['provider'],
      duration: map['duration'], // Duration in days
      numberOfTravelers: map['numberOfTravelers'],
      price: map['price'].toDouble(),
      region: map['region'],
    );
  }

  // Convert an InsuranceModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'duration': duration, // Store duration instead of dates
      'numberOfTravelers': numberOfTravelers,
      'price': price,
      'region': region,
    };
  }

  // Create a copy of the model with updated fields
  InsuranceModel copyWith({
    int? id,
    String? provider,
    int? duration,
    int? numberOfTravelers,
    double? price,
    String? region,
  }) {
    return InsuranceModel(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      duration: duration ?? this.duration,
      numberOfTravelers: numberOfTravelers ?? this.numberOfTravelers,
      price: price ?? this.price,
      region: region ?? this.region,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceModel &&
        other.id == id &&
        other.provider == provider &&
        other.duration == duration &&
        other.numberOfTravelers == numberOfTravelers &&
        other.price == price &&
        other.region == region;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        provider.hashCode ^
        duration.hashCode ^
        numberOfTravelers.hashCode ^
        price.hashCode ^
        region.hashCode;
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, provider: $provider, duration: $duration days, numberOfTravelers: $numberOfTravelers, price: $price, region: $region)';
  }
}
