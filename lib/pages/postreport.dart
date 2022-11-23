import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/widgets/circle_button.dart';
import 'package:softarchfinal/widgets/navigation_drawer.dart';
import 'package:softarchfinal/widgets/post_container.dart';

//text url tag userid
/*var now = DateTime.now();
List posts = [
  {'postID': 0},
  {
    'postID': 1,
    'user_pic':
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    'username': 'Username',
    'postText':
        'F*ck youaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    'attachedImageUrl': 'https://dc.lnwfile.com/_/dc/_raw/u8/0p/0u.jpg',
    'tags': ['ไอควาย', 'ปัญญาอ่อน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.',
    'report_count': 6,
  },
  {
    'postID': 2,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.',
    'report_count': 2,
  },
  {
    'postID': 3,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': '윤보미 Chaipanna',
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.',
    'report_count': 99,
  },
];*/

class AdminPostReportScreen extends StatefulWidget {
  const AdminPostReportScreen({Key? key, required this.userData})
      : super(key: key);
  final LoginResponseModel userData;

  @override
  State<AdminPostReportScreen> createState() => _AdminPostReportScreenState();
}

class _AdminPostReportScreenState extends State<AdminPostReportScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PostInfoModel> posts = [];

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    GetAllReportedPosts(widget.userData.user.user_id).then((posts) {
      setState(() {
        this.posts = posts;
      });
    });
    setState(() {
      this.posts.sort((b, a) {
        return a.report_count.compareTo(b.report_count);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*posts.insert(
        0,
        PostInfoModel(
            post_id: -1,
            post_date: DateTime.now(),
            post_text: '',
            attached_image_url: '',
            verified: true,
            report_count: 0));*/
    //print(posts.length);
    //bool isAdmin = true;
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
              'Admin - Post Report Review',
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
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return PostContainer(
                    userData: widget.userData,
                    post: post,
                    type: 'report',
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
    );
  }
}
