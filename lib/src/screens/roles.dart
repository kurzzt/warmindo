import 'package:flutter/material.dart';
import 'package:warung_sample/src/data.dart';
import '../data/roleHandler.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  RoleHandler roleHandler = RoleHandler();

  Future<void> _showAddRoleDialog() async {
    String namaValue = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Nama'),
                onChanged: (value) {
                  namaValue = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                roleHandler.addData(namaValue, true);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _future = roleHandler.readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Roles'),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final roles = snapshot.data!;

          return ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                return ListTile(
                    title: Text(role['nama']),
                    subtitle: Text((role['status'])
                        ? 'Status Aktif'
                        : 'Status Nonaktif'),
                    trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Perform edit action here based on role['id']
                        roleHandler.updateData(role['id'], !role['status']);
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        roleHandler.deleteData(role['id']);
                        setState(() {
                          roles.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
                );
              });
        },
        future: _future
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRoleDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
