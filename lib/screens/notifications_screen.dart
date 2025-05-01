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
  String _quietHoursStart = '9:00 PM';
  String _quietHoursEnd = '7:00 AM';

  final List<String> _timeOptions = List.generate(24, (index) {
    final hour = index;
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour < 12 ? 'AM' : 'PM';
    return '$displayHour:00 $period';
  });

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
            (value) => _updateSetting('push', value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Email Notifications',
            'Receive notifications via email',
            _emailNotifications,
            (value) => _updateSetting('email', value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'SMS Notifications',
            'Receive text message notifications',
            _smsNotifications,
            (value) => _updateSetting('sms', value),
          ),
          SizedBox(height: 24),
          _buildSectionHeader('Notification Types'),
          _buildSwitchSetting(
            'Policy Updates',
            'Important changes to your policies',
            _policyUpdates,
            (value) => _updateSetting('policy', value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Promotional Offers',
            'Special offers and discounts',
            _promotionalOffers,
            (value) => _updateSetting('promo', value),
          ),
          _buildDivider(),
          _buildSwitchSetting(
            'Payment Reminders',
            'Upcoming payment notifications',
            _paymentReminders,
            (value) => _updateSetting('payment', value),
          ),
          SizedBox(height: 24),
          _buildSectionHeader('Notification Schedule'),
          _buildQuietHoursTile(),
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
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildQuietHoursTile() {
    return ListTile(
      title: Text('Quiet Hours'),
      subtitle: Text('$_quietHoursStart - $_quietHoursEnd'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => _showQuietHoursDialog(context),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1);
  }

  void _updateSetting(String type, bool value) {
    setState(() {
      switch (type) {
        case 'push':
          _pushNotifications = value;
          break;
        case 'email':
          _emailNotifications = value;
          break;
        case 'sms':
          _smsNotifications = value;
          break;
        case 'policy':
          _policyUpdates = value;
          break;
        case 'promo':
          _promotionalOffers = value;
          break;
        case 'payment':
          _paymentReminders = value;
          break;
      }
    });
    
    // Show confirmation
    final settingName = {
      'push': 'Push notifications',
      'email': 'Email notifications',
      'sms': 'SMS notifications',
      'policy': 'Policy updates',
      'promo': 'Promotional offers',
      'payment': 'Payment reminders',
    }[type];
    
    _showConfirmation(
      context,
      '$settingName ${value ? 'enabled' : 'disabled'}'
    );
  }

  void _showQuietHoursDialog(BuildContext context) {
    String newStart = _quietHoursStart;
    String newEnd = _quietHoursEnd;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
                      value: _quietHoursStart,
                      items: _timeOptions.map((time) {
                        return DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          newStart = value;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('to'),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _quietHoursEnd,
                      items: _timeOptions.map((time) {
                        return DropdownMenuItem(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          newEnd = value;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                      ),
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
                setState(() {
                  _quietHoursStart = newStart;
                  _quietHoursEnd = newEnd;
                });
                Navigator.pop(context);
                _showConfirmation(context, 'Quiet hours updated');
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
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