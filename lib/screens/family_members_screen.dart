import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Members',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FamilyMembersScreen(),
    );
  }
}

class FamilyMembersScreen extends StatefulWidget {
  @override
  _FamilyMembersScreenState createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  List<FamilyMember> _familyMembers = [
    FamilyMember(name: 'Sarah Doe', relationship: 'Spouse', age: 35),
    FamilyMember(name: 'Michael Doe', relationship: 'Child', age: 10),
  ];
  
  List<FamilyMember> _filteredMembers = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredMembers = _familyMembers;
  }

  void _filterMembers(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredMembers = _familyMembers;
      } else {
        _filteredMembers = _familyMembers.where((member) {
          return member.name.toLowerCase().contains(_searchQuery) ||
              member.relationship.toLowerCase().contains(_searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Members'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: _filteredMembers.isEmpty
          ? Center(
              child: Text(
                _searchQuery.isEmpty 
                  ? 'No family members added yet' 
                  : 'No members found for "$_searchQuery"',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _filteredMembers.length,
              itemBuilder: (context, index) {
                final member = _filteredMembers[index];
                return _buildFamilyMemberCard(member, index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddEditFamilyMemberDialog(),
      ),
    );
  }

  Widget _buildFamilyMemberCard(FamilyMember member, int index) {
    // Find the original index in case we're filtering
    final originalIndex = _familyMembers.indexWhere((m) => m.name == member.name);
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getAvatarColor(member.relationship),
          child: Icon(
            _getAvatarIcon(member.relationship),
            color: Colors.white,
          ),
        ),
        title: Text(member.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${member.relationship} • ${member.age} years old'),
            if (member.notes != null && member.notes!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  member.notes!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handlePopupMenuSelection(value, originalIndex),
          itemBuilder: (BuildContext context) {
            return {'Edit', 'Delete'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
        onTap: () => _showAddEditFamilyMemberDialog(
          member: member, 
          index: originalIndex,
        ),
      ),
    );
  }

  void _showAddEditFamilyMemberDialog({FamilyMember? member, int? index}) {
    final isEditing = member != null;
    final nameController = TextEditingController(text: isEditing ? member.name : '');
    final relationshipController = TextEditingController(text: isEditing ? member.relationship : '');
    final ageController = TextEditingController(text: isEditing ? member.age.toString() : '');
    final notesController = TextEditingController(text: isEditing ? member.notes : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Family Member' : 'Add Family Member'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: relationshipController,
                  decoration: InputDecoration(labelText: 'Relationship'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  decoration: InputDecoration(labelText: 'Notes (optional)'),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(isEditing ? 'Update' : 'Add'),
              onPressed: () {
                final newMember = FamilyMember(
                  name: nameController.text,
                  relationship: relationshipController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  notes: notesController.text.isNotEmpty ? notesController.text : null,
                );

                setState(() {
                  if (isEditing && index != null) {
                    _familyMembers[index] = newMember;
                  } else {
                    _familyMembers.add(newMember);
                  }
                  // Update filtered list after adding/editing
                  _filterMembers(_searchQuery);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handlePopupMenuSelection(String value, int index) {
    switch (value) {
      case 'Edit':
        _showAddEditFamilyMemberDialog(member: _familyMembers[index], index: index);
        break;
      case 'Delete':
        _deleteFamilyMember(index);
        break;
    }
  }

  void _deleteFamilyMember(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Family Member'),
        content: Text('Are you sure you want to delete ${_familyMembers[index].name}?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _familyMembers.removeAt(index);
                _filterMembers(_searchQuery);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    final searchController = TextEditingController(text: _searchQuery);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search Family Members'),
          content: TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search by name or relationship',
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        _filterMembers('');
                      },
                    )
                  : null,
            ),
            onChanged: _filterMembers,
          ),
          actions: [
            TextButton(
              child: Text('Clear'),
              onPressed: () {
                searchController.clear();
                _filterMembers('');
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    ).then((_) {
      // Clear search when dialog is closed if desired
      // _filterMembers('');
    });
  }

  IconData _getAvatarIcon(String relationship) {
    switch (relationship.toLowerCase()) {
      case 'spouse':
        return Icons.favorite;
      case 'child':
        return Icons.child_care;
      case 'parent':
        return Icons.accessible_forward;
      default:
        return Icons.person;
    }
  }

  Color _getAvatarColor(String relationship) {
    switch (relationship.toLowerCase()) {
      case 'spouse':
        return Colors.pink;
      case 'child':
        return Colors.blue;
      case 'parent':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}

class FamilyMember {
  final String name;
  final String relationship;
  final int age;
  final String? notes;

  FamilyMember({
    required this.name,
    required this.relationship,
    required this.age,
    this.notes,
  });
}