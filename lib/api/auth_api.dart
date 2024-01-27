import 'dart:convert';

import 'package:permata_architect_mobile_apps/models/auth_model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://192.168.0.105:8000/api';

  Future<UserModel> register(
      {String? name, String? email, String? password}) async {
    Uri url = Uri.parse('$baseUrl/register');
    var body = jsonEncode({'name': name, 'email': email, 'password': password});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer ${data['access_token']}";
      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({String? email, String? password}) async {
    Uri url = Uri.parse('$baseUrl/login');
    var body = jsonEncode({'email': email, 'password': password});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer ${data['access_token']}";
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
