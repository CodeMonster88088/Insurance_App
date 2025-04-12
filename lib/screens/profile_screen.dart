import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, size: 22),
            onPressed: () {
              // Navigate to edit profile screen
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header with Cover Photo
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [Colors.blueGrey[800]!, Colors.blueGrey[900]!]
                      : [Colors.blue[400]!, Colors.blue[600]!],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode ? Colors.blueGrey[800]! : Colors.white,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue[100],
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    right: MediaQuery.of(context).size.width / 2 - 70,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.blue[600]! : Colors.blue[500]!,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Colors.blueGrey[800]! : Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            // User Info
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),

            SizedBox(height: 32),

            // Profile Sections
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                boxShadow: [
                  if (!isDarkMode)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    subtitle: 'Update your personal details',
                    onTap: () {
                      // Navigate to personal info screen
                    },
                  ),
                  Divider(height: 1, indent: 72),
                  _buildProfileItem(
                    context,
                    icon: Icons.credit_card,
                    title: 'Payment Methods',
                    subtitle: '2 cards saved',
                    onTap: () {
                      // Navigate to payment methods screen
                    },
                  ),
                  Divider(height: 1, indent: 72),
                  _buildProfileItem(
                    context,
                    icon: Icons.history,
                    title: 'Policy History',
                    subtitle: 'View past policies',
                    onTap: () {
                      // Navigate to policy history screen
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.red[700] : Colors.red[500],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.blue[900] : Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isDarkMode ? Colors.blue[200] : Colors.blue),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: theme.iconTheme.color?.withOpacity(0.6)),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
