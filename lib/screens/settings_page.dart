import 'package:flutter/material.dart';
import 'package:animations/animations.dart'; // For animations
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For icons


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            OpenContainer(
              transitionDuration: Duration(milliseconds: 500),
              closedBuilder: (context, action) {
                return Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Replace with user's profile image
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          Text(
                            'john.doe@example.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue[800]),
                        onPressed: action,
                      ),
                    ],
                  ),
                );
              },
              openBuilder: (context, action) {
                return EditProfilePage(); // Navigate to Edit Profile Page
              },
            ),

            // Notification Settings
            SettingsSection(
              title: 'Notifications',
              children: [
                SettingsItem(
                  icon: Icons.notifications,
                  title: 'Enable Notifications',
                  trailing: Switch(
                    value: true, // Replace with actual state
                    onChanged: (value) {
                      // Update notification settings
                    },
                    activeColor: Colors.blue[800],
                  ),
                ),
                SettingsItem(
                  icon: Icons.email,
                  title: 'Email Notifications',
                  trailing: Switch(
                    value: false, // Replace with actual state
                    onChanged: (value) {
                      // Update email notification settings
                    },
                    activeColor: Colors.blue[800],
                  ),
                ),
              ],
            ),

            // Language Settings
            SettingsSection(
              title: 'Language',
              children: [
                SettingsItem(
                  icon: Icons.language,
                  title: 'App Language',
                  trailing: DropdownButton<String>(
                    value: 'English', // Default language
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blue[800]),
                    onChanged: (String? newValue) {
                      // Handle language change
                    },
                    items: <String>['English', 'Arabic', 'Hindi', 'Urdu']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            // Security Settings
            SettingsSection(
              title: 'Security',
              children: [
                SettingsItem(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    // Navigate to Change Password Page
                  },
                ),
                SettingsItem(
                  icon: Icons.fingerprint,
                  title: 'Enable Biometric Login',
                  trailing: Switch(
                    value: true, // Replace with actual state
                    onChanged: (value) {
                      // Update biometric settings
                    },
                    activeColor: Colors.blue[800],
                  ),
                ),
              ],
            ),

            // Help & Support
            SettingsSection(
              title: 'Help & Support',
              children: [
                SettingsItem(
                  icon: Icons.help_outline,
                  title: 'FAQs',
                  onTap: () {
                    // Navigate to FAQs Page
                  },
                ),
                SettingsItem(
                  icon: Icons.contact_support,
                  title: 'Contact Support',
                  onTap: () {
                    // Navigate to Contact Support Page
                  },
                ),
              ],
            ),

            // Logout Button
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Profile Page
class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150', // Replace with user's profile image
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Section Widget
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          ...children,
        ],
      ),
    );
  }
}

// Settings Item Widget
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  SettingsItem({required this.icon, required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue[800],
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}