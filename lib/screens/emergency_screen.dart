import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  // Function to show emergency dialogs
  void _showEmergencyDialog(BuildContext context, String service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call $service?'),
        content: Text('Do you want to call the nearest $service?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $service...'),
                  duration: const Duration(seconds: 2),
                ),
              );
              // In a real app, you would implement actual calling functionality here
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Services'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Emergency contacts section
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.emergency, color: Colors.red),
              title: const Text('Police'),
              subtitle: const Text('Call local police emergency number'),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _showEmergencyDialog(context, 'Police'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.red),
              title: const Text('Ambulance'),
              subtitle: const Text('Call emergency medical services'),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _showEmergencyDialog(context, 'Ambulance'),
              ),
            ),
          ),
          
          // Emergency tools section
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Emergency Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.red),
              title: const Text('Send SOS'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Send SOS?'),
                    content: const Text('This will send your location to emergency contacts'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('SOS sent to emergency contacts'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}