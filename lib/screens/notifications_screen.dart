import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _policyUpdates = true;
  bool _promotionalOffers = false;
  bool _paymentReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Notification Preferences'),
          _buildSwitchSetting(
            'Push Notifications',
            'Receive app notifications',
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Email Notifications',
            'Receive notifications via email',
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'SMS Notifications',
            'Receive text message notifications',
            _smsNotifications,
            (value) => setState(() => _smsNotifications = value),
          ),
          SizedBox(height: 24),
          _buildSectionHeader('Notification Types'),
          _buildSwitchSetting(
            'Policy Updates',
            'Important changes to your policies',
            _policyUpdates,
            (value) => setState(() => _policyUpdates = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Promotional Offers',
            'Special offers and discounts',
            _promotionalOffers,
            (value) => setState(() => _promotionalOffers = value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Payment Reminders',
            'Upcoming payment notifications',
            _paymentReminders,
            (value) => setState(() => _paymentReminders = value),
          ),
          SizedBox(height: 24),
          _buildSectionHeader('Notification Schedule'),
          ListTile(
            title: Text('Quiet Hours'),
            subtitle: Text('9:00 PM - 7:00 AM'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showQuietHoursDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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

  void _showQuietHoursDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Quiet Hours'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select time range when notifications should be silent'),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: '9:00 PM',
                    items: List.generate(24, (index) {
                      final hour = index + 1;
                      final time = hour > 12 ? '${hour - 12}:00 PM' : '$hour:00 AM';
                      return DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                Text('to'),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: '7:00 AM',
                    items: List.generate(24, (index) {
                      final hour = index + 1;
                      final time = hour > 12 ? '${hour - 12}:00 PM' : '$hour:00 AM';
                      return DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      );
                    }),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Quiet hours updated')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}