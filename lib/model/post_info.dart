import 'dart:convert';

PostInfoModel userInfoModelJson(String str) =>
    PostInfoModel.fromJson(json.decode(str));

class PostInfoModel {
  PostInfoModel({
    required this.post_id,
    required this.post_date,
    required this.post_text,
    required this.attached_image_url,
    required this.verified,
    required this.report_count,
  });
  late final int post_id;
  late final DateTime post_date;
  late final String post_text;
  late final String attached_image_url;
  late final bool verified;
  late final int report_count;

  PostInfoModel.fromJson(Map<String, dynamic> json) {
    post_id = json['post_id'];
    post_date = DateTime.parse(json['post_date']);
    post_text = json['post_text'];
    attached_image_url = json['attached_image_url'];
    verified = json['verified'];
    report_count = json['report_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['post_id'] = post_id;
    _data['post_date'] = post_date;
    _data['post_text'] = post_text;
    _data['attached_image_url'] = attached_image_url;
    _data['verified'] = verified;
    _data['report_count'] = report_count;

    return _data;
  }
}
