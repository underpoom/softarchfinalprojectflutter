import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/widgets/bottom_banner_ad.dart';
import 'package:softarchfinal/widgets/circle_button.dart';
import 'package:softarchfinal/widgets/navigation_drawer.dart';
import 'package:softarchfinal/widgets/post_container.dart';

/*var now = DateTime.now();
bool isAdmin = false;
List taglist = ['รักภูมิ', 'ไอควาย'];
List posts = [
  {'postID': 0},
  {
    'postID': 1,
    'user_pic':
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF',
    'username': 'Username',
    'user_verify': false,
    'postText':
        'F*ck youaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    'attachedImageUrl': 'https://dc.lnwfile.com/_/dc/_raw/u8/0p/0u.jpg',
    'tags': ['อยากซัดหน้าปัน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 2,
    'user_pic':
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF',
    'username': '윤보미 Chaipanna',
    'user_verify': true,
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 3,
    'user_pic':
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF',
    'username': '윤보미 Chaipanna',
    'user_verify': false,
    'postText':
        'ทำไมเด๋วนี้พี่คิงไม่ยอมให้หนูเล่นเกมด้วยเลยสนใจแต่อะไรก็ไม่รู้ รู้มั้ยว่าหนูคิดถึงพี่คิงขนาดไหน แล้วนี้เมื่อไหร่จะขอหนูเป็นแฟนหนูรอพี่คิงมาขอนานแล้วนะ งื้อๆ',
    'attachedImageUrl': '',
    'tags': ['สีชมพู', 'รักภูมิ', 'เด็กคิง'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
];*/

class FollowingTagScreen extends StatefulWidget {
  const FollowingTagScreen({Key? key, required this.userData})
      : super(key: key);
  final LoginResponseModel userData;

  @override
  State<FollowingTagScreen> createState() => _FollowingTagScreen();
}

class _FollowingTagScreen extends State<FollowingTagScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List tags = [];
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
    GetFollowingTags(widget.userData.user.user_id).then((tags) {
      setState(() {
        this.tags = tags;
      });
    });
    tags.forEach((tag) {
      GetAllPostByTags(tag).then((postList) {
        setState(() {
          postList.forEach((item) {
            bool check = true;
            posts.forEach((e) {
              if (e.post_id == item.post_id) check = false;
            });
            if (check) posts.add(item);
          });
        });
      });
    });
    setState(() {
      this.posts.sort((b, a) {
        return a.post_id.compareTo(b.post_id);
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
    bool isAdmin = true;
    const double avatarDiameter = 70;
    return Scaffold(
      bottomNavigationBar: BottomBannerAd(),
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
      endDrawer: isAdmin
          ? AdminNavigateDrawer(
              userData: widget.userData,
            )
          : NavigateDrawer(
              userData: widget.userData,
            ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
            height: 24,
            child: Text(
              'Your Following Tags',
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
                  if (post.verified)
                    return PostContainer(
                      userData: widget.userData,
                      post: post,
                      type: isAdmin ? 'admin' : 'user',
                    );
                  return Container();
                },
                separatorBuilder: (context, index) =>
                    widget.userData.posts[index].verified
                        ? SizedBox(height: 10)
                        : SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
