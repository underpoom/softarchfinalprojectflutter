import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/model/user_info.dart';

final String baseUrl = "http://10.0.2.2:55742";

// Admin

Future<List<PostInfoModel>> GetAllUnverifiedPosts(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllUnverifiedPosts?RequesterUserID=$id");
  var response = await http.get(url);
  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

Future<List<PostInfoModel>> GetAllReportedPosts(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllReportedPosts?RequesterUserID=$id");
  var response = await http.get(url);
  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

Future<List<UserInfoModel>> GetAllReportedUsers(int id) async {
  final url =
      Uri.parse("$baseUrl/api/Admin/GetAllReportedUsers?RequesterUserID=$id");
  var response = await http.get(url);
  List<UserInfoModel> userList = List<UserInfoModel>.from(
      jsonDecode(response.body).map((model) => UserInfoModel.fromJson(model)));

  return userList;
}

Future<List<UserInfoModel>> GetVerificationPendingUsers(int id) async {
  final url = Uri.parse(
      "$baseUrl/api/Admin/GetVerificationPendingUsers?RequesterUserID=$id");
  var response = await http.get(url);

  List<UserInfoModel> userList = List<UserInfoModel>.from(
      jsonDecode(response.body).map((model) => UserInfoModel.fromJson(model)));

  return userList;
}

Future<int> SetPostVerification(
    int postID, int requesterUserID, bool verification) async {
  var body = jsonEncode({
    "requesterUserID": requesterUserID,
    "postID": postID,
    "verification": verification
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

// Advertisers

Future<String> GetAllAdvertiser() async {
  final url = Uri.parse("$baseUrl/api/Advertisers/GetAllAdvertiserData");
  var response = await http.get(url);

  return response.body;
}

Future<String> GetAdvertiserById(int id) async {
  final url = Uri.parse("$baseUrl/api/Advertisers/GetAdvertiser/$id");
  var response = await http.get(url);

  return response.body;
}

Future<int> RegisterAdvertiser(
    String advertiser_name, String ad_image_url) async {
  var body = jsonEncode({
    "advertiser_name": "string",
  });
  var response = await http.post(
      Uri.parse("$baseUrl/api/Advertisers/RegisterAdvertiser"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
  return response.statusCode;
}

// Post

Future<List<PostInfoModel>> getAllPost() async {
  final url = Uri.parse("$baseUrl/api/Post");
  var response = await http.get(url);

  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

Future<String> GetPost(int postID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetPost/$postID");
  var response = await http.get(url);

  return response.body;
}

Future<int> GetPostOwner(int postID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetPostOwner/$postID");
  var response = await http.get(url);
  int user_id = int.parse(response.body);

  return user_id;
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
  return response.statusCode;
}

void AddTagsToPost(int postID, List tags) async {
  var body = jsonEncode({"tags": tags});

  final url = Uri.parse("$baseUrl/api/Post/AddTagsToPost/$postID");

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
}

void UpdatePost(
    int userID, int postID, String postText, String attachedImageUrl) async {
  var body = jsonEncode({
    "postID": postID,
    "postText": postText,
    "attachedImageUrl": attachedImageUrl
  });

  final url = Uri.parse("$baseUrl/api/Post/AddTagsToPost/$userID");

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
}

Future<int> ResetReportCount(int postID) async {
  final url = Uri.parse("$baseUrl/api/Post/ResetReportCount/$postID");
  var response = await http.put(url);

  return response.statusCode;
}

Future<int> AddReportCount(int id) async {
  final url = Uri.parse("$baseUrl/api/Post/AddReportCount/$id");
  var response = await http.put(url);

  return response.statusCode;
}


Future<String> getAllTags() async {
  final url = Uri.parse("$baseUrl/api/Post/GetAllTags");
  var response = await http.get(url);

  return response.body;
}

Future<List> GetAllPostByTags(String tag) async {
  final url = Uri.parse("$baseUrl/api/Post/GetFollowersByUser/$tag");
  var response = await http.get(url);
  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

Future<String> GetPostDataFromPostID(int postID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetPost/$postID");
  var response = await http.get(url);

  return response.body;
}

Future<List> GetPostTags(int postID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetPostTags/$postID");
  var response = await http.get(url);
  List tags = json.decode(response.body) as List;
  return tags;
}

Future<List<PostInfoModel>> GetAllPostbyUser(int userID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetAllPostbyUser//$userID");
  var response = await http.get(url);
  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

Future<void> CreateShare(int userID, int postID) async {
  var body = jsonEncode({"postID": postID});

  final url = Uri.parse("$baseUrl/api/Post/CreateShare/$userID");

  var response = await http.put((url), body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
}

Future<List<PostInfoModel>> GetAllPostsSharedByUser(int userID) async {
  final url = Uri.parse("$baseUrl/api/Post/GetAllPostsSharedByUser/$userID");
  var response = await http.get(url);

  List<PostInfoModel> postList = List<PostInfoModel>.from(
      jsonDecode(response.body).map((model) => PostInfoModel.fromJson(model)));

  return postList;
}

// User

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
    tester.forEach();*/

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
  return response;
}

Future<void> userEdit(
    int id, String profile_pic_url, String display_name) async {
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

Future<String> userResetReportCount(int userID) async {
  final url = Uri.parse("$baseUrl/api/User/ResetReportCount/$userID");
  final response = await http.put(url);
  return response.body;
}

Future<int> FollowUser(int id, int to_follow) async {
  var body = jsonEncode({
    "userToFollow": to_follow,
  });

  var response = await http.post(Uri.parse("$baseUrl/api/User/FollowUser/$id"),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  return response.statusCode;
}

Future<String> GetFollowersByUser(int id) async {
  final url = Uri.parse("$baseUrl/api/User/GetFollowersByUser/$id");
  var response = await http.get(url);

  return response.body;
}

Future<List> GetFollowingUsers(int userID) async {
  final url = Uri.parse("$baseUrl/api/User/GetFollowingUsers/$userID");

  final response = await http.get(url);

  List users = json.decode(response.body) as List;
  return users;
}

Future<List> GetFollowingTags(int userID) async {
  final url = Uri.parse("$baseUrl/api/User/GetFollowingTags/$userID");

  final response = await http.get(url);
  List tags = json.decode(response.body) as List;

  return tags;
}

Future<LoginResponseModel> update(LoginResponseModel userData) async {
  userData.posts = await getAllPost();
  userData.user = await getUser(userData.user.user_id);
  return userData;
}
