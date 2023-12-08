import 'package:flutter/material.dart';
import 'package:warung_sample/src/data.dart';

class RolesScreen extends StatefulWidget {
  final String title;
  // RoleHandler roleHandler = RoleHandler();

  const RolesScreen({
    // required this.onTap,
    required this.title,
    super.key
  });

  @override
  State<RolesScreen> createState() => _RolesScreen();
}

class _RolesScreen extends State<RolesScreen> {
  @override
  Widget build(BuildContext context) {
    RoleHandler roleHandler = RoleHandler();
    String namaValue;
    String statusValue;

    return Scaffold(
      appBar: AppBar(
        title: Text('Roles'),
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          // if(snapshot.hasData == null &&
          //    snapshot.connectionState == ConnectionState.none) {}
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                  height: 250,
                  color: snapshot.data![index]['status']
                      ? Colors.black
                      : Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Text(snapshot.data![index]['nama']),
                      ),
                    ],
                  ));
            }
          );
        },
        future: roleHandler.readData(),
      ),
    );
  }
}
