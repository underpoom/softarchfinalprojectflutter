import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/user_info.dart';

class ProfileContainer extends StatefulWidget {
  // type = verify , report
  final String type;
  final LoginResponseModel userData;
  final UserInfoModel profile;
  const ProfileContainer(
      {Key? key,
      required this.type,
      required this.profile,
      required this.userData})
      : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 44;
    var now = DateTime.now();
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          elevation: 0,
          color: Color.fromRGBO(217, 217, 217, 1),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  //**************************avatar******************************
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: avatarDiameter,
                      height: avatarDiameter,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(avatarDiameter / 2),
                        //ใส่รูป
                        child: Image(
                          image: NetworkImage(widget.profile.profile_pic_url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //***************************************************************
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //ใส่ชื่อแต่ละคนโพสต์
                          widget.profile.display_name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.type == 'report')
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.xmark),
                        iconSize: 23.0,
                        onPressed: () async {
                          print(await userResetReportCount(
                              widget.profile.user_id));
                        }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile.first_name + ' '+  widget.profile.last_name,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.profile.email,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.profile.mobile_no,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.type == 'report')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Report count : ' +
                          widget.profile.report_count.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.trashCan),
                        iconSize: 23.0,
                        onPressed: () async {
                          print(await RemoveUser(widget.profile.user_id,
                              widget.userData.user.user_id));
                        }),
                  ],
                ),
              if (widget.type == 'verify')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: IconButton(
                                  color: Colors.white,
                                  icon: FaIcon(FontAwesomeIcons.check),
                                  iconSize: 23.0,
                                  onPressed: () async {
                                    print(await SetUserVerification(
                                        widget.profile.user_id,
                                        widget.userData.user.user_id,
                                        2));
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 12, 10),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: IconButton(
                                  color: Colors.white,
                                  icon: FaIcon(FontAwesomeIcons.xmark),
                                  iconSize: 23.0,
                                  onPressed: () async {
                                    print(await SetUserVerification(
                                        widget.profile.user_id,
                                        widget.userData.user.user_id,
                                        0));
                                  }),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
