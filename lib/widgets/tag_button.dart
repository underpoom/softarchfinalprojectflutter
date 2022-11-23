import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/pages/tagdisplay.dart';

class TagButton extends StatefulWidget {
  final String tags;
  final LoginResponseModel userData;

  const TagButton({
    super.key,
    required this.tags,
    required this.userData,
  });

  @override
  State<TagButton> createState() => _TagButton();
}

class _TagButton extends State<TagButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TagDisplayScreen(
              tagtopic: widget.tags,
              userData: widget.userData,
            );
          }));
        },
        child: Text(
          widget.tags,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          elevation: 3,
          shape: StadiumBorder(),
        ),
      ),
    );
  }
}
