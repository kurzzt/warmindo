import 'package:supabase_flutter/supabase_flutter.dart';
class User{
  final int id;
  final String username;
  final String nama;
  final String foto;
  final bool status;
  // ignore: non_constant_identifier_names
  final int id_role;

  User(
    this.id,
    this.username,
    this.nama,
    this.foto,
    this.status,
    this.id_role,
  );

  // User.fromMap(Map<String, dynamic> map)
  //   : id = map['id'],
  //     username = map['username'],
  //     nama = map['nama'],
  //     foto = map['foto'],
  //     status = map['status'],
  //     id_role = map['is_role'];

  // factory User.fromJson(Map<String, dynamic> json) {
  // return User(
  //   json['id'],
  //   json['username'],
  //   json['nama'],
  //   json['foto'],
  //   json['status'],
  //   json['id_role'],
  // );
// }

}

class UserHandler {
  addData(
    String usernameValue, 
    String namaValue, 
    String passValue, 
    String fotoValue, 
    int roleidValue, 
    bool statusValue
  ) async {
    var response = await Supabase.instance.client
        .from('pengguna')
        .insert({ 
          'username': usernameValue, 
          'nama': namaValue,
          'password': passValue,
          'foto': fotoValue,
          'status': statusValue 
        });

    print(response);
    // return response;
  }

  readData() async {
    List response = await Supabase.instance.client
        .from('pengguna')
        .select('*')
        .order('id', ascending: true);
    
    print(response);
    return response;
  }

  readDataById(int id) async {
    var response = await Supabase.instance.client
        .from('pengguna')
        .select('*, role (id, nama)')
        .eq('id', id);
    return response;
  }

  updateData(
    int id,
    String usernameValue, 
    String namaValue, 
    String passValue, 
    String fotoValue, 
    int roleidValue, 
    bool statusValue
  ) async {
    var response = await Supabase.instance.client
        .from('pengguna')
        .update({ 
          'username': usernameValue, 
          'nama': namaValue,
          'password': passValue,
          'foto': fotoValue,
          'status': statusValue 
        })
        .eq('id', id);
    print(response);
  }

  deleteData(int id) async {
    var response = await Supabase.instance.client
        .from('pengguna')
        .delete()
        .eq('id', id);
    print(response);
  }
}