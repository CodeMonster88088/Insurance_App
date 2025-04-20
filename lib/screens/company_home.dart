import 'package:flutter/material.dart';

class CompanyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildWelcomeHeader(),
              SizedBox(height: 24),
              _buildStatsGrid(context),
              SizedBox(height: 24),
              _buildQuickActions(context),
              SizedBox(height: 24),
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back,',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        Text(
          'Solidarity Insurance',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(context, 'Total Policies', '1,245', Icons.policy, Colors.blue, () {
          Navigator.pushNamed(context, '/policies');
        }),
        _buildStatCard(context, 'Active Claims', '87', Icons.assignment, Colors.orange, () {
          Navigator.pushNamed(context, '/claims');
        }),
        _buildStatCard(context, 'Pending Approvals', '12', Icons.pending_actions, Colors.purple, () {
          Navigator.pushNamed(context, '/approvals');
        }),
        _buildStatCard(context, 'Revenue', '\$245,678', Icons.attach_money, Colors.green, () {
          _showRevenueDetails(context);
        }),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(context, Icons.add, 'New Policy', Colors.blue, () {
              // Navigate to new policy screen
            }),
            _buildActionButton(context, Icons.assignment, 'Process Claim', Colors.orange, () {
              Navigator.pushNamed(context, '/claims');
            }),
            _buildActionButton(context, Icons.bar_chart, 'Reports', Colors.green, () {
              // Navigate to reports screen
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: color),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildActivityItem('New claim submitted', 'CL-2023-1056', '10 mins ago'),
                Divider(),
                _buildActivityItem('Policy approved', 'POL-1005', '1 hour ago'),
                Divider(),
                _buildActivityItem('Payment received', '\$1,250.00', '3 hours ago'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.notifications_none, color: Colors.blue),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notifications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('5 new claims need review'),
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('3 policy renewals pending'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Dismiss All'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showRevenueDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Revenue Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildRevenueItem('Health Insurance', '\$120,450', 0.5),
            _buildRevenueItem('Auto Insurance', '\$85,230', 0.35),
            _buildRevenueItem('Life Insurance', '\$35,000', 0.15),
            _buildRevenueItem('Property Insurance', '\$4,998', 0.1),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueItem(String label, String value, double percentage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(value, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}