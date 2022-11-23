import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softarchfinal/callapi.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/pages/userprofilepage.dart';
import 'package:softarchfinal/widgets/bottom_banner_ad.dart';

class EditProfilepage extends StatefulWidget {
  const EditProfilepage({Key? key, required this.userData}) : super(key: key);
  final LoginResponseModel userData;
  //final String currentUserId;
  //EditProfilepage({this.currentUserId});
  State<EditProfilepage> createState() => _EditProfilePageState();
}

String imageURL = ' ';

void toStr(File im) {
  imageURL = im.toString();
}

class _EditProfilePageState extends State<EditProfilepage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String name = "";
  String avatarURL2 =
      "https://scontent.fbkk2-8.fna.fbcdn.net/v/t31.18172-8/27983318_927126334112348_3039290882612106297_o.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEJSKqBJw-NYpHLhniXxUaJWAX3VIQhaipYBfdUhCFqKiUnNtN-usrb1_VhxPCFS6WqQxm9QebFqsnh2xxOIP2J&_nc_ohc=FO6mJJc0WnwAX_CHgnT&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfC7wOHDCa9NsrMLto1cGqlR31vhDHSV74XTWTd1S1uxbA&oe=639028DF";

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

  bool loading() {
    if (image != null) {
      return true;
    }
    return false;
  }

  String _setImage() {
    if (image != null) {
      avatarURL2 = imageURL;
    }
    return avatarURL2;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBannerAd(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 222, 105, 21),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "KMITL",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
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
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 130,
                        height: 130,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48),
                            child: loading()
                                ? Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    avatarURL2,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.orange,
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  pickImage();
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ))))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: nameController,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Display Name",
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Ex: Under",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        side: BorderSide(width: 5.0, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (validateAndSave()) {
                        print("name: $name");
                        //---
                        await userEdit(
                            widget.userData.user.user_id, imageURL, name);
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UserProfilePage(
                                userData: widget.userData,
                              );
                            },
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        side: BorderSide(width: 5.0, color: Colors.orange),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      name = nameController.text;
      return true;
    } else {
      return false;
    }
  }
}
