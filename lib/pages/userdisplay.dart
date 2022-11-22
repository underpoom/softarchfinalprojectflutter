import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/widgets/bottom_banner_ad.dart';
import 'package:softarchfinal/widgets/circle_button.dart';
import 'package:softarchfinal/widgets/create_post_contrainer.dart';
import 'package:softarchfinal/widgets/navigation_drawer.dart';
import 'package:softarchfinal/widgets/post_container.dart';
import 'package:softarchfinal/model/user_info.dart';

/*var now = DateTime.now();
bool isAdmin = false;

String user_pic =
    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";

List posts = [
  {'postID': 0},
  {
    'postID': 1,
    'user_verify': false,
    'user_pic':
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'username': 'Username',
    'postText':
        'F*ck youaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    'attachedImageUrl': 'https://dc.lnwfile.com/_/dc/_raw/u8/0p/0u.jpg',
    'tags': ['ไอควาย', 'ปัญญาอ่อน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 2,
    'user_verify': true,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 3,
    'user_verify': false,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
];*/

class userdisplay extends StatefulWidget {
  const userdisplay({Key? key, required this.userData, required this.userModel})
      : super(key: key);
  final LoginResponseModel userData;
  final UserInfoModel userModel;

  @override
  State<userdisplay> createState() => _userdisplayState();
}

class _userdisplayState extends State<userdisplay> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        endDrawer: widget.userData.user_role == 1
            ? AdminNavigateDrawer(
                userData: widget.userData,
                userModel: widget.userModel,
              )
            : NavigateDrawer(
                userData: widget.userData,
                userModel: widget.userModel,
              ),
        bottomNavigationBar: BottomBannerAd(),
        appBar: AppBar(
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
        body: Column(
          children: [
            Container(
              child: CreatePostContrainer(
                userData: widget.userData,
                userModel: widget.userModel,
                image: NetworkImage(widget.userModel.profile_pic_url),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: ListView.separated(
                  itemCount: widget.userData.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = widget.userData.posts[index];
                    if (index == 0) return Container();
                    return PostContainer(
                      userData: widget.userData,
                      userModel: widget.userModel,
                      post: post,
                      type: widget.userData.user_role == 1 ? 'admin' : 'user',
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
