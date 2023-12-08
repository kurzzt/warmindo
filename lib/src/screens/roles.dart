import 'package:flutter/material.dart';
import 'package:warung_sample/src/data.dart';

class RolesScreen extends StatefulWidget {
  final String title;

  const RolesScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  List<dynamic> _data = [];
  // final _namaController = TextEditingController();
  RoleHandler roleHandler = RoleHandler();

  @override
  void initState() {
    super.initState();
    fetchRolesData();
  }

  void fetchRolesData() {
    // final _statusController = TextEditingController();
    
    // RoleHandler roleHandler = RoleHandler();

    roleHandler.readData().then((data) {
      setState(() {
        _data = data;
      });
    }).catchError((error) {
      // Handle error if data fetching fails
      print('Error fetching data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    String namaValue = '';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index]['nama']),
                  subtitle: Text(
                    (_data[index]['status']) ? 'Status Aktif' : 'Status Nonaktif'
                  ),
                  // trailing: Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         roleHandler.deleteData(_data[index]['id']);
                  //         setState((){});
                  //       }, 
                  //       icon: Icon(Icons.delete)
                  //     )
                  //   ],
                  // ),
                  // onTap: onTap != null ? () => onTap!(),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: ((context) {
              return SimpleDialog(
                title: const Text('Add new Role'),
                contentPadding: 
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nama Role'),
                    onChanged: (value) => namaValue = value,
                  ),
                  ElevatedButton(
                    onPressed: () => roleHandler.addData(namaValue, true),
                    child: const Text('Submit'),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: 
                  // ),
                ],
              );
            }));
        },
        child: const Icon(Icons.add) 
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => null,
      // )
    );
  }
}
