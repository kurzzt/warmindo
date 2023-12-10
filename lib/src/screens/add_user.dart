import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warung_sample/src/data/roleHandler.dart';
import 'package:warung_sample/src/data/userHandler.dart';
import 'package:warung_sample/src/widgets/avatar.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    super.key,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _usernameController = TextEditingController();
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _status = true;

  UserHandler userHandler = UserHandler();
  RoleHandler roleHandler = RoleHandler();
  
  var items = [     
    'Item 1', 
    'Item 2', 
    'Item 3', 
    'Item 4', 
    'Item 5', 
  ]; 
  
  String? _avatarUrl;
  String dropdownvalue = 'Item 1';

  Future<void> _onUpload(String imageUrl) async {
    try {
      await Supabase.instance.client.from('pengguna').upsert({
        'id': 1,
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

  _onSubmit(
    String username,
    String nama,
    String pass,
    String foto, 
    bool status,
    int idrole
  ) {
    try {
      userHandler.addData(username, nama, pass, foto, status, idrole);
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
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New User')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Avatar(
              imageUrl: _avatarUrl,
              onUpload: _onUpload,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child : 
                FutureBuilder(
                  future: roleHandler.readData(), 
                  builder: ((context, snapshot) {
                    if(snapshot.hasData){
                      return DropdownButtonFormField(
                        value: dropdownvalue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((items) { 
                            return DropdownMenuItem( 
                              value: items, 
                              child: Text(items), 
                            ); 
                          }).toList(),   
                        onChanged: (String? newValue) {  
                          setState(() { 
                            dropdownvalue = newValue!; 
                          }); 
                        }, 
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
                )
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
                      print(_status);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                )
              ]
            ),
            TextButton(
              onPressed: _onSubmit(
                _usernameController.text,
                _namaController.text,
                _passwordController.text,
                _avatarUrl ?? '',
                _status,
                1
              ),
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
