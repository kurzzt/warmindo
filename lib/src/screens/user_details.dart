import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final dynamic user;

  UserDetailsScreen({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) { 
    final Map userr = Map.from(user);
    return Scaffold(
      appBar: AppBar(
        title: Text(userr['nama']),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Center(
            child : CircleAvatar(
              backgroundImage: NetworkImage(userr['foto']),
              minRadius: 100,
            ),
          ),
          Text('Username : ${userr['username']}'),
          Text('Nama : ${userr['nama']}'),
          Text('Status : ${(userr['status']) ? "Aktif" : "Tidak Aktif"}'),
          Text('Role : ${userr['role']['nama']}'),
        ],
      )
    );
  }
}