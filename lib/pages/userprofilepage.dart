import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/pages/editprofilepage.dart';
import 'package:softarchfinal/widgets/bottom_banner_ad.dart';
import 'package:softarchfinal/widgets/navigation_drawer.dart';
import 'package:softarchfinal/widgets/post_container.dart';
import 'package:softarchfinal/widgets/widgets.dart';

/*var now = DateTime.now();
List posts = [
  {'postID': 0},
  {
    'postID': 1,
    'user_pic':
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF',
    'username': 'Thanapum Chaipanna',
    'postText': 'ไอปัน มึงเจอกู๊ว!!!!!!!!!',
    'attachedImageUrl': '',
    'tags': ['อยากซัดหน้าปัน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 2,
    'user_pic':
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF',
    'username': 'Thanapum Chaipanna',
    'postText': 'ไอปัน มึงเจอกู๊ว!!!!!!!!!',
    'attachedImageUrl': '',
    'tags': ['อยากซัดหน้าปัน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
  {
    'postID': 3,
    'user_pic':
        'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80',
    'username': 'Thanapum Chaipanna',
    'postText': 'ไอปัน มึงเจอกู๊ว!!!!!!!!!',
    'attachedImageUrl': '',
    'tags': ['อยากซัดหน้าปัน'],
    'post_date':
        '${now.day}/${now.month}/${now.year}   ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')} น.'
  },
];*/

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.userData}) : super(key: key);
  final LoginResponseModel userData;
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
    GetAllPostbyUser(widget.userData.user.user_id).then((posts) {
      setState(() {
        this.posts = posts;
      });
    });
    GetAllPostsSharedByUser(widget.userData.user.user_id).then((post) {
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

  //String avatarURL1 =
  //    "https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80";
  Widget build(BuildContext context) {
    posts.insert(
        0,
        PostInfoModel(
            post_id: -1,
            post_date: DateTime.now(),
            post_text: '',
            attached_image_url: '',
            verified: true,
            report_count: 0));
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: widget.userData.user.user_type == 1
          ? AdminNavigateDrawer(userData: widget.userData)
          : NavigateDrawer(
              userData: widget.userData,
            ),
      bottomNavigationBar: BottomBannerAd(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 222, 105, 21),
        elevation: 0.0,
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
              onPressed: () => print('bell')),*/
          CircleButton(
            icon: FaIcon(FontAwesomeIcons.gripVertical),
            iconSize: 23.0,
            onPressed: _openEndDrawer,
          ),
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          CircleAvatar(
            radius: 56,
            backgroundImage: NetworkImage(widget.userData.user.profile_pic_url),
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
              ),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.pen),
                  iconSize: 20,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditProfilepage(
                        userData: widget.userData,
                      );
                    }));
                  }),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.red,
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
                  if (index == 0) return Container();
                  return PostContainer(
                    userData: widget.userData,
                    post: post,
                    type: 'owner',
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
