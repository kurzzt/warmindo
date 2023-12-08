import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:warung_sample/src/data/userHandler.dart';

class UsersScreen extends StatefulWidget {
  final String title;
  final ValueChanged onTap;

  const UsersScreen({
    required this.onTap,
    this.title = 'Users',
    super.key
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserHandler userHandler = UserHandler();

  @override
  Widget build(BuildContext context) {
    final _future = userHandler.readData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                print(user.runtimeType);
                
                return ListTile(
                    title: Text(user['nama']),
                    subtitle: Text((user['status'])
                        ? 'Status Aktif'
                        : 'Status Nonaktif'),
                    onTap: () => widget.onTap(user),
                    trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Perform edit action here based on role['id']
                        // userHandler.updateData(role['id'], !user['status']);
                        // setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        userHandler.deleteData(user['id']);
                        setState(() {
                          users.removeAt(index);
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
          GoRouter.of(context).go('/users/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
