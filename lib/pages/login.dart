import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:softarchfinal/model/login_response.dart';
import 'package:softarchfinal/pages/userdisplay.dart';
import 'package:softarchfinal/widgets/bottom_banner_ad.dart';
import 'package:softarchfinal/widgets/emailfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softarchfinal/callapi.dart';

import 'package:softarchfinal/model/login_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String testText = "";
  String email = "";
  String password = '';
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
        bottomNavigationBar: BottomBannerAd(),
        body: Form(
            key: globalKey,
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(233, 99, 23, 1)),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: screenWidth * 4 / 5,
                    height: height * 259 / 463,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new)),
                      ),
                      const Text(
                        "KMITL",
                        style: TextStyle(
                          fontSize: 35.34,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'NEWS',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 12, 35, 0),
                        child: SizedBox(
                          height: 54,
                          child: EmailFieldWidget(controller: emailController),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 54,
                        child: FormHelper.inputFieldWidget(
                          context,
                          "password",
                          "Password",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return "password invaild";
                            }

                            return null;
                          },
                          (onSavedVal) => {
                            this.password = onSavedVal.toString().trim(),
                          },
                          onChange: (val) {},
                          initialValue: "",
                          obscureText: false,
                          borderFocusColor: Colors.black,
                          prefixIconColor: Theme.of(context).primaryColor,
                          borderColor: Colors.black.withOpacity(0.2),
                          borderRadius: 8,
                          borderWidth: 1,
                          focusedBorderWidth: 1,
                          hintColor: Colors.black.withOpacity(0.2),
                          fontSize: 14,
                          hintFontSize: 14,
                          paddingLeft: 35,
                          paddingRight: 35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: const Size(256, 34),
                          primary:
                              const Color.fromRGBO(76, 77, 79, 1), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          if (validateAndSave()) {
                            print("email: $email");
                            print("password: $password");
                            //---
                            var status = await userLogin(email, password);

                            LoginResponseModel userData =
                                loginResponseJson(status.body);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return userdisplay(
                                userData: userData,
                              );
                            }), (route) => false);
                          }
                        },
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Color.fromRGBO(79, 175, 244, 1),
                              fontSize: 12),
                        ),
                        onPressed: () {},
                      ),
                    ])),
              ),
            )));
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      email = emailController.text;
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
