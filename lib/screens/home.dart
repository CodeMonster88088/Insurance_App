import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/insurance_search_filter.dart';
import 'package:flutter_app_test/screens/login_screen.dart';
import 'signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    Center(child: Text("Home Page Content")), // Replace with actual content
    InsuranceSearchFilter(),
    LoginScreen(),
    Signup(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text(
              'Amaan Insurance',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsuranceSearchFilter()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.dark_mode, color: Colors.white),
            onPressed: () {
              // Add dark mode toggle functionality
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call emergency contact
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.emergency, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Sign Up'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
