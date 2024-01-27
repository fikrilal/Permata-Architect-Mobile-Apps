import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/api/auth_api.dart';
import 'package:permata_architect_mobile_apps/models/auth_model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> accountRegister(
      {String? name, String? email, String? password}) async {
    try {
      UserModel user = await AuthService()
          .register(name: name, email: email, password: password);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> accountLogin({String? email, String? password}) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
