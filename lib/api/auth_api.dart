import 'dart:convert';

import 'package:permata_architect_mobile_apps/models/auth_model/user_model.dart';
import 'package:http/http.dart' as http;

import '../repository/api/api_config.dart';

class AuthService {
  Future<UserModel> register(
      {String? name, String? email, String? password}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/register');
    var body = jsonEncode({'name': name, 'email': email, 'password': password});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    var infoData = jsonDecode(response.body)['meta'];
    UserInfo message = UserInfo.fromJson(infoData);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer ${data['access_token']}";
      return user;
    } else {
      throw Exception(message.message);
    }
  }

  Future<UserModel> login({String? email, String? password}) async {
    Uri url = Uri.parse('${ApiConfig.baseUrl}/login');
    var body = jsonEncode({'email': email, 'password': password});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);

    var infoData = jsonDecode(response.body)['meta'];
    UserInfo message = UserInfo.fromJson(infoData);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer ${data['access_token']}";
      print('user token api = ${user.token}');
      return user;
    } else {
      throw Exception(message.message);
    }
  }
}
