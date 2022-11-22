import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.user_id,
    required this.email,
    required this.posts,
    required this.user_verified,
    required this.user_role,
  });
  late final int user_id;
  late final String email;
  late final List posts;
  late final int user_verified;
  late final int user_role;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    email = json['email'];
    posts = json['posts'];
    user_verified = json['user_verified'];
    user_role = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = user_id;
    _data['email'] = email;
    _data['posts'] = posts;
    _data['user_verified'] = user_verified;
    _data['user_role'] = user_role;
    return _data;
  }
}
