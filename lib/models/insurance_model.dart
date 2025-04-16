class InsuranceModel {
  final int id;
  final String provider;
  final double coverageAmount;
  final int duration;
  final String region;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  String status;
  final List<String> familyMembers;
  final int numberOfTravelers;
  final String coverageType;

  InsuranceModel({
    required this.id,
    required this.provider,
    required this.coverageAmount,
    required this.duration,
    required this.region,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.familyMembers,
    required this.numberOfTravelers,
    required this.coverageType,
  });

  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id'],
      provider: map['provider'],
      coverageAmount: map['coverageAmount'].toDouble(),
      duration: map['duration'],
      region: map['region'],
      price: map['price'].toDouble(),
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      status: map['status'],
      familyMembers: List<String>.from(map['familyMembers'] ?? []),
      numberOfTravelers: map['numberOfTravelers'],
      coverageType: map['coverageType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'coverageAmount': coverageAmount,
      'duration': duration,
      'region': region,
      'price': price,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'familyMembers': familyMembers,
      'numberOfTravelers': numberOfTravelers,
      'coverageType': coverageType,
    };
  }

  InsuranceModel copyWith({
    int? id,
    String? provider,
    double? coverageAmount,
    int? duration,
    String? region,
    double? price,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    List<String>? familyMembers,
    int? numberOfTravelers,
    String? coverageType,
  }) {
    return InsuranceModel(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      coverageAmount: coverageAmount ?? this.coverageAmount,
      duration: duration ?? this.duration,
      region: region ?? this.region,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      familyMembers: familyMembers ?? this.familyMembers,
      numberOfTravelers: numberOfTravelers ?? this.numberOfTravelers,
      coverageType: coverageType ?? this.coverageType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceModel &&
        other.id == id &&
        other.provider == provider &&
        other.coverageAmount == coverageAmount &&
        other.duration == duration &&
        other.region == region &&
        other.price == price &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.status == status &&
        other.familyMembers == familyMembers &&
        other.numberOfTravelers == numberOfTravelers &&
        other.coverageType == coverageType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        provider.hashCode ^
        coverageAmount.hashCode ^
        duration.hashCode ^
        region.hashCode ^
        price.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        status.hashCode ^
        familyMembers.hashCode ^
        numberOfTravelers.hashCode ^
        coverageType.hashCode;
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, provider: $provider, coverageAmount: $coverageAmount, duration: $duration days, region: $region, price: $price, startDate: $startDate, endDate: $endDate, status: $status, familyMembers: $familyMembers, numberOfTravelers: $numberOfTravelers, coverageType: $coverageType)';
  }
}