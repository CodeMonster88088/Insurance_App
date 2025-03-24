import 'package:flutter/material.dart';

class DestinationHealthAlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destination Health Alerts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: HealthAlertSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: HealthAlertList(),
    );
  }
}

class HealthAlertList extends StatefulWidget {
  @override
  _HealthAlertListState createState() => _HealthAlertListState();
}

class _HealthAlertListState extends State<HealthAlertList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _healthAlerts = [
    'COVID-19 Outbreak in New York',
    'Dengue Fever in Thailand',
    'Zika Virus in Brazil',
    'Malaria in Sub-Saharan Africa',
    'Cholera in Yemen',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _healthAlerts.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(_healthAlerts[index], animation, index);
      },
    );
  }

  Widget _buildItem(String alert, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Text(
            alert,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HealthAlertDetailPage(alert: alert),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HealthAlertDetailPage extends StatelessWidget {
  final String alert;

  HealthAlertDetailPage({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: alert,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  alert,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Detailed information about the health alert. This could include symptoms, precautions, and affected areas.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Alerts'),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthAlertSearchDelegate extends SearchDelegate<String> {
  final List<String> _healthAlerts = [
    'COVID-19 Outbreak in New York',
    'Dengue Fever in Thailand',
    'Zika Virus in Brazil',
    'Malaria in Sub-Saharan Africa',
    'Cholera in Yemen',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Pass an empty string instead of null
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _healthAlerts
        .where((alert) => alert.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // Return the selected result
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _healthAlerts
        .where((alert) => alert.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DestinationHealthAlertsPage(),
  ));
}