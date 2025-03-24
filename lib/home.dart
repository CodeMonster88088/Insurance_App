import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome
import 'package:flutter_animate/flutter_animate.dart'; // Import Flutter Animate
import 'screens/insurance_search_filter.dart';
import 'package:animations/animations.dart';
import 'screens/login_screen.dart'; // Import the LoginScreen
import 'screens/signup.dart'; // Import the SignUpScreen
import 'screens/settings_page.dart'; // Import the SettingsPage
import 'screens/about_us_page.dart'; // Import the AboutUsPage
import 'screens/contact_page.dart'; // Import the ContactPage
import 'screens/my_policies_page.dart'; // Import the MyPoliciesPage
import 'screens/claims_page.dart'; // Import the ClaimsPage
import 'screens/support_page.dart'; // Import the SupportPage
import 'screens/profile_page.dart'; // Import the ProfilePage
import 'screens/notifications_page.dart'; // Import the NotificationsPage
import 'screens/payment_history_page.dart'; // Import the PaymentHistoryPage
import 'screens/emergency_page.dart'; // Import the EmergencyPage
import 'screens/policy_documents_page.dart'; // Import the PolicyDocumentsPage
import 'screens/finances_page.dart'; // Import the FinancesPage
import 'screens/get_started_page.dart'; // Import the GetStartedPage
import 'screens/help_center_page.dart'; // Import the HelpCenterPage
import 'screens/destination_health_alerts_page.dart'; // Import DestinationHealthAlertsPage
import 'screens/nearby_hospitals_page.dart'; // Import NearbyHospitalsPage
import 'screens/health_tips_page.dart'; // Import HealthTipsPage
import 'screens/wellness_programs_page.dart'; // Import WellnessProgramsPage
import 'screens/vaccination_info_page.dart'; // Import VaccinationInfoPage
import 'screens/health_calculators_page.dart'; // Import HealthCalculatorsPage
import 'screens/faq_page.dart'; // Import FAQPage
import 'screens/privacy_policy_page.dart'; // Import PrivacyPolicyPage
import 'screens/terms_and_conditions_page.dart'; // Import TermsAndConditionsPage
import 'screens/feedback_page.dart'; // Import FeedbackPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkModeEnabled = false;

  void toggleDarkMode() {
    setState(() {
      darkModeEnabled = !darkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: darkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                Icons.health_and_safety, // Safety icon
                color: Colors.white,
                size: 28, // Adjust the size as needed
              ).animate().fadeIn(duration: 500.ms),
              SizedBox(width: 8), // Add spacing between the icon and text
              Text(
                'Amaan Health Travel Insurance',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 500.ms),
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
            ).animate().fadeIn(delay: 400.ms),
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
            ).animate().fadeIn(delay: 500.ms),
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
            ).animate().fadeIn(delay: 600.ms),

            // Dark Mode Icon
            IconButton(
              icon: Icon(Icons.dark_mode, color: Colors.white),
              onPressed: toggleDarkMode, // Toggle dark mode
            ).animate().fadeIn(delay: 700.ms),
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
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Contact'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.policy),
                title: Text('My Policies'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPoliciesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment), // Icon for Claims
                title: Text('Claims'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClaimsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.support), // Icon for Support
                title: Text('Support'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person), // Icon for Profile
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications), // Icon for Notifications
                title: Text('Notifications'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                  );
                },
              ),
            ],
          ),
        ),
        // Add a body to the Scaffold
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Custom Hero Section
              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/travel_family.jpg'), // Add a background image
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Health, Our Priority – Anywhere You Go!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Comprehensive health and travel insurance plans tailored to your needs',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Get a Quote page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GetStartedPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                            color: Colors.blue[800],
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms),
                    ],
                  ),
                ),
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
                    ).animate().fadeIn(duration: 500.ms),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FeatureItem(
                          icon: Icons.medical_services,
                          title: '24/7 Global Assistance',
                          description: 'From medical emergencies to trip cancellations, we’ve got you covered.',
                        ).animate().slideX(delay: 200.ms),
                        FeatureItem(
                          icon: Icons.health_and_safety,
                          title: 'Comprehensive Coverage',
                          description: 'Protection for all your travel needs.',
                        ).animate().slideX(delay: 400.ms),
                        FeatureItem(
                          icon: Icons.assignment_turned_in,
                          title: 'Easy Claims Process',
                          description: 'Hassle-free claims submission and processing.',
                        ).animate().slideX(delay: 600.ms),
                        FeatureItem(
                          icon: Icons.attach_money,
                          title: 'Affordable Plans',
                          description: 'Budget-friendly options for every traveler.',
                        ).animate().slideX(delay: 800.ms),
                      ],
                    ),
                  ],
                ),
              ),

              // Testimonials Section
              Container(
                color: Colors.grey[100],
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
                    ).animate().fadeIn(duration: 500.ms),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TestimonialItem(
                            name: 'John Doe',
                            review: 'Great service! They helped me during my trip to Europe.',
                            image: 'assets/images/john_doe.jpg', // Add user photo
                          ).animate().slideX(delay: 200.ms),
                          TestimonialItem(
                            name: 'Jane Smith',
                            review: 'Affordable plans and excellent customer support.',
                            image: 'assets/images/jane_smith.jpg', // Add user photo
                          ).animate().slideX(delay: 400.ms),
                          TestimonialItem(
                            name: 'Mike Johnson',
                            review: 'The claims process was seamless and quick.',
                            image: 'assets/images/mike_johnson.jpg', // Add user photo
                          ).animate().slideX(delay: 600.ms),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Start Now Section with Nearby Hospitals and Destination Health Alerts
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 5),
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
                    ).animate().fadeIn(duration: 500.ms),
                    SizedBox(height: 10),
                    Text(
                      'Get started with your health travel insurance today.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(duration: 500.ms),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Destination Health Alerts Button
                        _buildActionButton(
                          icon: Icons.warning,
                          label: 'Health Alerts',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DestinationHealthAlertsPage()),
                            );
                          },
                        ).animate().slideX(delay: 200.ms),
                        // Start Now Button
                        _buildActionButton(
                          icon: Icons.arrow_forward,
                          label: 'Start Now',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GetStartedPage()),
                            );
                          },
                        ).animate().slideX(delay: 400.ms),
                        // Nearby Hospitals Button
                        _buildActionButton(
                          icon: Icons.local_hospital,
                          label: 'Nearby Hospitals',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NearbyHospitalsPage()),
                            );
                          },
                        ).animate().slideX(delay: 600.ms),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Custom Footer
        bottomNavigationBar: Container(
          height: 80, // Adjust height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, -2), // Shadow at the top of the footer
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home Icon
              _buildFooterItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              // Galleries Icon
              _buildFooterItem(
                icon: Icons.photo_library, // Icon for Galleries
                label: 'Galleries',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleriesPage()),
                  );
                },
              ),
              // Shop Insurance
              _buildFooterItem(
                icon: Icons.shopping_cart,
                label: 'Shop Insurance',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsuranceSearchFilter()),
                  );
                },
              ),
              // Track Maintenance
              _buildFooterItem(
                icon: Icons.directions_car,
                label: 'Track Maintenance',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPoliciesPage()),
                  );
                },
              ),
              // Drive Safe
              _buildFooterItem(
                icon: Icons.star,
                label: 'Drive Safe',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RewardsPage()),
                  );
                },
              ),
              // Emergency
              _buildFooterItem(
                icon: Icons.emergency,
                label: 'Emergency',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyPage()),
                  );
                },
              ),
              // Documents
              _buildFooterItem(
                icon: Icons.description,
                label: 'Documents',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PolicyDocumentsPage()),
                  );
                },
              ),
              // Finances
              _buildFooterItem(
                icon: Icons.attach_money,
                label: 'Finances',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinancesPage()),
                  );
                },
              ),
              // Help Center
              _buildFooterItem(
                icon: Icons.help,
                label: 'Help Center',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpCenterPage()),
                  );
                },
              ),
              // More List Icon
              _buildFooterItem(
                icon: Icons.more_horiz, // Icon for More List
                label: 'More',
                onTap: () {
                  _showMoreOptions(context); // Show more options
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build footer items
  Widget _buildFooterItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue[800], size: 30),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.blue[800], size: 20),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show More Options
  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.health_and_safety),
                title: Text('Health Tips'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthTipsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services),
                title: Text('Wellness Programs'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WellnessProgramsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.vaccines),
                title: Text('Vaccination Info'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VaccinationInfoPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Health Calculators'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthCalculatorsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('FAQ'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Terms & Conditions'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  // Add logout functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Feature Card Widget
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const FeatureCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue[800]),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Feature Item Widget
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  FeatureItem({required this.icon, required this.title, required this.description});

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
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
  final String image;

  TestimonialItem({required this.name, required this.review, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 30,
            ),
            SizedBox(height: 10),
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

// Rewards Page (Example)
class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drive Safe, Get Rewards'),
      ),
      body: Center(
        child: Text('Rewards Page Content'),
      ),
    );
  }
}

// Galleries Page
class GalleriesPage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galleries'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Image.asset(
            imagePaths[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

// Placeholder Pages for More Options
class HealthTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: Center(
        child: Text('Health Tips Page Content'),
      ),
    );
  }
}

class WellnessProgramsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wellness Programs'),
      ),
      body: Center(
        child: Text('Wellness Programs Page Content'),
      ),
    );
  }
}

class VaccinationInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination Info'),
      ),
      body: Center(
        child: Text('Vaccination Info Page Content'),
      ),
    );
  }
}

class HealthCalculatorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Calculators'),
      ),
      body: Center(
        child: Text('Health Calculators Page Content'),
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Center(
        child: Text('FAQ Page Content'),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Center(
        child: Text('Privacy Policy Page Content'),
      ),
    );
  }
}

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: Center(
        child: Text('Terms & Conditions Page Content'),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Center(
        child: Text('Feedback Page Content'),
      ),
    );
  }
}

