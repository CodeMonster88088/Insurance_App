import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome
import 'screens/insurance_search_filter.dart';
import 'package:animations/animations.dart';
import 'screens/login_screen.dart'; // Import the LoginScreen
import 'screens/signup.dart'; // Import the SignUpScreen

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.health_and_safety, // Safety icon
              color: Colors.white,
              size: 28, // Adjust the size as needed
            ),
            SizedBox(width: 8), // Add spacing between the icon and text
            Text(
              'Amaan Health Travel Insurance',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          // Sign Up Button with Heartbeat Icon
          TextButton.icon(
            onPressed: () {
              // Navigate to Sign Up screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
            icon: Icon(
              Icons.favorite, // Heartbeat icon
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10), // Add spacing between buttons

          // Login Button with World Map Icon
          TextButton.icon(
            onPressed: () {
              // Navigate to Login screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(
              Icons.public, // World map icon
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10), // Add spacing between buttons

          // Search Icon
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsuranceSearchFilter()),
              );
            },
          ),

          // Dark Mode Icon
          IconButton(
            icon: Icon(Icons.dark_mode, color: Colors.white),
            onPressed: () {
              // Add dark mode toggle functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Navigate to About Us page
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact'),
              onTap: () {
                // Navigate to Contact page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings page
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with Animation
            OpenContainer(
              transitionDuration: Duration(milliseconds: 500),
              closedBuilder: (context, action) {
                return AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[800]!, Colors.blue[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeTransition(
                          opacity: AlwaysStoppedAnimation(1.0),
                          child: Text(
                            'Your Health, Our Priority – Anywhere You Go!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: action,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue[800],
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Get a Quote Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              openBuilder: (context, action) {
                return InsuranceSearchFilter();
              },
            ),

            // Key Features Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Why Choose Us?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeatureItem(
                        icon: Icons.medical_services,
                        title: '24/7 Global Assistance',
                      ),
                      FeatureItem(
                        icon: Icons.health_and_safety,
                        title: 'Comprehensive Coverage',
                      ),
                      FeatureItem(
                        icon: Icons.assignment_turned_in,
                        title: 'Easy Claims Process',
                      ),
                      FeatureItem(
                        icon: Icons.attach_money,
                        title: 'Affordable Plans',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Testimonials Section
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'What Our Customers Say',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  TestimonialItem(
                    name: 'John Doe',
                    review: 'Great service! They helped me during my trip to Europe.',
                  ),
                  TestimonialItem(
                    name: 'Jane Smith',
                    review: 'Affordable plans and quick claims processing.',
                  ),
                ],
              ),
            ),

            // Health Tips for Travelers Section
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Health Tips for Travelers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HealthTipCard(
                          title: 'Stay Hydrated',
                          description: 'Drink plenty of water during your travels.',
                          icon: Icons.local_drink,
                        ),
                        HealthTipCard(
                          title: 'Pack a First Aid Kit',
                          description: 'Always carry essential medications and first aid supplies.',
                          icon: Icons.medical_services,
                        ),
                        HealthTipCard(
                          title: 'Get Vaccinated',
                          description: 'Check if you need any vaccinations for your destination.',
                          icon: Icons.health_and_safety,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Destination Health Alerts Section
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Destination Health Alerts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Malaria Alert in Southeast Asia'),
                    subtitle: Text('Take precautions if traveling to affected areas.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Heatwave in Europe'),
                    subtitle: Text('Stay hydrated and avoid prolonged sun exposure.'),
                  ),
                ],
              ),
            ),

            // Compare Policies Section
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Compare Policies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  PolicyComparisonTable(),
                ],
              ),
            ),

            // Track Your Claim Section
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Track Your Claim',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 0.7, // Example: 70% complete
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your claim is 70% complete.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),

            // Nearby Hospitals Section
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Nearby Hospitals',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.red),
                    title: Text('City General Hospital'),
                    subtitle: Text('2 km away'),
                  ),
                  ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.red),
                    title: Text('Sunrise Clinic'),
                    subtitle: Text('5 km away'),
                  ),
                ],
              ),
            ),

            DropdownButton<String>(
              value: 'English', // Default language
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              onChanged: (String? newValue) {
                // Handle language change
                if (newValue == 'Arabic') {
                  // Set app language to Arabic
                  // You can use a state management solution (e.g., Provider) to update the locale
                } else if (newValue == 'Hindi') {
                  // Set app language to Hindi
                } else if (newValue == 'Urdu') {
                  // Set app language to Urdu
                } else {
                  // Default to English
                }
              },
              items: <String>['English', 'Arabic', 'Hindi', 'Urdu']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                );
              }).toList(),
            ),

            // Feedback Section
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'We Value Your Feedback',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to feedback form
                    },
                    child: Text('Submit Feedback'),
                  ),
                ],
              ),
            ),

            // Download Our App Section
            Container(
              color: Colors.blue[800],
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.phone_android, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Download Our App',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Redirect to app store
                    },
                    child: Text('Download Now'),
                  ),
                ],
              ),
            ),

            // Call-to-Action Section
            Container(
              margin: EdgeInsets.all(20), // Add margin for spacing
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[800]!, Colors.blue[400]!], // Gradient background
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3), // Shadow color
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 5), // Shadow position
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Start Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Get started with your health travel insurance today.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Attractive Button with Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue[100]!], // Gradient for the button
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30), // Rounded button
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3), // Button shadow
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InsuranceSearchFilter()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent background
                        shadowColor: Colors.transparent, // Remove default shadow
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded button
                        ),
                      ),
                      child: Text(
                        'Start Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800], // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer Section
            Container(
              color: Colors.blue[800],
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Contact Information
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone: +1-800-HEALTHTRAVEL\nEmail: support@Amaanlinsurance.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Quick Access Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Search Icon
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Add functionality for search
                        },
                      ),
                      // Location Icon
                      IconButton(
                        icon: Icon(Icons.location_on, color: Colors.white),
                        onPressed: () {
                          // Add functionality for location
                        },
                      ),
                      // Assistance Icon
                      IconButton(
                        icon: Icon(Icons.help_outline, color: Colors.white),
                        onPressed: () {
                          // Add functionality for assistance
                        },
                      ),
                      // Claims Icon
                      IconButton(
                        icon: Icon(Icons.assignment, color: Colors.white),
                        onPressed: () {
                          // Add functionality for claims
                        },
                      ),
                      // FAQ Icon
                      IconButton(
                        icon: Icon(Icons.question_answer, color: Colors.white),
                        onPressed: () {
                          // Add functionality for FAQ
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
                        onPressed: () {
                          // Add functionality for Facebook
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.twitter, color: Colors.white),
                        onPressed: () {
                          // Add functionality for Twitter
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
                        onPressed: () {
                          // Add functionality for Instagram
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Legal Information
                  Text(
                    '© 2025 Amaan Insurance. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Privacy Policy and Terms of Service
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to Privacy Policy
                        },
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate to Terms of Service
                        },
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call emergency contact
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.emergency, color: Colors.white),
      ),
    );
  }
}

// Feature Item Widget
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  FeatureItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: const Color.fromARGB(160, 33, 149, 243)),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Testimonial Item Widget
class TestimonialItem extends StatelessWidget {
  final String name;
  final String review;

  TestimonialItem({required this.name, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              review,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '- $name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Health Tip Card Widget
class HealthTipCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  HealthTipCard({required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.blue[800]),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Policy Comparison Table Widget
class PolicyComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Policy')),
        DataColumn(label: Text('Coverage')),
        DataColumn(label: Text('Price')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Basic')),
          DataCell(Text('Limited')),
          DataCell(Text('\$50')),
        ]),
        DataRow(cells: [
          DataCell(Text('Standard')),
          DataCell(Text('Moderate')),
          DataCell(Text('\$100')),
        ]),
        DataRow(cells: [
          DataCell(Text('Premium')),
          DataCell(Text('Comprehensive')),
          DataCell(Text('\$150')),
        ]),
      ],
    );
  }
}