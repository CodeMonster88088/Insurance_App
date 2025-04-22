import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final VoidCallback onVerified;

  const OTPVerificationScreen({
    required this.email,
    required this.onVerified,
    Key? key,
  }) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  bool _resendLoading = false;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // Auto-focus first OTP field
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (_countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      }
    });
  }

  void _resendOTP() async {
    setState(() => _resendLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _resendLoading = false;
      _countdown = 60;
      _startCountdown();
    });
  }

  void _verifyOTP() async {
    setState(() => _isLoading = true);
    
    // Simulate verification
    await Future.delayed(Duration(seconds: 2));
    
    widget.onVerified();
  }

  void _handleOTPInput(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    
    // Auto submit if all fields are filled
    if (index == 5 && value.isNotEmpty) {
      bool allFilled = true;
      for (var controller in _otpControllers) {
        if (controller.text.isEmpty) {
          allFilled = false;
          break;
        }
      }
      if (allFilled) {
        _verifyOTP();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Your Email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We sent a 6-digit code to ${widget.email}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 45,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => _handleOTPInput(value, index),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Verify'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: _countdown > 0
                  ? Text(
                      'Resend code in $_countdown seconds',
                      style: TextStyle(color: Colors.grey),
                    )
                  : TextButton(
                      onPressed: _resendLoading ? null : _resendOTP,
                      child: _resendLoading
                          ? CircularProgressIndicator()
                          : Text('Resend Code'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}