import 'package:flutter/material.dart';
import 'package:warung_sample/src/data/roleHandler.dart';
import 'package:warung_sample/src/data/userHandler.dart';

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
  final _fotoController = TextEditingController();
  final _statusController = TextEditingController();
  final _roleController = TextEditingController();

  UserHandler userHandler = UserHandler();
  RoleHandler roleHandler = RoleHandler();
  // var x = roleHandler.readData();
  var items = [     
    'Item 1', 
    'Item 2', 
    'Item 3', 
    'Item 4', 
    'Item 5', 
  ]; 
  
  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        title: Text('Add New User'),
      ),
    body: Container(
      constraints: BoxConstraints.loose(const Size(600, 600)),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add New User',
              style: Theme.of(context).textTheme.headlineMedium),
          TextField(
            decoration: const InputDecoration(labelText: 'Username'),
            controller: _usernameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Nama'),
            controller: _namaController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            controller: _passwordController,
          ),
          DropdownButton(
            value: dropdownvalue,
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
            //FIXME: status
            //FIXME: foto
          )
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: TextButton(
          //     onPressed: () async {
          //       userHandler.addData(
          //       _usernameController.text, 
          //         _namaController.text, 
          //         _passwordController.text, 
          //         _fotoController.text, 
          //         int.parse(_roleController.text), 
          //         bool.parse(_statusController.text)
          //       ),
          //     child: const Text('Submit'),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
