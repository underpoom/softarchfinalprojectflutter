import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:softarchfinal/model/user_info.dart';

final String baseUrl = "http://10.0.2.2:55742";

void getAllPost() async {
  final url = Uri.parse("$baseUrl/api/Post");
  var response = await http.get(url);

  //Map<String, dynamic> userMap = jsonDecode(response.body);

  //print(userMap["name"]);

  //s=("New String: ${s.replaceAll('[','')}");
  //Map<String, String>.from(jsonDecode(response.body);
  print(response.statusCode);
  print(response.body);
}

Future<String> getAllUser() async {
  final url = Uri.parse("$baseUrl/api/User");
  var response = await http.get(url);

  //print(response.statusCode);
  //print(response.body);

  return response.body;
}

Future<UserInfoModel> getUser(int user_ids) async {
  var allUser = await getAllUser();
  List<UserInfoModel> userList = List<UserInfoModel>.from(
      jsonDecode(allUser).map((model) => UserInfoModel.fromJson(model)));
  UserInfoModel tester = userList[0];
  userList.forEach((item) {
    if (item.user_id == user_ids) tester = item;
  });
  /*List tester = List.from(json.decode(result));
    tester.forEach((item) {
      UserInfoModel userModel = UserInfoModel.fromJson(item);
      userList.add(userModel);
    });*/

  //print(userList.runtimeType);

  return tester;
}

void getUserEmail(int id) async {
  final url = Uri.parse("$baseUrl/api/User/$id");
  http.Response response = await http.get(url);
  print(response.statusCode);
  print(response.body);
}

Future<int> userRegister(
  String email,
  String password,
  String confirmPassword,
  String mobile_no,
  String first_name,
  String last_name,
) async {
  var body = jsonEncode({
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "mobile_no": mobile_no,
    "first_name": first_name,
    "last_name": last_name,
  });

  final url = Uri.parse("$baseUrl/api/User/register");

  var response = await http.post((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
  print(response.statusCode);
  print(response.body);

  return response.statusCode;
}

Future<http.Response> userLogin(
  String email,
  String password,
) async {
  var body = jsonEncode({
    "email": email,
    "password": password,
  });

  final url = Uri.parse("$baseUrl/api/User/Login");

  var response = await http.post((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
  print(response.statusCode);
  print(response.body);

  return response;
}

void userEdit(int id, String profile_pic_url, String display_name) async {
  var body = jsonEncode(
      {"profile_pic_url": profile_pic_url, "display_name": display_name});

  final url = Uri.parse("$baseUrl/api/User/Edit/$id");

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
  print(response.statusCode);
  print(response.body);
}

Future<String> userVerifyEmail(String email) async {
  final url = Uri.parse("$baseUrl/api/User/VerifyEmail/$email");

  final response = await http.get(url);

  //print(response.statusCode);

  return response.body;
}

void userResetPassword(String token, String password) async {
  final url = Uri.parse("$baseUrl/api/User/ResetPass/$token");

  var body = jsonEncode({"passwordd": password});

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  print(response.statusCode);
  print(response.body);
}

void userResetReportCount(String token, String password) async {
  final url = Uri.parse("$baseUrl/api/User/ResetPass/$token");

  var body = jsonEncode({"passwordd": password});

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  print(response.statusCode);
  print(response.body);
}

Future<int> CreatePost(
    int id, String postText, String attachedImgUrl, List tags) async {
  var body = jsonEncode(
      {"postText": postText, "attachedImgUrl": attachedImgUrl, "tags": tags});

  var response = await http.post(Uri.parse("$baseUrl/api/Post/CreatePost/$id"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  print(response.statusCode);
  print(response.body);

  return response.statusCode;
}

Future<String> getAllTags() async {
  final url = Uri.parse("$baseUrl/api/Post/GetAllTags");
  var response = await http.get(url);

  return response.body;
}

Future<int> FollowUser(int id, int to_follow) async {
  var body = jsonEncode({
    "userToFollow": to_follow,
  });

  var response = await http.post(Uri.parse("$baseUrl/api/Post/CreatePost/$id"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}

Future<String> GetFollowersByUser(int id) async {
  final url = Uri.parse("$baseUrl/api/Post/GetFollowersByUser/$id");
  var response = await http.get(url);

  return response.body;
}

Future<String> GetAllPostByTags(String tag) async {
  final url = Uri.parse("$baseUrl/api/Post/GetFollowersByUser/$tag");
  var response = await http.get(url);

  return response.body;
}

// on Admin ID can use ---

Future<String> GetAllUnverifiedPosts(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllUnverifiedPosts?RequesterUserID=$id");
  var response = await http.get(url);

  return response.body;
}

Future<String> GetAllReportedPosts(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllReportedPosts?RequesterUserID=$id");
  var response = await http.get(url);

  return response.body;
}

Future<String> GetAllReportedUsers(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllReportedUsers?RequesterUserID=$id");
  var response = await http.get(url);

  return response.body;
}

Future<String> GetVerificationPendingUsers(int id) async {
  final url = Uri.parse(
      "$baseUrl/api/Admin/GetVerificationPendingUsers?RequesterUserID=$id");
  var response = await http.get(url);

  return response.body;
}

Future<int> SetPostVerification(int postID, int requesterUserID) async {
  var body = jsonEncode({
    "requesterUserID": requesterUserID,
    "postID": postID,
    "verification": true
  });

  var response = await http.put(
      Uri.parse("$baseUrl/api/Admin/SetPostVerification/$postID"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}

Future<int> SetUserVerification(
    int userID, int requesterUserID, int verification) async {
  var body = jsonEncode({
    "requesterUserID": requesterUserID,
    "postID": userID,
    "verification": verification
  });

  var response = await http.put(
      Uri.parse("$baseUrl/api/Admin/SetUserVerification/$userID"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}

Future<int> RemovePost(int postID, int requesterUserID) async {
  var body = jsonEncode({
    "requesterUserID": requesterUserID,
  });

  var response = await http.post(
      Uri.parse("$baseUrl/api/Admin/RemovePost/$postID"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}

Future<int> RemoveUser(int userID, int requesterUserID) async {
  var body = jsonEncode({
    "requesterUserID": requesterUserID,
  });

  var response = await http.post(
      Uri.parse("$baseUrl/api/Admin/RemoveUser/$userID"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}
