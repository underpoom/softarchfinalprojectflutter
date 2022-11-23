import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/pages/post_page.dart';
import 'package:softarchfinal/pages/userprofilepage.dart';

class CreatePostContrainer extends StatelessWidget {
  //รับค่าจากรูปโปร user จาก backend
  final NetworkImage image;
  final LoginResponseModel userData;

  const CreatePostContrainer({
    super.key,
    required this.image,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      height: 100.0,
      color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProfilePage(
                        userData: userData,
                      );
                    }));
                  },
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color.fromARGB(255, 226, 141, 95),
                    backgroundImage: image,
                  )),
              const VerticalDivider(
                width: 8.0,
              ),
              /*const SizedBox(
                width: 3.0,
              ),*/
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return PostPage(
                      userData: userData,
                    );
                  })),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "อยากบอกอะไรให้ KMITL รู้?",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 118, 117, 117),
                    padding: EdgeInsets.all(4),
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
                child: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
