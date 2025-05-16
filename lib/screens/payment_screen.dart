import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/PolicyRequestModel.dart';
import 'package:flutter_app_test/models/insurance_model.dart';
import 'package:flutter_app_test/models/user_model';

class PaymentScreen extends StatefulWidget {
  final InsuranceModel insurance;
  final List<String> familyMembers;
  final VoidCallback onPaymentSuccess;
  final List<Map<String, dynamic>> travelers;
  final double totalAmount;
  final UserModel User;

  const PaymentScreen({
    required this.insurance,
    required this.familyMembers,
    required this.onPaymentSuccess,
    required this.travelers,
    required this.totalAmount,
    required this.User,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  bool _isProcessing = false;
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardNameController = TextEditingController();
  UserModel? userModel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userModel = UserModel.fromMap(doc.data()!, uid);
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (_selectedPaymentMethod == 0 &&
        (_cardNumberController.text.isEmpty ||
            _expiryController.text.isEmpty ||
            _cvvController.text.isEmpty ||
            _cardNameController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all card details')),
      );
      return;
    }

    setState(() => _isProcessing = true);
    await Future.delayed(Duration(seconds: 2)); // Simulate payment delay

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || userModel == null) throw Exception("User not authenticated or data not loaded");

      final docRef = FirebaseFirestore.instance.collection('policy_requests').doc();

      final request = PolicyRequestModel(
        id: docRef.id,
        policyId: widget.insurance.id,
        providerId: widget.User.uid,
        customerId: user.uid,
        customerName: userModel!.fullName,
        status: "pending",
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: widget.insurance.duration)),
        numberOfTravelers: widget.familyMembers.length + 1,
        totalPrice: widget.totalAmount,
        region: widget.insurance.region,
        paymentMethod: _selectedPaymentMethod == 0
            ? "Card"
            : _selectedPaymentMethod == 1
                ? "BenefitPay"
                : "ApplePay",
        travelers: widget.travelers,
        createdAt: DateTime.now(),
      );

      await docRef.set(request.toMap());
      print("Policy request added with ID: ${docRef.id}");
      widget.onPaymentSuccess();
    } catch (e) {
      print("Error processing payment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.totalAmount;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Payment")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Summary", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    _buildOrderDetail("Policy", widget.insurance.provider),
                    _buildOrderDetail("Duration", "${widget.insurance.duration} days"),
                    if (widget.familyMembers.isNotEmpty)
                      _buildOrderDetail("Family Members", widget.familyMembers.join(", ")),
                    Divider(),
                    _buildOrderDetail("Total Amount", "${totalPrice.toStringAsFixed(2)} BHD", isTotal: true),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Payment Method", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            _buildPaymentMethodOption(0, "Credit/Debit Card", Icons.credit_card),
            if (_selectedPaymentMethod == 0) ...[
              SizedBox(height: 15),
              TextField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expiryController,
                      decoration: InputDecoration(
                        labelText: "MM/YY",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cardNameController,
                decoration: InputDecoration(
                  labelText: "Cardholder Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ],
            SizedBox(height: 15),
            _buildPaymentMethodOption(1, "BenefitPay", Icons.payment),
            SizedBox(height: 15),
            _buildPaymentMethodOption(2, "Apple Pay", Icons.apple),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue[800],
                ),
                child: _isProcessing
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Confirm Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(int index, String title, IconData icon) {
    return Card(
      elevation: _selectedPaymentMethod == index ? 4 : 1,
      color:
          _selectedPaymentMethod == index ? Colors.blue[50] : Colors.grey[100],
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[800]),
        title: Text(title),
        trailing: Radio<int>(
          value: index,
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() => _selectedPaymentMethod = value!);
          },
        ),
        onTap: () {
          setState(() => _selectedPaymentMethod = index);
        },
      ),
    );
  }
}
