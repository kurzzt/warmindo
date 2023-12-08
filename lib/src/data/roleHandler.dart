import 'package:supabase_flutter/supabase_flutter.dart';

class RoleHandler {
  addData(String namaValue, bool statusValue) async {
    var response = await Supabase.instance.client
        .from('role')
        .insert({ 'nama': namaValue, 'status': statusValue });

    print(response);
    // return response;
  }

  readData() async {
    List response= await Supabase.instance.client
        .from('role')
        .select('*')
        .order('id', ascending: true);
    
    print(response);
    return response;
  }

  updateData(int id, bool statusValue) async {
    var response = await Supabase.instance.client
        .from('role')
        .update({ 'status': statusValue })
        .eq('id', id);
    print(response);
  }

  deleteData(int id) async {
    var response = await Supabase.instance.client
        .from('role')
        .delete()
        .eq('id', id);
    print(response);
  }
}