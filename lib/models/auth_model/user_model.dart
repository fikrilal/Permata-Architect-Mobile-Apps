class UserModel {
  int? id;
  String? name;
  String? email;
  String? token;
  String? message;

  UserModel({this.id, this.email, this.name, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'message': message
    };
  }
}

class UserInfo {
  int? code;
  String? status;
  String? message;

  UserInfo({this.code, this.message, this.status});

  UserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'status': status, 'message': message};
  }
}
