import 'package:flutter/material.dart';
import 'package:warung_sample/src/data/userHandler.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  UserDetailsScreen({
    required this.userId,
    super.key,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserHandler userHandler = UserHandler();

  @override
  Widget build(BuildContext context) { 
    final _future = userHandler.readDataById(int.parse(widget.userId.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId.toString()),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data![0];
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
              Center(
                child : CircleAvatar(
                  backgroundImage: NetworkImage(user["foto"]),
                  minRadius: 100,
                ),
              ),
              Text('Username : ${user["username"]}'),
              Text('Nama : ${user["nama"]}'),
              Text('Status : ${(user["status"]) ? "Aktif" : "Tidak Aktif"}'),
              Text('Role : ${user["role"]['nama']}'),
            ],
          );
        },
        future: _future
      ),
    );
  }
}
