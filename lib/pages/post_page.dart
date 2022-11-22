import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/model/user_info.dart';
import 'package:softarchfinal/pages/userprofilepage.dart';
import 'package:softarchfinal/widgets/navigation_drawer.dart';
import 'package:softarchfinal/widgets/circle_button.dart';
import 'package:softarchfinal/widgets/widgets.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:softarchfinal/widgets/create_post_contrainer.dart';
import 'package:softarchfinal/widgets/icbutton.dart';
import 'package:softarchfinal/widgets/tag_button.dart';

import 'package:softarchfinal/callapi.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.userData, required this.userModel})
      : super(key: key);
  final LoginResponseModel userData;
  final UserInfoModel userModel;

  @override
  State<PostPage> createState() => _PostPageState();
}

String text = '';
String name = '';
List<String> _list = [];
List<String> _taglist = [];
List<String> _reallist = ['test1', 'test2'];
int UserID = 1;
String Username = 'สสส';
String Userpic =
    'https://cdn.discordapp.com/avatars/695875199291228181/ff8949df85c202c508357c7a0bb1acd6.webp?size=80';
String imageURL = '';
String postText = '';

void toStr(File im) {
  imageURL = im.toString();
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _Textcontroller = TextEditingController();
  static final GlobalKey<FormState> globalkeyy = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTamp = File(image.path);
      toStr(imageTamp);

      setState(() => this.image = imageTamp);
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e}');
    }
  }

  Future DeleteImage() async {
    try {
      setState(() {
        image = null;
        this.image = image;
      });
    } on PlatformException catch (e) {
      print('failed Cancel');
    }
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();

    myController = TextEditingController();
  }

  Future<List> fetchdata() async {
    _list = _reallist;
    return _list;
  }

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<String?> _showAddTag(BuildContext context) {
    TextEditingController myController = TextEditingController();

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tags Search'),
            content: Container(
              height: MediaQuery.of(context).size.width * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Form(
                  child: ListView(
                children: <Widget>[
                  TextFieldSearch(
                      label: 'Simple Future List',
                      controller: myController,
                      minStringLength: 1,
                      future: () {
                        return fetchdata();
                      }),
                ],
              )),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: (() => Navigator.pop(context, 'Cancel')),
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(myController.text);

                  if (_taglist.contains(myController.text) == false &&
                      _list.contains(myController.text) == true) {
                    print('hello');
                    setState((() => _taglist.add(myController.text)));
                  }
                  /*_list.forEach((item) {
                    print(item);
                  });*/
                  _taglist.forEach((item) {
                    print("*** " + item);
                  });
                  myController.clear();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 70;
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          //*************************************App Bar******************************** */
          SliverAppBar(
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
          //*********************************End App Bar************************************
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 204, 204),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserProfilePage(
                                  userData: widget.userData,
                                  userModel: widget.userModel,
                                );
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.06,
                                  0,
                                  0),
                              width: avatarDiameter,
                              height: avatarDiameter,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(avatarDiameter / 2),
                                //ใส่รูป
                                child: Image(
                                  image: NetworkImage(Userpic),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UserProfilePage(
                                    userData: widget.userData,
                                    userModel: widget.userModel,
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    MediaQuery.of(context).size.height * 0.1,
                                    0,
                                    0),
                                child: Text(
                                  //ใส่ชื่อแต่ละคนโพสต์
                                  Username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: () async {
                                      final name = await _showAddTag(context);
                                    },
                                    icon: FaIcon(FontAwesomeIcons.plus),
                                    //iconSize: 8,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ListView.builder(
                                    itemCount: _taglist.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return TagsField(
                                        onPressed: () {
                                          _taglist.forEach((item) {
                                            if (item == _taglist[index]) {
                                              setState((() =>
                                                  _taglist.remove(item)));
                                            }
                                          });
                                        },
                                        tags: _taglist[index],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 206, 204, 204),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _Textcontroller,
                            minLines: 10,
                            maxLines: 12,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 139, 139, 139),
                                hintText: 'พิมพ์อะไรสักอย่างสิ...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.58,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 206, 204, 204)),
                      child: Column(
                        children: [
                          if (image != null) ...[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IcButton(
                                      icon: FaIcon(FontAwesomeIcons.xmark),
                                      iconSize: 18,
                                      onPressed: () => DeleteImage()),
                                ],
                              ),
                            ),
                            Image.file(image!),
                          ] else ...[
                            Text("No image selected"),
                          ]
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.165,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 105, 105, 105)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: IcButton(
                                        icon: FaIcon(FontAwesomeIcons.image),
                                        iconSize: 26,
                                        onPressed: () {
                                          pickImage();
                                        })),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Visibility(
                                visible: showButton(),
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        postText = _Textcontroller.text;
                                        dataShooter(UserID, Username, Userpic,
                                            postText, imageURL, _taglist);
                                        postText = '';
                                        imageURL = '';
                                        _taglist = [];
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      'post',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 246, 183, 36),
                                      elevation: 3,
                                      shape: StadiumBorder(),
                                    ))),
                          ),
                        ],
                      ),
                    )
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  void dataShooter(int UserID, String Username, String Userpic, String postText,
      String imageURL, List _taglist) async {
    final shot = jsonEncode({
      'user_id': "${UserID}",
      'user_name': "${Username}",
      'user_pic': "${Userpic}",
      'post_text': "${postText}",
      'image_url': "${imageURL}",
      'tags': "${_taglist}"
    });

    Future<int> status = CreatePost(UserID, postText, imageURL, _taglist);

    print(shot);
  }

  bool showButton() {
    if (_taglist.isEmpty == false && _Textcontroller.text != '') {
      return true;
    }
    return false;
  }
}
