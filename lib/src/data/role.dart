// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Role {
  final int id;
  final String name;
  final bool status;

  Role(this.id, this.name, this.status);

  // void addRole({
  //   required nama,
  //   required status
  // }) {
  //   var role = allRoles
  // }

  // Role getRole(String id){
  //   return allRoles[int.parse(id)];
  // }
}

class RoleHandler {
  // final client = SupabaseClient(dotenv.get('DB_URL'), dotenv.get('DB_KEY'));

  addData(String namaValue, bool statusValue) async {
    var response = await Supabase.instance.client
        .from('role')
        .insert({ 'nama': namaValue, 'status': statusValue });

    print(response);
    // return response;
  }

  readData() async {
    var response = await Supabase.instance.client
        .from('role')
        .select('*');
    print('sss');
    print(response);
    final dataList = response as List;
    print(dataList);
    return dataList;
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