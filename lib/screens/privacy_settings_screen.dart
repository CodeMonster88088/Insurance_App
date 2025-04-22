import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _biometricAuth = false;
  bool _marketingEmails = true;
  bool _dataSharing = false;
  bool _locationTracking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Account Security'),
          _buildSwitchSetting(
            'Biometric Authentication',
            'Use fingerprint or face ID to log in',
            _biometricAuth,
            (value) => setState(() => _biometricAuth = value),
          ),
          _buildDivider(),
          _buildSectionHeader('Privacy Controls'),
          _buildSwitchSetting(
            'Marketing Emails',
            'Receive promotional emails and offers',
            _marketingEmails,
            (value) => setState(() => _marketingEmails = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Data Sharing',
            'Share anonymous usage data to improve our services',
            _dataSharing,
            (value) => setState(() => _dataSharing = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Location Tracking',
            'Allow us to use your location for personalized services',
            _locationTracking,
            (value) => setState(() => _locationTracking = value),
          ),
          _buildDivider(),
          _buildSectionHeader('Data Management'),
          ListTile(
            title: Text('Download Your Data'),
            subtitle: Text('Request a copy of your personal data'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showComingSoon(context),
          ),
          _buildDivider(),
          ListTile(
            title: Text('Delete Account'),
            subtitle: Text('Permanently remove your account and data'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showDeleteAccountDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1);
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('This feature is coming soon!')),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account?'),
        content: Text('This will permanently delete your account and all associated data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account deletion requested')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}