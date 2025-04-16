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
      darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
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
  bool _simpleModeEnabled = false;
  bool _darkModeEnabled = false;
  bool _notificationsEnabled = true;
  bool _dailyRemindersEnabled = false;
  double _fontSize = 16.0;
  String _backupFrequency = 'Weekly';
  bool _cloudBackupEnabled = true;
  bool _analyticsEnabled = true;

  final List<String> _backupFrequencies = ['Daily', 'Weekly', 'Monthly', 'Never'];

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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(context),
            SizedBox(height: 24),
            _buildSectionHeader('APP PREFERENCES'),
            SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.brightness_6,
                  iconColor: Colors.amber,
                  title: 'Dark Mode',
                  subtitle: _darkModeEnabled ? 'Dark' : 'Light',
                  trailing: Switch(
                    value: _darkModeEnabled,
                    activeColor: Colors.amber,
                    onChanged: (value) {
                      setState(() => _darkModeEnabled = value);
                    },
                  ),
                ),
                Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.view_agenda,
                  iconColor: Colors.blue,
                  title: 'Simple Mode',
                  subtitle: _simpleModeEnabled ? 'Enabled' : 'Disabled',
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
                  subtitle: _selectedLanguage,
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    underline: Container(),
                    dropdownColor: Theme.of(context).cardColor,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                    items: ['English', 'Arabic', 'Hindi', 'Urdu']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() => _selectedLanguage = newValue!);
                    },
                  ),
                ),
                if (!_simpleModeEnabled) Divider(height: 1, thickness: 0.5),
                if (!_simpleModeEnabled)
                  _buildSettingsItem(
                    icon: Icons.format_size,
                    iconColor: Colors.teal,
                    title: 'Font Size',
                    subtitle: '${_fontSize.toStringAsFixed(1)} pt',
                    trailing: SizedBox(
                      width: 120,
                      child: Slider(
                        value: _fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 12,
                        label: _fontSize.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() => _fontSize = value);
                        },
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
            _buildSectionHeader('NOTIFICATIONS'),
            SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.notifications,
                  iconColor: Colors.pink,
                  title: 'Enable Notifications',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),
                ),
                if (_notificationsEnabled) ...[
                  Divider(height: 1, thickness: 0.5),
                  _buildSettingsItem(
                    icon: Icons.alarm,
                    iconColor: Colors.indigo,
                    title: 'Daily Reminders',
                    subtitle: 'Get daily updates at 9:00 AM',
                    trailing: Switch(
                      value: _dailyRemindersEnabled,
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        setState(() => _dailyRemindersEnabled = value);
                      },
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 24),
            if (!_simpleModeEnabled) ...[
              _buildSectionHeader('SECURITY & PRIVACY'),
              SizedBox(height: 12),
              _buildSettingsCard(
                children: [
                  _buildSettingsItem(
                    icon: Icons.lock,
                    iconColor: Colors.orange,
                    title: 'Change Password',
                    onTap: () {
                      _showChangePasswordDialog(context);
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
                  Divider(height: 1, thickness: 0.5),
                  _buildSettingsItem(
                    icon: Icons.security,
                    iconColor: Colors.blueGrey,
                    title: 'Privacy Settings',
                    onTap: () {
                      _showPrivacySettings(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
            if (!_simpleModeEnabled) ...[
              _buildSectionHeader('BACKUP & SYNC'),
              SizedBox(height: 12),
              _buildSettingsCard(
                children: [
                  _buildSettingsItem(
                    icon: Icons.cloud_upload,
                    iconColor: Colors.blue,
                    title: 'Cloud Backup',
                    subtitle: _cloudBackupEnabled ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: _cloudBackupEnabled,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() => _cloudBackupEnabled = value);
                      },
                    ),
                  ),
                  if (_cloudBackupEnabled) ...[
                    Divider(height: 1, thickness: 0.5),
                    _buildSettingsItem(
                      icon: Icons.schedule,
                      iconColor: Colors.green,
                      title: 'Backup Frequency',
                      subtitle: _backupFrequency,
                      trailing: DropdownButton<String>(
                        value: _backupFrequency,
                        underline: Container(),
                        dropdownColor: Theme.of(context).cardColor,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                        items: _backupFrequencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() => _backupFrequency = newValue!);
                        },
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 24),
            ],
            _buildSectionHeader('ABOUT'),
            SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.info,
                  iconColor: Colors.blue,
                  title: 'About App',
                  subtitle: 'Version 2.3.1 (Build 47)',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                if (!_simpleModeEnabled) Divider(height: 1, thickness: 0.5),
                if (!_simpleModeEnabled)
                  _buildSettingsItem(
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    title: 'Rate App',
                    onTap: () {
                      _rateApp(context);
                    },
                  ),
                Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.share,
                  iconColor: Colors.green,
                  title: 'Share App',
                  onTap: () {
                    _shareApp(context);
                  },
                ),
                Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.help,
                  iconColor: Colors.purple,
                  title: 'Help & Support',
                  onTap: () {
                    _showHelpSupport(context);
                  },
                ),
                if (!_simpleModeEnabled) Divider(height: 1, thickness: 0.5),
                if (!_simpleModeEnabled)
                  _buildSettingsItem(
                    icon: Icons.analytics,
                    iconColor: Colors.teal,
                    title: 'Analytics',
                    subtitle: _analyticsEnabled ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: _analyticsEnabled,
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        setState(() => _analyticsEnabled = value);
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 24),
            if (!_simpleModeEnabled) ...[
              _buildSectionHeader('ADVANCED'),
              SizedBox(height: 12),
              _buildSettingsCard(
                children: [
                  _buildSettingsItem(
                    icon: Icons.storage,
                    iconColor: Colors.grey,
                    title: 'Clear Cache',
                    subtitle: '1.2 GB',
                    onTap: () {
                      _showClearCacheDialog(context);
                    },
                  ),
                  Divider(height: 1, thickness: 0.5),
                  _buildSettingsItem(
                    icon: Icons.restore,
                    iconColor: Colors.blueGrey,
                    title: 'Reset Preferences',
                    onTap: () {
                      _showResetDialog(context);
                    },
                  ),
                ],
              ),
            ],
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red[50],
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _showLogoutDialog(context);
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _showEditProfileDialog(context);
        },
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!_simpleModeEnabled) SizedBox(height: 4),
                    if (!_simpleModeEnabled)
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
              Icon(Icons.edit, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
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

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings App', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Version 2.3.1 (Build 47)'),
            SizedBox(height: 8),
            Text('© 2023 Settings App Team'),
            SizedBox(height: 16),
            Text('All rights reserved'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _currentPassword = '';
    String _newPassword = '';
    String _confirmPassword = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }
                  return null;
                },
                onChanged: (value) => _currentPassword = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (value) => _newPassword = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) => _confirmPassword = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password changed successfully')),
                );
              }
            },
            child: Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text('Are you sure you want to clear all cached data? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Preferences'),
        content: Text('This will reset all app preferences to default. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _biometricAuthEnabled = false;
                _selectedLanguage = 'English';
                _simpleModeEnabled = false;
                _darkModeEnabled = false;
                _notificationsEnabled = true;
                _dailyRemindersEnabled = false;
                _fontSize = 16.0;
                _backupFrequency = 'Weekly';
                _cloudBackupEnabled = true;
                _analyticsEnabled = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Preferences reset successfully')),
              );
            },
            child: Text('Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logged out successfully')),
              );
              // Here you would typically navigate to login screen
            },
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Settings'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Search settings...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onChanged: (value) {
            // Implement search functionality here
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _shareApp(BuildContext context) {
    // Implement actual share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing app with friends...')),
    );
  }

  void _rateApp(BuildContext context) {
    // Implement actual rate app functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirecting to app store...')),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help & Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Need help? Contact our support team:'),
            SizedBox(height: 16),
            Text('Email: support@example.com'),
            SizedBox(height: 8),
            Text('Phone: +1 (555) 123-4567'),
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

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manage your privacy preferences:'),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Allow data collection'),
              value: _analyticsEnabled,
              onChanged: (value) {
                setState(() {
                  _analyticsEnabled = value;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: 'John Doe');
    TextEditingController emailController = TextEditingController(text: 'john.doe@example.com');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Here you would typically update the profile
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
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

final ThemeData _darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blue[200]!,
    onPrimary: Colors.black,
    secondary: Colors.purple[200]!,
    onSecondary: Colors.black,
    primaryContainer: Colors.blue[800]!,
    onPrimaryContainer: Colors.white,
  ),
  cardColor: Colors.grey[900],
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
