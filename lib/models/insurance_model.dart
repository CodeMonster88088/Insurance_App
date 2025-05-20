class InsuranceModel {
  final String id;
  final String provider;
  final String providerId; // ✅ New field
  final double coverageAmount;
  final int duration;
  final String region;
  final double price;
  final int numberOfTravelers;
  final double rating;

  InsuranceModel({
    required this.id,
    required this.provider,
    required this.providerId, // ✅ Required in constructor
    required this.coverageAmount,
    required this.duration,
    required this.region,
    required this.price,
    required this.numberOfTravelers,
    required this.rating,
  });

  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id'],
      provider: map['provider'],
      providerId: map['providerId'] ?? '', // ✅ Map it from Firestore
      coverageAmount: (map['coverageAmount'] ?? 0).toDouble(),
      duration: map['duration'],
      region: map['region'],
      price: (map['price'] ?? 0).toDouble(),
      numberOfTravelers: map['numberOfTravelers'],
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'providerId': providerId, // ✅ Include in map
      'coverageAmount': coverageAmount,
      'duration': duration,
      'region': region,
      'price': price,
      'numberOfTravelers': numberOfTravelers,
      'rating': rating,
    };
  }

  InsuranceModel copyWith({
    String? id,
    String? provider,
    String? providerId, // ✅ Allow update in copyWith
    double? coverageAmount,
    int? duration,
    String? region,
    double? price,
    int? numberOfTravelers,
    double? rating,
  }) {
    return InsuranceModel(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      coverageAmount: coverageAmount ?? this.coverageAmount,
      duration: duration ?? this.duration,
      region: region ?? this.region,
      price: price ?? this.price,
      numberOfTravelers: numberOfTravelers ?? this.numberOfTravelers,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceModel &&
        other.id == id &&
        other.provider == provider &&
        other.providerId == providerId &&
        other.coverageAmount == coverageAmount &&
        other.duration == duration &&
        other.region == region &&
        other.price == price &&
        other.numberOfTravelers == numberOfTravelers &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        provider.hashCode ^
        providerId.hashCode ^
        coverageAmount.hashCode ^
        duration.hashCode ^
        region.hashCode ^
        price.hashCode ^
        numberOfTravelers.hashCode ^
        rating.hashCode;
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, provider: $provider, providerId: $providerId, duration: $duration days, region: $region, price: $price, coverageAmount: $coverageAmount, numberOfTravelers: $numberOfTravelers, rating: $rating)';
  }
}
