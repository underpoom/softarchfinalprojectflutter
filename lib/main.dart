import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/pages/home.dart';
import 'package:softarchfinal/pages/userdisplay.dart';
import 'package:flutter/material.dart';
import 'package:softarchfinal/model/user_info.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
