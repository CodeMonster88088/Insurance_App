import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              context,
              title: 'Basic Information',
              items: [
                _buildInfoItem('Full Name', 'John Doe'),
                _buildInfoItem('Date of Birth', 'January 15, 1985'),
                _buildInfoItem('Gender', 'Male'),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: 'Contact Information',
              items: [
                _buildInfoItem('Email', 'john.doe@example.com'),
                _buildInfoItem('Phone', '+1 (555) 123-4567'),
                _buildInfoItem('Address', '123 Main St, Anytown, USA'),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: 'Identification',
              items: [
                _buildInfoItem('National ID', '123-456-789'),
                _buildInfoItem('Passport', 'AB1234567'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditPersonalInfo(context),
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required List<Widget> items}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Divider(height: 24),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditPersonalInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Personal Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'John Doe',
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'January 15, 1985',
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: 'john.doe@example.com',
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Personal information updated')),
                      );
                    },
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}