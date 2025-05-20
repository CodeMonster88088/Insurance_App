import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/models/user_model';
import 'package:flutter_app_test/screens/login_screen.dart';
import 'package:flutter_app_test/screens/personal_info_screen.dart';
import 'package:flutter_app_test/screens/privacy_settings_screen.dart';
import 'package:flutter_app_test/screens/notifications_screen.dart';
import 'package:flutter_app_test/screens/policies_screen.dart';
import 'package:flutter_app_test/screens/policy_history_screen.dart';
import 'package:flutter_app_test/screens/support_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  String userName = 'User';
  String userEmail = 'user@example.com';
  String userPhone = '+1 (555) 123-4567';

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: userName);
    emailController = TextEditingController(text: userEmail);
    phoneController = TextEditingController(text: userPhone);
    _loadUser();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

void _loadUser() async {
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      final fetchedUser = UserModel.fromMap(data,currentUser.uid); // Assuming you have a `fromMap` method

      setState(() {
        user = fetchedUser;
        userName = fetchedUser.fullName;
        userEmail = fetchedUser.email;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, size: 22),
            onPressed: _showEditProfile,
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(theme),
                _buildUserInfo(theme),
                _buildStats(theme),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSection("Account Settings", [
                  _buildItem(Icons.person_outline, 'Personal Information',
                      'Update your personal details', _navigateToPersonalInfo),
                  _buildItem(
                      Icons.security,
                      'Privacy & Security',
                      'Manage your account security',
                      _navigateToPrivacySettings),
                  // _buildItem(Icons.notifications, 'Notifications', 'Configure notification preferences', _navigateToNotifications),
                ]),
                const SizedBox(height: 16),
                _buildSection("Insurance", [
                  _buildItem(Icons.credit_card, 'My Policies',
                      '3 active policies', _navigateToPolicies),
                  _buildItem(Icons.history, 'Policy History',
                      'View past policies', _navigateToPolicyHistory),
                  _buildItem(Icons.help_center, 'Support Center',
                      'Get help with your policies', _navigateToSupport),
                ]),
                const SizedBox(height: 24),
                _buildLogoutButton(theme),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 220,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.blueGrey[800]!, Colors.blueGrey[900]!]
              : [
                  theme.colorScheme.primary.withOpacity(0.8),
                  theme.colorScheme.primary
                ],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: const Offset(0, 50),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue[100],
            backgroundImage:
                const AssetImage('assets/images/profile_placeholder.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      child: Column(
        children: [
          Text(userName,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface)),
          const SizedBox(height: 8),
          Text(userEmail,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.7))),
          const SizedBox(height: 8),
          Text(userPhone,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _buildStats(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statCard('3', 'Policies', Icons.policy, Colors.blue, theme),
          _statCard(
              '12', 'Claims', Icons.medical_services, Colors.green, theme),
          _statCard('5', 'Family', Icons.family_restroom, Colors.orange, theme),
        ],
      ),
    );
  }

  Widget _statCard(
      String value, String label, IconData icon, Color color, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color:
                        theme.textTheme.bodyMedium?.color?.withOpacity(0.6))),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              if (Theme.of(context).brightness == Brightness.light)
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5)),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildItem(
      IconData icon, String title, String? subtitle, VoidCallback onTap) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Icon(icon, color: theme.colorScheme.primary),
      ),
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.6)))
          : null,
      trailing: Icon(Icons.chevron_right,
          color: theme.colorScheme.onSurface.withOpacity(0.6)),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _confirmLogout,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.brightness == Brightness.dark
              ? Colors.red[700]
              : Colors.red[500],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.logout),
        label: const Text('Log Out',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _showEditProfile() {
    nameController.text = userName;
    emailController.text = userEmail;
    phoneController.text = userPhone;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Edit Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildTextField(nameController, 'Full Name'),
              const SizedBox(height: 16),
              _buildTextField(emailController, 'Email'),
              const SizedBox(height: 16),
              _buildTextField(phoneController, 'Phone Number'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userName = nameController.text;
                      userEmail = emailController.text;
                      userPhone = phoneController.text;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Profile updated successfully!')));
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (_) => false,
              );
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _navigateToPersonalInfo() => _navigate(PersonalInfoScreen());
  void _navigateToPrivacySettings() => _navigate(PrivacySettingsScreen());
  void _navigateToNotifications() => _navigate(NotificationsScreen());
  void _navigateToPolicies() => _navigate(PoliciesScreen());
  void _navigateToPolicyHistory() => _navigate(PolicyHistoryScreen());
  void _navigateToSupport() => _navigate(SupportScreen());

  void _navigate(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}
