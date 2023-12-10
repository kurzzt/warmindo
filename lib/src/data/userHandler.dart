import 'package:supabase_flutter/supabase_flutter.dart';

class User{
  final int id;
  final String username;
  final String nama;
  final String foto;
  final bool status;
  final int roleId;

  User(
    this.id,
    this.username,
    this.nama,
    this.foto,
    this.status,
    this.roleId,
  );
}

class UserHandler {
  addData(
    String usernameValue, 
    String namaValue, 
    String passValue, 
    String fotoValue, 
    bool statusValue,
    int roleidValue, 
  ) async {
    await Supabase.instance.client
        .from('pengguna')
        .insert({ 
          'username': usernameValue, 
          'nama': namaValue,
          'password': passValue,
          'foto': fotoValue,
          'status': statusValue,
          'id_role': roleidValue
        });
  }

  readData() async {
    List response = await Supabase.instance.client
        .from('pengguna')
        .select('*, role (id, nama)')
        .order('id', ascending: true);
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
    await Supabase.instance.client
        .from('pengguna')
        .update({ 
          'username': usernameValue, 
          'nama': namaValue,
          'password': passValue,
          'foto': fotoValue,
          'status': statusValue 
        })
        .eq('id', id);
  }

  deleteData(int id) async {
    await Supabase.instance.client
        .from('pengguna')
        .delete()
        .eq('id', id);
  }
}