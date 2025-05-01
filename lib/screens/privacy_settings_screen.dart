import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _rememberMe = true;
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
          _buildSectionHeader('Account Settings'),
          _buildSwitchSetting(
            'Remember Me',
            'Keep me logged in on this device',
            _rememberMe,
            (value) {
              setState(() => _rememberMe = value);
              _showConfirmation(context, 
                value ? 'You will stay logged in' : 'You will need to log in next time');
            },
          ),
          _buildDivider(),
          _buildSectionHeader('Privacy Controls'),
          _buildSwitchSetting(
            'Marketing Emails',
            'Receive promotional emails and offers',
            _marketingEmails,
            (value) {
              setState(() => _marketingEmails = value);
              _showConfirmation(context, 
                value ? 'Marketing emails enabled' : 'Marketing emails disabled');
            },
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Data Sharing',
            'Share anonymous usage data to improve our services',
            _dataSharing,
            (value) {
              setState(() => _dataSharing = value);
              _showConfirmation(context, 
                value ? 'Data sharing enabled' : 'Data sharing disabled');
            },
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Location Tracking',
            'Allow us to use your location for personalized services',
            _locationTracking,
            (value) {
              setState(() => _locationTracking = value);
              _showConfirmation(context, 
                value ? 'Location tracking enabled' : 'Location tracking disabled');
            },
          ),
          _buildDivider(),
          _buildSectionHeader('Data Management'),
          _buildActionTile(
            title: 'Download Your Data',
            subtitle: 'Request a copy of your personal data',
            icon: Icons.cloud_download,
            onTap: () => _handleDataDownload(context),
          ),
          _buildDivider(),
          _buildActionTile(
            title: 'Delete Account',
            subtitle: 'Permanently remove your account and data',
            icon: Icons.delete_outline,
            onTap: () => _showDeleteAccountDialog(context),
            isDestructive: true,
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

  Widget _buildSwitchSetting(
    String title, 
    String subtitle, 
    bool value, 
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      title: Text(
        title,
        style: isDestructive ? TextStyle(color: Colors.red) : null,
      ),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1);
  }

  Future<void> _handleDataDownload(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Preparing your data...'),
          ],
        ),
      ),
    );

    // Simulate processing delay
    await Future.delayed(Duration(seconds: 2));

    // Close loading dialog
    Navigator.of(context).pop();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your data export has started. You will receive an email when ready.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account?'),
        content: Text(
          'This will permanently delete your account and all associated data. '
          'This action cannot be undone.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _performAccountDeletion(context);
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

  Future<void> _performAccountDeletion(BuildContext context) async {
    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Deleting your account...'),
          ],
        ),
      ),
    );

    // Simulate account deletion process
    await Future.delayed(Duration(seconds: 2));

    // Close dialog
    Navigator.of(context).pop();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your account has been deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );

    // Simulate logout by popping back
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();
  }

  void _showConfirmation(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}