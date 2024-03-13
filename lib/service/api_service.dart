import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:preprations/model/user.dart';

 

class ApiService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      List<dynamic> usersJson = parsed['data'];
      List<User> users = usersJson.map((json) => User(id: json['id'], name: json['first_name'])).toList();
      return users;
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
