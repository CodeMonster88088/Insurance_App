class PolicyRequestModel {
  final String id;
  final String policyId;
  final String providerId;
  final String customerId;
  final String customerName;
  final String status; // pending, approved, rejected
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfTravelers;
  final double totalPrice;
  final String region;

  PolicyRequestModel({
    required this.id,
    required this.policyId,
    required this.providerId,
    required this.customerId,
    required this.customerName,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.numberOfTravelers,
    required this.totalPrice,
    required this.region,
  });

  PolicyRequestModel copyWith({
    String? id,
    String? policyId,
    String? providerId,
    String? customerId,
    String? customerName,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? numberOfTravelers,
    double? totalPrice,
    String? region
  }) {
    return PolicyRequestModel(
      id: id ?? this.id,
      policyId: policyId ?? this.policyId,
      providerId: providerId ?? this.providerId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      numberOfTravelers: numberOfTravelers ?? this.numberOfTravelers,
      totalPrice: totalPrice ?? this.totalPrice,
      region: region ?? this.region
    );
  }

  factory PolicyRequestModel.fromMap(Map<String, dynamic> data, String docId) {
    return PolicyRequestModel(
      id: docId,
      policyId: data['policyId'] ?? '',
      providerId: data['providerId'] ?? '',
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      status: data['status'] ?? 'pending',
      startDate: DateTime.tryParse(data['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(data['endDate'] ?? '') ?? DateTime.now(),
      numberOfTravelers: data['numberOfTravelers'] ?? 1,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      region: data['region'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'policyId': policyId,
      'providerId': providerId,
      'customerId': customerId,
      'customerName': customerName,
      'status': status,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'numberOfTravelers': numberOfTravelers,
      'totalPrice': totalPrice,
      'region' : region,
    };
  }
}
