import 'dart:convert';

UserInfoModel userInfoModelJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

class UserInfoModel {
  UserInfoModel({
    required this.user_id,
    required this.email,
    required this.pass_hash,
    required this.pass_salt,
    required this.mobile_no,
    required this.first_name,
    required this.verificationToken,
    required this.profile_pic_url,
    required this.display_name,
    required this.user_type,
    required this.verified,
    required this.report_count,
    required String last_name,
  });
  late final int user_id;
  late final String email;
  late final String pass_hash;
  late final String pass_salt;
  late final String mobile_no;
  late final String first_name;
  late final String last_name;
  late final String verificationToken;
  late final String profile_pic_url;
  late final String display_name;
  late final int user_type;
  late final int verified;
  late final int report_count;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    email = json['email'];
    pass_hash = json['pass_hash'];
    pass_salt = json['pass_salt'];
    mobile_no = json['mobile_no'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    verificationToken = json['verificationToken'];
    profile_pic_url = json['profile_pic_url'];
    display_name = json['display_name'];
    user_type = json['user_type'];
    verified = json['verified'];
    report_count = json['report_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = user_id;
    _data['email'] = email;
    _data['pass_hash'] = pass_hash;
    _data['pass_salt'] = pass_salt;
    _data['mobile_no'] = mobile_no;
    _data['first_name'] = first_name;
    _data['last_name'] = last_name;
    _data['verificationToken'] = verificationToken;
    _data['profile_pic_url'] = profile_pic_url;
    _data['display_name'] = display_name;
    _data['user_type'] = user_type;
    _data['verified'] = verified;
    _data['report_count'] = report_count;

    return _data;
  }
}
