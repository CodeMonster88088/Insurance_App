import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/active_policies_screen.dart';
import 'package:flutter_app_test/screens/insurance_search_filter.dart';
import 'package:flutter_app_test/screens/login_screen.dart';
import 'package:flutter_app_test/screens/profile_screen.dart';
import 'package:flutter_app_test/screens/settings_screen.dart';
import 'signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(),
      InsuranceSearchFilter(),
      ActivePoliciesScreen(),
      _buildHelpCenterScreen(),
    ];
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.pexels.com/photos/1450360/pexels-photo-1450360.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Health, Our Priority – Anywhere You Go!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Access',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 16),
                _buildFeatureItem(
                  icon: Icons.search,
                  title: 'Find Insurance',
                  subtitle: 'Browse and compare insurance plans',
                  color: Colors.blue,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                SizedBox(height: 16),
                _buildFeatureItem(
                  icon: Icons.check_box,
                  title: 'My Policies',
                  subtitle: 'View your active insurance policies',
                  color: Colors.green,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 16),
                _buildServiceCard(
                  icon: Icons.health_and_safety,
                  title: 'Start Now',
                  subtitle: 'Begin your health journey',
                  color: Colors.teal,
                  fullWidth: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[50]!, Colors.white],
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Why Choose Us?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildSimpleFeatureItem(
                      icon: Icons.medical_services,
                      title: '24/7 Global Assistance',
                    ),
                    _buildSimpleFeatureItem(
                      icon: Icons.health_and_safety,
                      title: 'Comprehensive Coverage',
                    ),
                    _buildSimpleFeatureItem(
                      icon: Icons.attach_money,
                      title: 'Affordable Plans',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCenterScreen() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Help Center'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[600]!],
                  ),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search help articles...',
                        prefixIcon: Icon(Icons.search, color: Colors.blue),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Quick Help',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      _buildHelpOption(
                        icon: Icons.article,
                        title: 'FAQs',
                        color: Colors.blue,
                        onTap: () => _showFAQSection(context),
                      ),
                      _buildHelpOption(
                        icon: Icons.phone,
                        title: 'Call Us',
                        color: Colors.green,
                        onTap: () => _showCallSupportDialog(context),
                      ),
                      _buildHelpOption(
                        icon: Icons.email,
                        title: 'Email Us',
                        color: Colors.orange,
                        onTap: () => _showEmailSupportDialog(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Popular Articles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final articles = [
                  {'title': 'Understanding your policy', 'category': 'Policies'},
                  {'title': 'Adding family members', 'category': 'Account'},
                  {'title': 'International coverage', 'category': 'Coverage'},
                ];
                return _buildArticleItem(
                  title: articles[index]['title']!,
                  category: articles[index]['category']!,
                );
              },
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  void _showCallSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please call one of our support numbers:'),
            SizedBox(height: 20),
            _buildContactInfoTile(
              icon: Icons.phone,
              title: 'General Inquiries',
              number: '+1 (800) 123-4567',
            ),
            _buildContactInfoTile(
              icon: Icons.medical_services,
              title: 'Medical Emergencies',
              number: '+1 (800) 987-6543',
            ),
            _buildContactInfoTile(
              icon: Icons.account_balance,
              title: 'Billing Questions',
              number: '+1 (800) 555-1212',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoTile({
    required IconData icon,
    required String title,
    required String number,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(number),
      onTap: () {
        // Copy to clipboard functionality could be added here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number copied to clipboard: $number')),
        );
      },
    );
  }

  void _showEmailSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please contact us at one of these email addresses:'),
            SizedBox(height: 20),
            _buildEmailInfoTile(
              icon: Icons.email,
              title: 'General Inquiries',
              email: 'support@amaaninsurance.com',
            ),
            _buildEmailInfoTile(
              icon: Icons.medical_services,
              title: 'Claims Department',
              email: 'claims@amaaninsurance.com',
            ),
            _buildEmailInfoTile(
              icon: Icons.account_balance,
              title: 'Billing Questions',
              email: 'billing@amaaninsurance.com',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInfoTile({
    required IconData icon,
    required String title,
    required String email,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(email),
      onTap: () {
        // Copy to clipboard functionality could be added here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email copied to clipboard: $email')),
        );
      },
    );
  }

  Widget _buildSimpleFeatureItem({
    required IconData icon,
    required String title,
  }) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: Colors.blue),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color color,
    bool fullWidth = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleItem({required String title, required String category}) {
    return ListTile(
      leading: Icon(Icons.article, color: Colors.blue),
      title: Text(title),
      subtitle: Text(category),
    );
  }

  void _showFAQSection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Frequently Asked Questions', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('How do I update my personal information?'),
                      subtitle: Text('You can update your details in the Profile section'),
                    ),
                    ListTile(
                      title: Text('What should I do if I lose my insurance card?'),
                      subtitle: Text('Contact customer support for a replacement'),
                    ),
                    ListTile(
                      title: Text('How do I add a family member to my plan?'),
                      subtitle: Text('Use the account settings or contact support'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome, User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Policies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}