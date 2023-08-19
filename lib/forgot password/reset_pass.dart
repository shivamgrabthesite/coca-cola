import 'package:coca_cola/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/forgot_last_api.dart';
import '../widgets/custom_label.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool isObscure = true;
  bool isObscure2 = true;
  bool isCheck = false;
  var _key = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_pass = TextEditingController();
  String id='';
  String data='';
  String msgs = '';

  sendData()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString("token").toString();
    id = prefs.getString("forgotId").toString();
    if(_key.currentState!.validate())
      {
        if(password.text == confirm_pass.text)
          {
            ForgotLastApi.setEmail(password.text, confirm_pass.text, id, data).then((value) {
              if(value!.success==true)
              {
                Fluttertoast.showToast(
                  msg: value!.message.toString(),
                  gravity: ToastGravity.BOTTOM,
                );
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        curve: Curves.decelerate,
                        duration: Duration(seconds: 1),
                        child: LoginScreen()));
              }
              else
              {
                Fluttertoast.showToast(
                  msg: "try again",
                  gravity: ToastGravity.BOTTOM,
                );
              }
            });
          }
        else
          {
            Fluttertoast.showToast(
              msg: "password and confirm password should be same",
              gravity: ToastGravity.BOTTOM,
            );
          }
      }

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset("assets/images/backbtn.svg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Reset Password',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.',
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomLabel(label: "Password"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: password,
                      cursorColor: Colors.black,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        } else if (value.length < 8) {
                          return "";
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? Icon(
                                  IconlyLight.hide,
                                )
                              : Icon(
                                  IconlyLight.show,
                                ),
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomLabel(label: "Confirm Password"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: confirm_pass,
                      cursorColor: Colors.black,
                      obscureText: isObscure2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        } else if (value.length < 8) {
                          return "";
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure2 = !isObscure2;
                            });
                          },
                          icon: isObscure2
                              ? Icon(
                                  IconlyLight.hide,
                                )
                              : Icon(
                                  IconlyLight.show,
                                ),
                          color: Colors.black,
                        ),
                        hintText: "Confirm Password",
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        visualDensity: VisualDensity(horizontal: -4),
                        onChanged: (value) {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        activeColor: Colors.black,
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      const Text.rich(
                        softWrap: true,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'you agree to our ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Condition ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy.*',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendData();
                    },
                    child: Center(
                      child: Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Verify',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
