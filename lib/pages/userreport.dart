import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/widgets/profile_container.dart';

import '../widgets/widgets.dart';

/*var now = DateTime.now();
List profiles = [
  {'profileID': 0},
  {
    'profileID': 1,
    'user_pic':
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'username': 'Username',
    'first_name': 'Prayat',
    'last_name': 'Junochut',
    'email': 'prayat69.j@kmitl.ac.th',
    'mobile_number': '099-456-7856',
    'report_count': 999,
  },
  {
    'profileID': 2,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'first_name': '윤보미',
    'last_name': 'Chaipanna',
    'email': 'KingRukDek99@kmitl.ac.th',
    'mobile_number': '082-368-6056',
    'report_count': 2,
  },
  {
    'profileID': 3,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'first_name': '윤보미',
    'last_name': 'Chaipanna',
    'email': 'KingRukDek99@kmitl.ac.th',
    'mobile_number': '082-368-6056',
    'report_count': 6,
  },
];*/

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({Key? key, required this.userData}) : super(key: key);
  final LoginResponseModel userData;

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<UserInfoModel> users = [];

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    GetAllReportedUsers(widget.userData.user.user_id).then((users) {
      setState(() {
        this.users = users;
      });
    });
    setState(() {
      this.users.sort((b, a) {
        return a.report_count.compareTo(b.report_count);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*users.insert(
        0,
        UserInfoModel(
            user_id: -1,
            email: '',
            pass_hash: '',
            pass_salt: '',
            mobile_no: '',
            first_name: '',
            verificationToken: '',
            profile_pic_url: '',
            display_name: '',
            user_type: -1,
            verified: 2,
            report_count: 0,
            last_name: ''));*/
    const double avatarDiameter = 70;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 222, 105, 21),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'KMITL',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Text(
                  'NEWS',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          CircleButton(
            icon: FaIcon(FontAwesomeIcons.gripVertical),
            iconSize: 23.0,
            onPressed: _openEndDrawer,
          ),
        ],
      ),
      key: _scaffoldKey,
      endDrawer: AdminNavigateDrawer(
        userData: widget.userData,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
            height: 24,
            child: Text(
              'Admin - Verify Review',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView.separated(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final profile = users[index];
                  return ProfileContainer(
                      profile: profile,
                      type: 'report',
                      userData: widget.userData);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
