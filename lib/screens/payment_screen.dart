import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/insurance_model.dart';

class PaymentScreen extends StatefulWidget {
  final InsuranceModel insurance;
  final List<String> familyMembers;
  final VoidCallback onPaymentSuccess;
   final List<Map<String, dynamic>> travelers;
  final double totalAmount;

  const PaymentScreen({
    required this.insurance,
    required this.familyMembers,
    required this.onPaymentSuccess,
    required this.travelers,
    required this.totalAmount,
    
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
         _cvvController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter all card details')),
      );
      return;
    }

    setState(() => _isProcessing = true);

    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    widget.onPaymentSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.familyMembers.isNotEmpty
        ? widget.insurance.price * (widget.familyMembers.length + 1)
        : widget.insurance.price;

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
                    Text(
                      "Order Summary",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10),
                    _buildOrderDetail("Policy", widget.insurance.provider),
                    // _buildOrderDetail("Coverage", widget.insurance.coverageType),
                    _buildOrderDetail("Duration", "${widget.insurance.duration} days"),
                    if (widget.familyMembers.isNotEmpty)
                      _buildOrderDetail(
                        "Family Members",
                        widget.familyMembers.join(", "),
                      ),
                    Divider(),
                    _buildOrderDetail(
                      "Total Amount",
                      "${totalPrice.toStringAsFixed(2)} BHD",
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Payment Method", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            _buildPaymentMethodOption(
              0,
              "Credit/Debit Card",
              Icons.credit_card,
            ),
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
            _buildPaymentMethodOption(
              1,
              "BenefitPay",
              Icons.payment,
            ),
            SizedBox(height: 15),
            _buildPaymentMethodOption(
              2,
              "Apple Pay",
              Icons.apple,
            ),
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
          Text(label, style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          )),
          Text(value, style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          )),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(int index, String title, IconData icon) {
    return Card(
      elevation: _selectedPaymentMethod == index ? 4 : 1,
      color: _selectedPaymentMethod == index
          ? Colors.blue[50]
          : Colors.grey[100],
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