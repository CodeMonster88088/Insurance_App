import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final Color primaryColor = theme.colorScheme.primary;
    final Color surfaceColor = theme.colorScheme.surface;
    final Color onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, size: 22),
            onPressed: () => _showEditProfile(context),
            tooltip: 'Edit Profile',
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 4,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile Header with Cover Photo
                _buildProfileHeader(context, isDarkMode, primaryColor, surfaceColor),
                
                // User Info Section
                _buildUserInfoSection(context, onSurface),
                
                // Stats Cards
                _buildStatsSection(context, isDarkMode),
              ],
            ),
          ),
          
                    // Profile Sections
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProfileSection(
                  context,
                  title: "Account Settings",
                  items: [
                    _buildProfileItem(
                      context,
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      subtitle: 'Update your personal details',
                      onTap: () => _navigateToPersonalInfo(context),
                    ),
                    _buildProfileItem(
                      context,
                      icon: Icons.security,
                      title: 'Privacy & Security',
                      subtitle: 'Manage your account security',
                      onTap: () => _navigateToPrivacySettings(context),
                    ),
                    _buildProfileItem(
                      context,
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Configure notification preferences',
                      onTap: () => _navigateToNotifications(context),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                _buildProfileSection(
                  context,
                  title: "Insurance",
                  items: [
                    _buildProfileItem(
                      context,
                      icon: Icons.credit_card,
                      title: 'My Policies',
                      subtitle: '3 active policies',
                      onTap: () => _navigateToPolicies(context),
                    ),
                    _buildProfileItem(
                      context,
                      icon: Icons.history,
                      title: 'Policy History',
                      subtitle: 'View past policies',
                      onTap: () => _navigateToPolicyHistory(context),
                    ),
                    _buildProfileItem(
                      context,
                      icon: Icons.help_center,
                      title: 'Support Center',
                      subtitle: 'Get help with your policies',
                      onTap: () => _navigateToSupport(context),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Logout Button
                _buildLogoutButton(context, isDarkMode),
                
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProfileHeader(BuildContext context, bool isDarkMode, Color primaryColor, Color surfaceColor) {
    return Container(
      height: 220,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.blueGrey[800]!, Colors.blueGrey[900]!]
              : [primaryColor.withOpacity(0.8), primaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: surfaceColor,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: const AssetImage('assets/images/profile_placeholder.png'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: MediaQuery.of(context).size.width / 2 - 80,
            child: GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: surfaceColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context, Color onSurface) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '+1 (555) 123-4567',
            style: TextStyle(
              fontSize: 16,
              color: onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard(
            context,
            value: '3',
            label: 'Policies',
            icon: Icons.policy,
            color: Colors.blue,
            isDarkMode: isDarkMode,
          ),
          _buildStatCard(
            context,
            value: '12',
            label: 'Claims',
            icon: Icons.medical_services,
            color: Colors.green,
            isDarkMode: isDarkMode,
          ),
          _buildStatCard(
            context,
            value: '5',
            label: 'Family',
            icon: Icons.family_restroom,
            color: Colors.orange,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
    required Color color,
    required bool isDarkMode,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDarkMode)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, {required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
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
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: colorScheme.primary),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: colorScheme.onSurface.withOpacity(0.6),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _confirmLogout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.red[700] : Colors.red[500],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        icon: const Icon(Icons.logout, size: 20),
        label: const Text(
          'Log Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showEditProfile(BuildContext context) {
    // Implement edit profile functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profile functionality coming soon!')),
    );
  }

  void _showImagePicker(BuildContext context) {
    // Implement image picker functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile picture change coming soon!')),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPersonalInfo(BuildContext context) {
    // Implement navigation
  }

  void _navigateToPrivacySettings(BuildContext context) {
    // Implement navigation
  }

  void _navigateToNotifications(BuildContext context) {
    // Implement navigation
  }

  void _navigateToPolicies(BuildContext context) {
    // Implement navigation
  }

  void _navigateToPolicyHistory(BuildContext context) {
    // Implement navigation
  }

  void _navigateToSupport(BuildContext context) {
    // Implement navigation
  }
}