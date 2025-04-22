import 'package:flutter/material.dart';
import 'package:flutter_app_test/Services/auth.dart';
import 'package:flutter_app_test/screens/company_home.dart';
import 'package:flutter_app_test/screens/home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  String? _errorMessage;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _errorMessage = null;
      });

      var user = await _auth.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _loading = false);

      if (user != null) {
        // ✅ Navigate to HomePage after login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CompanyHomePage()),
        );
      } else {
        setState(() =>
            _errorMessage = 'Login failed. Please check your credentials.');
      }
    }
  }

  void _handleAnonymousLogin() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    var user = await _auth.signInAnon();

    setState(() => _loading = false);

    if (user != null) {
      print('Signed in anonymously: ${user.uid}');
      // Navigate to the main app screen if needed
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
    } else {
      setState(() => _errorMessage = 'Anonymous login failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Hero(
                tag: 'logo',
                child: Icon(Icons.account_circle,
                    size: 100, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              if (_errorMessage != null)
                Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (val) =>
                    val!.length < 6 ? 'Password must be 6+ chars' : null,
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Login'),
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: _handleAnonymousLogin,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: Text('Continue as Guest'),
                        ),
                      ],
                    ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Signup())),
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
