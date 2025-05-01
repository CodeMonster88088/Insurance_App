import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Claims App',
    home: MyClaimsScreen(),
  ));
}

class MyClaimsScreen extends StatefulWidget {
  @override
  _MyClaimsScreenState createState() => _MyClaimsScreenState();
}

class _MyClaimsScreenState extends State<MyClaimsScreen> {
  List<Claim> _claims = [
    Claim(
      id: '12345',
      date: DateTime(2023, 1, 15),
      status: ClaimStatus.approved,
      amount: 1250.00,
      type: 'Medical',
      description: 'Hospital visit for annual checkup',
    ),
    Claim(
      id: '67890',
      date: DateTime(2023, 2, 20),
      status: ClaimStatus.pending,
      amount: 750.50,
      type: 'Dental',
      description: 'Root canal treatment',
    ),
    Claim(
      id: '54321',
      date: DateTime(2023, 3, 10),
      status: ClaimStatus.rejected,
      amount: 300.00,
      type: 'Vision',
      description: 'New prescription glasses',
      rejectionReason: 'Not covered under current plan',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Claims'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToNewClaim(context),
          ),
        ],
      ),
      body: _claims.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: _claims.length,
              itemBuilder: (context, index) {
                final claim = _claims[index];
                return _buildClaimCard(claim, context);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Claims Submitted',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to file a new claim',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimCard(Claim claim, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: _buildStatusIcon(claim.status),
        title: Text('Claim #${claim.id}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_formatDate(claim.date)} - ${_getStatusText(claim.status)}'),
            SizedBox(height: 4),
            Text('\$${claim.amount.toStringAsFixed(2)} • ${claim.type}'),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () => _navigateToClaimDetails(context, claim),
      ),
    );
  }

  Widget _buildStatusIcon(ClaimStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case ClaimStatus.approved:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case ClaimStatus.pending:
        icon = Icons.pending;
        color = Colors.orange;
        break;
      case ClaimStatus.rejected:
        icon = Icons.cancel;
        color = Colors.red;
        break;
    }

    return Icon(icon, color: color);
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  String _getStatusText(ClaimStatus status) {
    return status.toString().split('.').last;
  }

  void _navigateToClaimDetails(BuildContext context, Claim claim) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClaimDetailsScreen(claim: claim),
      ),
    );
  }

  void _navigateToNewClaim(BuildContext context) async {
    final newClaim = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewClaimScreen(),
      ),
    );

    if (newClaim != null) {
      setState(() {
        _claims.add(newClaim);
      });
    }
  }
}

class ClaimDetailsScreen extends StatelessWidget {
  final Claim claim;

  const ClaimDetailsScreen({required this.claim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim #${claim.id}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusRow('Status', claim.status),
            _buildDetailRow('Date Submitted', _formatDate(claim.date)),
            _buildDetailRow('Claim Type', claim.type),
            _buildDetailRow('Amount', '\$${claim.amount.toStringAsFixed(2)}'),
            _buildDetailRow('Description', claim.description),
            if (claim.status == ClaimStatus.rejected)
              _buildDetailRow('Rejection Reason', claim.rejectionReason ?? 'N/A'),
            Spacer(),
            if (claim.status == ClaimStatus.pending)
              ElevatedButton(
                onPressed: () {},
                child: Text('Check Status'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, ClaimStatus status) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              _buildStatusIcon(status),
              SizedBox(width: 8),
              Text(_getStatusText(status)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ClaimStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case ClaimStatus.approved:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case ClaimStatus.pending:
        icon = Icons.pending;
        color = Colors.orange;
        break;
      case ClaimStatus.rejected:
        icon = Icons.cancel;
        color = Colors.red;
        break;
    }

    return Icon(icon, size: 20, color: color);
  }

  String _getStatusText(ClaimStatus status) {
    return status.toString().split('.').last;
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class NewClaimScreen extends StatefulWidget {
  @override
  _NewClaimScreenState createState() => _NewClaimScreenState();
}

class _NewClaimScreenState extends State<NewClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Claim'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Claim Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a claim type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newClaim = Claim(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      date: DateTime.now(),
                      status: ClaimStatus.pending,
                      amount: double.parse(_amountController.text),
                      type: _typeController.text,
                      description: _descriptionController.text,
                    );
                    
                    Navigator.pop(context, newClaim);
                  }
                },
                child: Text('Submit Claim'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ClaimStatus { approved, pending, rejected }

class Claim {
  final String id;
  final DateTime date;
  final ClaimStatus status;
  final double amount;
  final String type;
  final String description;
  final String? rejectionReason;

  Claim({
    required this.id,
    required this.date,
    required this.status,
    required this.amount,
    required this.type,
    required this.description,
    this.rejectionReason,
  });
}