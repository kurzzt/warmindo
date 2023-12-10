import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warung_sample/src/data/userHandler.dart';
import 'package:warung_sample/src/widgets/avatar.dart';

class EditUserScreen extends StatefulWidget {
  final dynamic user;

  const EditUserScreen({
    super.key,
    this.user,
  });

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  UserHandler userHandler = UserHandler();

  final _usernameController = TextEditingController();
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  late int _roleId;
  late int _userId;
  var roles = [];
  
  bool _status = true;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
    _getProfile(widget.user);
  }


  @override
  Widget build(BuildContext context) {
    final Map userr = Map.from(widget.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${userr['nama']} Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Center(
            child : Avatar(
              imageUrl: _avatarUrl,
              onUpload: _onUpload,
            ),
          ),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          TextFormField(
            controller: _namaController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: _roleController,
            decoration: const InputDecoration(labelText: 'Role'),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status'),
                Switch(
                  value: _status,
                  onChanged: (value){
                    setState(() {
                      _status = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                )
              ]
          ),
          DropdownButtonFormField(
            value: _roleId.toString(), // Assuming _roleId is a String
            items: roles.map((role) {
              return DropdownMenuItem(
                value: role['id'].toString(), // Assuming 'id' is the key for role IDs
                child: Text(role['nama'] as String), // Assuming 'nama' is the key for role names
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _roleId = int.parse(newValue!);
                print(_roleId);
              });
            },
          ),
          TextButton(
            onPressed: _onSubmit,
            child: const Text('Edit This Profile'),
          )
        ],
      )
    );
  }

 

  Future<void> _onUpload(String imageUrl) async {
    try {
      await Supabase.instance.client.from('pengguna').upsert({
        'id': _avatarUrl,
        'foto': imageUrl,
      });
      if (mounted) {
        const SnackBar(
          content: Text('Updated your profile image!'),
        );
      }
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  void _getProfile(dynamic user){
    _userId = user['id'] as int;
    _usernameController.text = (user['username'] ?? '') as String;
    _namaController.text = (user['nama'] ?? '') as String;
    _passwordController.text = (user['password'] ?? '') as String;
    _roleController.text = (user['role']['nama'] ?? '') as String;
    _roleId = user['role']['id'] as int;
    _status = user['status'];
    _avatarUrl = user['foto'];
  }

  Future<void> _onSubmit() async {
    setState(() {
    });

    try {
      await userHandler.updateData(
        _userId, 
        _usernameController.text, 
        _namaController.text, 
        _passwordController.text, 
        _avatarUrl ?? '', 
        _roleId, 
        _status
      );
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
        });
      }

      SnackBar(
        content: Text('Successfully updated user profile!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  Future<void> _fetchRoles() async {
  final response = await Supabase.instance.client.from('role').select('*');
  if (response != null) {
    // If roles are fetched successfully, update the roles list
    setState(() {
      roles = (response as List).cast<Map<String, dynamic>>();
    });
  } else {
    // Handle error fetching roles
    print('Error fetching roles: $response');
  }
}


}
