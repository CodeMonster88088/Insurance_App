import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings App',
      theme: _lightTheme,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricAuthEnabled = false;
  String _selectedLanguage = 'English';
  bool _simpleModeEnabled = false; // New feature toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card - now changes based on simple mode
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!_simpleModeEnabled) SizedBox(height: 4),
                        if (!_simpleModeEnabled)
                          Text(
                            'user@example.com',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // App Preferences Section
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'APP PREFERENCES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.view_agenda,
                  iconColor: Colors.blue,
                  title: 'Simple Mode',
                  subtitle: _simpleModeEnabled ? 'Showing simplified interface' : 'Showing all details',
                  trailing: Switch(
                    value: _simpleModeEnabled,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() => _simpleModeEnabled = value);
                    },
                  ),
                ),
                Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.language,
                  iconColor: Colors.green,
                  title: 'Language',
                  subtitle: _simpleModeEnabled ? null : 'Select your preferred language',
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    underline: Container(),
                    dropdownColor: Theme.of(context).cardColor,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                    items: ['English', 'Arabic', 'Hindi', 'Urdu']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() => _selectedLanguage = newValue!);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Security Section - simplified in simple mode
            if (!_simpleModeEnabled) ...[
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'SECURITY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 12),
              _buildSettingsCard(
                children: [
                  _buildSettingsItem(
                    icon: Icons.lock,
                    iconColor: Colors.orange,
                    title: 'Change Password',
                    onTap: () {
                      // Navigate to change password screen
                    },
                  ),
                  Divider(height: 1, thickness: 0.5),
                  _buildSettingsItem(
                    icon: Icons.fingerprint,
                    iconColor: Colors.red,
                    title: 'Biometric Authentication',
                    trailing: Switch(
                      value: _biometricAuthEnabled,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() => _biometricAuthEnabled = value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],

            // About Section - always visible but simplified
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'ABOUT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.info,
                  iconColor: Colors.blue,
                  title: 'About App',
                  subtitle: _simpleModeEnabled ? null : 'App version 1.0.0',
                  onTap: () {
                    // Show about dialog
                  },
                ),
                if (!_simpleModeEnabled) Divider(height: 1, thickness: 0.5),
                if (!_simpleModeEnabled)
                  _buildSettingsItem(
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    title: 'Rate App',
                    onTap: () {
                      // Open app store for rating
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color iconColor = Colors.grey,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}

final ThemeData _lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blue[800]!,
    onPrimary: Colors.white,
    secondary: Colors.purple,
    onSecondary: Colors.white,
    primaryContainer: Colors.blue[100]!,
    onPrimaryContainer: Colors.blue[800]!,
  ),
  cardColor: Colors.white,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.black87),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);