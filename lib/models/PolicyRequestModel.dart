import 'package:cloud_firestore/cloud_firestore.dart';

class PolicyRequestModel {
  final String id;
  final String policyId;
  final String providerId;
  final String customerId;
  final String customerName;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfTravelers;
  final double totalPrice;
  final String region;
  final String paymentMethod;
  final List<dynamic> travelers;
  final DateTime createdAt;

  PolicyRequestModel( {
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
    required this.paymentMethod,
    required this.travelers,
    required this.createdAt,
  });

  factory PolicyRequestModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return PolicyRequestModel(
      id: documentId,
      policyId: map['policyId'] ?? '',
      providerId: map['providerId'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      status: map['status'] ?? '',
      startDate: _parseDate(map['startDate']),
      endDate: _parseDate(map['endDate']),
      numberOfTravelers: map['numberOfTravelers'] ?? 0,
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      region: map['region'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      travelers: map['travelers'] ?? [],
      createdAt: _parseDate(map['createdAt']),
    );
  }

  /// ✅ Use this for Firestore queries
  factory PolicyRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PolicyRequestModel.fromMap(data, doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'policyId': policyId,
      'providerId': providerId,
      'customerId': customerId,
      'customerName': customerName,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
      'numberOfTravelers': numberOfTravelers,
      'totalPrice': totalPrice,
      'region': region,
      'paymentMethod': paymentMethod,
      'travelers': travelers,
      'createdAt': createdAt,
    };
  }

  /// ✅ Handles both Timestamp and String
  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    } else {
      return DateTime.now();
    }
  }
}
