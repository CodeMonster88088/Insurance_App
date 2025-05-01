import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  // User data that can be edited
  String fullName = 'John Doe';
  String dateOfBirth = 'January 15, 1985';
  String gender = 'Male';
  String email = 'john.doe@example.com';
  String phone = '+1 (555) 123-4567';
  String address = '123 Main St, Anytown, USA';
  String nationalId = '123-456-789';
  String passport = 'AB1234567';

  // Controllers for edit form
  late TextEditingController nameController;
  late TextEditingController dobController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: fullName);
    dobController = TextEditingController(text: dateOfBirth);
    emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
                _buildInfoItem('Full Name', fullName),
                _buildInfoItem('Date of Birth', dateOfBirth),
                _buildInfoItem('Gender', gender),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: 'Contact Information',
              items: [
                _buildInfoItem('Email', email),
                _buildInfoItem('Phone', phone),
                _buildInfoItem('Address', address),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoCard(
              context,
              title: 'Identification',
              items: [
                _buildInfoItem('National ID', nationalId),
                _buildInfoItem('Passport', passport),
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
    // Update controllers with current values before showing the dialog
    nameController.text = fullName;
    dobController.text = dateOfBirth;
    emailController.text = email;

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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save the changes to state
                      setState(() {
                        fullName = nameController.text;
                        dateOfBirth = dobController.text;
                        email = emailController.text;
                      });
                      
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Personal information updated successfully!')),
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