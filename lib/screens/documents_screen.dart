import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentsScreen extends StatefulWidget {
  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  bool _downloadingPolicy = false;
  bool _downloadingClaim = false;
  bool _policyDownloaded = false;
  bool _claimDownloaded = false;

  Future<void> _downloadDocument(String documentName) async {
    // Simulate download process
    setState(() {
      if (documentName == 'Policy Document') {
        _downloadingPolicy = true;
      } else {
        _downloadingClaim = true;
      }
    });

    // Check storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to download files')),
      );
      return;
    }

    try {
      // Simulate download delay
      await Future.delayed(Duration(seconds: 2));
      
      // Get directory for download
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$documentName.pdf';
      
      // Simulate saving a file (in real app, you would download from server)
      final file = File(filePath);
      await file.writeAsString('This is a simulated $documentName content');

      setState(() {
        if (documentName == 'Policy Document') {
          _downloadingPolicy = false;
          _policyDownloaded = true;
        } else {
          _downloadingClaim = false;
          _claimDownloaded = true;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$documentName downloaded successfully')),
      );
    } catch (e) {
      setState(() {
        if (documentName == 'Policy Document') {
          _downloadingPolicy = false;
        } else {
          _downloadingClaim = false;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $documentName: ${e.toString()}')),
      );
    }
  }

  Future<void> _openDocument(String documentName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$documentName.pdf';
      final file = File(filePath);

      if (await file.exists()) {
        await OpenFile.open(filePath);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please download the document first')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open document: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Documents'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh documents list
              setState(() {
                _policyDownloaded = false;
                _claimDownloaded = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Documents refreshed')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildDocumentItem(
            icon: Icons.picture_as_pdf,
            title: 'Policy Document',
            subtitle: 'PDF - 2.4 MB',
            downloaded: _policyDownloaded,
            downloading: _downloadingPolicy,
          ),
          _buildDocumentItem(
            icon: Icons.picture_as_pdf,
            title: 'Claim Form',
            subtitle: 'PDF - 1.1 MB',
            downloaded: _claimDownloaded,
            downloading: _downloadingClaim,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool downloaded,
    required bool downloading,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: downloading
            ? CircularProgressIndicator()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (downloaded)
                    IconButton(
                      icon: Icon(Icons.remove_red_eye, color: Colors.blue),
                      onPressed: () => _openDocument(title),
                    ),
                  IconButton(
                    icon: Icon(
                      downloaded ? Icons.download_done : Icons.download,
                      color: downloaded ? Colors.green : Colors.blue,
                    ),
                    onPressed: downloading
                        ? null
                        : () => _downloadDocument(title),
                  ),
                ],
              ),
        onTap: downloaded ? () => _openDocument(title) : null,
      ),
    );
  }
}