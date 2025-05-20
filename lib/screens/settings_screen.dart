import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Settings App',
        home: const SettingsScreen(),
      );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings state variables
  bool _simpleModeEnabled = false;
  bool _notificationsEnabled = true;
  bool _dailyRemindersEnabled = false;
  // String _backupFrequency = 'Weekly';
  // bool _cloudBackupEnabled = true;
  bool _analyticsEnabled = true;

  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';

  // final List<String> _backupFrequencies = ['Daily', 'Weekly', 'Monthly', 'Never'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildSectionHeader('APP PREFERENCES'),
            const SizedBox(height: 12),
            _buildSettingsCard(children: [
              _buildSettingsSwitch(
                icon: Icons.view_agenda,
                iconColor: Colors.blue,
                title: 'Simple Mode',
                value: _simpleModeEnabled,
                onChanged: (v) => setState(() => _simpleModeEnabled = v),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('NOTIFICATIONS'),
            const SizedBox(height: 12),
            _buildSettingsCard(children: [
              _buildSettingsSwitch(
                icon: Icons.notifications,
                iconColor: Colors.pink,
                title: 'Enable Notifications',
                value: _notificationsEnabled,
                onChanged: (v) => setState(() => _notificationsEnabled = v),
              ),
              if (_notificationsEnabled) ...[
                const Divider(height: 1, thickness: 0.5),
                _buildSettingsSwitch(
                  icon: Icons.alarm,
                  iconColor: Colors.indigo,
                  title: 'Daily Reminders',
                  subtitle: 'Get daily updates at 9:00 AM',
                  value: _dailyRemindersEnabled,
                  onChanged: (v) => setState(() => _dailyRemindersEnabled = v),
                ),
              ],
            ]),
            if (!_simpleModeEnabled) ...[
              const SizedBox(height: 24),
              _buildSectionHeader('SECURITY'),
              const SizedBox(height: 12),
              _buildSettingsCard(children: [
                _buildSettingsItem(
                  icon: Icons.lock,
                  iconColor: Colors.orange,
                  title: 'Change Password',
                  onTap: () => _showChangePasswordDialog(context),
                ),
                const Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.security,
                  iconColor: Colors.blueGrey,
                  title: 'Privacy Settings',
                  onTap: () => _showPrivacySettings(context),
                ),
              ]),
            ],
            const SizedBox(height: 24),
            _buildSectionHeader('ABOUT'),
            const SizedBox(height: 12),
            _buildSettingsCard(children: [
              _buildSettingsItem(
                icon: Icons.info,
                iconColor: Colors.blue,
                title: 'About App',
                subtitle: 'Version 2.3.1 (Build 47)',
                onTap: () => _showAboutDialog(context),
              ),
              if (!_simpleModeEnabled) const Divider(height: 1, thickness: 0.5),
              if (!_simpleModeEnabled)
                _buildSettingsItem(
                  icon: Icons.star,
                  iconColor: Colors.amber,
                  title: 'Rate App',
                  onTap: () => _rateApp(context),
                ),
              const Divider(height: 1, thickness: 0.5),
              _buildSettingsItem(
                icon: Icons.share,
                iconColor: Colors.green,
                title: 'Share App',
                onTap: () => _shareApp(context),
              ),
              const Divider(height: 1, thickness: 0.5),
              _buildSettingsItem(
                icon: Icons.help,
                iconColor: Colors.purple,
                title: 'Help & Support',
                onTap: () => _showHelpSupport(context),
              ),
              if (!_simpleModeEnabled) const Divider(height: 1, thickness: 0.5),
              if (!_simpleModeEnabled)
                _buildSettingsSwitch(
                  icon: Icons.analytics,
                  iconColor: Colors.teal,
                  title: 'Analytics',
                  subtitle: _analyticsEnabled ? 'Enabled' : 'Disabled',
                  value: _analyticsEnabled,
                  onChanged: (v) => setState(() => _analyticsEnabled = v),
                ),
            ]),
            if (!_simpleModeEnabled) ...[
              const SizedBox(height: 24),
              _buildSectionHeader('ADVANCED'),
              const SizedBox(height: 12),
              _buildSettingsCard(children: [
                _buildSettingsItem(
                  icon: Icons.storage,
                  iconColor: Colors.grey,
                  title: 'Clear Cache',
                  subtitle: '1.2 GB',
                  onTap: () => _showClearCacheDialog(context),
                ),
                const Divider(height: 1, thickness: 0.5),
                _buildSettingsItem(
                  icon: Icons.restore,
                  iconColor: Colors.blueGrey,
                  title: 'Reset Preferences',
                  onTap: () => _showResetDialog(context),
                ),
              ]),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }



  Widget _buildSectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
            letterSpacing: 1.2,
          ),
        ),
      );

  Widget _buildSettingsCard({required List<Widget> children}) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(children: children),
      );

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color iconColor = Colors.grey,
    Widget? trailing,
    VoidCallback? onTap,
  }) =>
      ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing:
            trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  Widget _buildSettingsSwitch({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconColor = Colors.grey,
  }) =>
      _buildSettingsItem(
        icon: icon,
        iconColor: iconColor,
        title: title,
        subtitle: subtitle,
        trailing: Switch(
          value: value,
          activeColor: iconColor,
          onChanged: onChanged,
        ),
      );

  Widget _buildSettingsDropdown({
    required IconData icon,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
    Color iconColor = Colors.grey,
  }) =>
      ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: DropdownButton<String>(
          value: value,
          items: options
              .map((opt) => DropdownMenuItem(
                    value: opt,
                    child: Text(opt),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          underline: const SizedBox(),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Dialogs and actions

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _userName = nameController.text.trim();
                _userEmail = emailController.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: currentPassword,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
              ),
              TextField(
                controller: newPassword,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: confirmPassword,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm New Password'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (newPassword.text == confirmPassword.text &&
                  newPassword.text.isNotEmpty) {
                // Perform password change logic here
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Password changed successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Passwords do not match')),
                );
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    // Placeholder for privacy settings screen/dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Settings'),
        content: const Text('Privacy settings can be configured here.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Settings App',
      applicationVersion: '2.3.1 (Build 47)',
      applicationIcon: const Icon(Icons.settings),
      children: const [
        Text('This app demonstrates an advanced settings screen in Flutter.'),
      ],
    );
  }

  void _rateApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you for rating our app!')),
    );
  }

  void _shareApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Text('For support, contact support@example.com'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear the cache?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Preferences'),
        content: const Text(
            'Are you sure you want to reset all preferences to default?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _simpleModeEnabled = false;
                _notificationsEnabled = true;
                _dailyRemindersEnabled = false;
                // _backupFrequency = 'Weekly';
                // _cloudBackupEnabled = true;
                _analyticsEnabled = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preferences reset to default')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
