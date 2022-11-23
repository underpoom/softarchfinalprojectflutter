import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/post_info.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/pages/othersprofilepage.dart';
import 'package:softarchfinal/widgets/tag_button.dart';

class PostContainer extends StatefulWidget {
  //type = approve report admin user owner
  final LoginResponseModel userData;
  final String type;
  final PostInfoModel post;
  const PostContainer({
    Key? key,
    required this.post,
    required this.type,
    required this.userData,
  }) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainer();
}

class _PostContainer extends State<PostContainer> {
  UserInfoModel? owner;
  List tags = [];
  int owner_id = 0;
  @override
  void initState() {
    super.initState();
    GetPostOwner(widget.post.post_id).then((user_id) {
      setState(() {
        getUser(user_id).then((value) {
          setState(() {
            this.owner = value;
          });
        });
      });
    });
    /*findOwner(widget.post.post_id).then((owners) {
      setState(() {
        this.owner = owners;
      });
    });*/
    GetPostTags(widget.post.post_id).then((tags) {
      setState(() {
        this.tags = tags;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 44;
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
                          image: NetworkImage(owner!.profile_pic_url),
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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                /*Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OthersProfilePage(
                                    userData: widget.userData,
                                    profile_id: owner!.user_id,
                                  );
                                }));*/
                              },
                              child: Text(
                                //ใส่ชื่อแต่ละคนโพสต์
                                owner!.display_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            if (owner!.verified == 2)
                              FaIcon(
                                FontAwesomeIcons.userCheck,
                                size: 15,
                                color: Colors.green,
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              //decoration: BoxDecoration(color: Colors.red),
                              alignment: Alignment.centerLeft,
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListView.builder(
                                itemCount: tags.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return TagButton(
                                    userData: widget.userData,
                                    tags: tags[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.type == 'user')
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.flag),
                        iconSize: 23.0,
                        onPressed: () async {
                          print(await AddReportCount(widget.post.post_id));
                        }),
                  if (widget.type == 'admin' || widget.type == 'owner')
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.trashCan),
                        iconSize: 23.0,
                        onPressed: () async {
                          print(await RemovePost(widget.post.post_id,
                              widget.userData.user.user_id));
                        }),
                  if (widget.type == 'report')
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.xmark),
                        iconSize: 23.0,
                        onPressed: () async {
                          print(await ResetReportCount(widget.post.post_id));
                        }),
                ],
              ),
              _postCaption(context, widget.post.post_text),
              if (widget.post.attached_image_url != '')
                _postImage(context, widget.post.attached_image_url),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            '${widget.post.post_date.day}/${widget.post.post_date.month}/${widget.post.post_date.year}   ${widget.post.post_date.hour.toString().padLeft(2, '0')}.${widget.post.post_date.minute.toString().padLeft(2, '0')} น.',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.type == 'admin' || widget.type == 'user')
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.share),
                        iconSize: 23.0,
                        onPressed: () async {
                          await CreateShare(widget.userData.user.user_id,
                              widget.post.post_id);
                        }),
                  if (widget.type == 'report')
                    Row(
                      children: [
                        Text(
                          'Report count : ' +
                              widget.post.report_count.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            icon: FaIcon(FontAwesomeIcons.trashCan),
                            iconSize: 23.0,
                            onPressed: () async {
                              print(await RemovePost(widget.post.post_id,
                                  widget.userData.user.user_id));
                            }),
                      ],
                    ),
                  if (widget.type == 'approve')
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
                                    print(await SetPostVerification(
                                        widget.post.post_id,
                                        widget.userData.user.user_id,
                                        true));
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
                                    print(await RemovePost(widget.post.post_id,
                                        widget.userData.user.user_id));
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

  Future<UserInfoModel> findOwner(int post_id) async {
    var postowner = await GetPostOwner(post_id);
    UserInfoModel owner = await getUser(postowner);
    return owner;
  }
}

Widget _postImage(BuildContext context, String image) {
  return Container(
    margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
    child: Image(
      image: NetworkImage(image),
      fit: BoxFit.cover,
    ),
  );
}

Widget _postCaption(BuildContext context, String text_post) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 4,
    ),
    child: Text(
      text_post,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
