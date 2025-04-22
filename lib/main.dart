import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/company_claims_view.dart';
import 'package:flutter_app_test/screens/company_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_test/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB1gICVcZSHqgzVgCfQsLlvXSnspTjxCUU",
        appId: "1:1056072836362:web:e69e862ed86877073e46f3",
        messagingSenderId: "1056072836362", 
        projectId: "insurace-app-7d341",
        storageBucket: "insurace-app-7d341.firebasestorage.app",
        )
    );

  }
  else{await Firebase.initializeApp();}
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Start with login screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/companyHome': (context) => CompanyHomePage(),
        '/claims' :(context) => CompanyClaimsView()
        // Other routes can be added here as needed
      },
    );
  }
}
