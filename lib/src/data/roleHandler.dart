import 'package:supabase_flutter/supabase_flutter.dart';

class Role {
  final int id;
  final String nama;

  Role(
    this.id,
    this.nama
  );
}

class RoleHandler {
  Future<void> addData(
    String namaValue, 
    bool statusValue
  ) async {
    await Supabase.instance.client
        .from('role')
        .insert({ 'nama': namaValue, 'status': statusValue });
  }

  readData() async {
    var response = await Supabase.instance.client
        .from('role')
        .select('*')
        .order('id', ascending: true);
    
    return response;
  }

  Future<void> updateData(
    int id, 
    bool statusValue
  ) async {
    await Supabase.instance.client
        .from('role')
        .update({ 'status': statusValue })
        .eq('id', id);
  }

  Future<void> deleteData(int id) async {
    await Supabase.instance.client
        .from('role')
        .delete()
        .eq('id', id);
  }
}