import 'package:flutter/material.dart';

class PolicyDocumentsPage extends StatelessWidget {
  // Dummy policy documents data
  final List<Map<String, String>> policyDocuments = [
    {
      'title': 'Policy Summary',
      'date': '2023-10-01',
      'type': 'PDF',
    },
    {
      'title': 'Terms and Conditions',
      'date': '2023-10-01',
      'type': 'PDF',
    },
    {
      'title': 'Claim Form',
      'date': '2023-10-01',
      'type': 'Word',
    },
    {
      'title': 'Insurance Certificate',
      'date': '2023-10-01',
      'type': 'PDF',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Documents'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for documents...',
                prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),

            // Policy Documents List
            Text(
              'Your Policy Documents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),
            ...policyDocuments.map((document) => _buildDocumentItem(document)).toList(),
          ],
        ),
      ),
    );
  }

  // Document Item Widget
  Widget _buildDocumentItem(Map<String, String> document) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          document['type'] == 'PDF' ? Icons.picture_as_pdf : Icons.description,
          color: Colors.blue[800],
        ),
        title: Text(
          document['title']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Date: ${document['date']} | Type: ${document['type']}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.download, color: Colors.blue[800]),
          onPressed: () {
            // Add functionality to download the document
          },
        ),
        onTap: () {
          // Add functionality to preview the document
        },
      ),
    );
  }
}