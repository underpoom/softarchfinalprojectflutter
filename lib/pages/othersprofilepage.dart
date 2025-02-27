import 'package:flutter/material.dart';
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
List posts = [
  {'postID': 0},
  {
    'postID': 1,
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
    'postID': 2,
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

class OthersProfilePage extends StatefulWidget {
  const OthersProfilePage(
      {Key? key, required this.userData, required this.profile_id})
      : super(key: key);
  final LoginResponseModel userData;
  final int profile_id;

  _OthersProfilePage createState() => _OthersProfilePage();
}

class _OthersProfilePage extends State<OthersProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool follow = false;
  List<PostInfoModel> posts = [];
  var owner;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    getUser(widget.profile_id).then((owner) => this.owner = owner);
    GetFollowingUsers(widget.userData.user.user_id).then((user_dat) {
      setState(() {
        if (user_dat.contains(this.owner.user_id))
          this.follow = true;
        else
          this.follow = false;
      });
    });
    GetAllPostbyUser(this.owner.user_id).then((posts) {
      setState(() {
        this.posts = posts;
      });
    });
    GetAllPostsSharedByUser(this.owner.user_id).then((post) {
      setState(() {
        this.posts = new List.from(this.posts)..addAll(post);
      });
    });
    setState(() {
      this.posts.sort((b, a) {
        return a.post_id.compareTo(b.post_id);
      });
    });
  }

  //bool follow = false;
  //String avatarURL =
  //    "https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80";
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
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: widget.userData.user.user_type == 1
          ? AdminNavigateDrawer(
              userData: widget.userData,
            )
          : NavigateDrawer(
              userData: widget.userData,
            ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBannerAd(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 105, 21),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'KMITL',
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
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
        ]),
        actions: <Widget>[
          /*CircleButton(
              icon: FaIcon(FontAwesomeIcons.bell),
              iconSize: 23.0,
              onPressed: showBanner),*/
          CircleButton(
            icon: FaIcon(FontAwesomeIcons.gripVertical),
            iconSize: 23.0,
            onPressed: _openEndDrawer,
          ),
        ],
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 56,
              backgroundImage:
                  NetworkImage(widget.userData.user.profile_pic_url),
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.userData.user.display_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (follow) {
                      print(await FollowUser(
                          widget.userData.user.user_id, this.owner.user_id));
                      setState(() => follow = false);
                    } else
                      setState(() => follow = true);
                    print("Follow");
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    height: 35,
                    width: 200,
                    decoration: BoxDecoration(
                        color: follow ? Colors.orange : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: follow
                                ? Colors.transparent
                                : Colors.grey.shade100)),
                    child: Center(
                      child: Text(
                        follow ? "Following" : "Follow",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: FaIcon(FontAwesomeIcons.flag),
                  iconSize: 20,
                  color: Colors.orange,
                  onPressed: () {
                    print("Report ur mom");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.orange,
                height: 18.0,
                thickness: 0.5,
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
                        type: widget.userData.user.user_type == 1
                            ? 'admin'
                            : 'user',
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
      ),
    );
  }
}
