import 'dart:math';

import 'package:coca_cola/waiting_screen.dart';
import 'package:coca_cola/week_screen.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:coca_cola/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/login_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  bool isCheck = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? emailStr, passStr;
  String msg = '';
  bool? statusCode;
  String loginToken = '';
  String emailtoken = '';
  String fname = '';
  String lname = '';
  String clgName = '';
  String week = '';
  String id = '';

  var _key = GlobalKey<FormState>();

  getData() {
    setState(() {
      emailStr = email.text.toString();
      passStr = password.text.toString();
    });
    LoginApi.setData(emailStr!, passStr!).then((value) async {
      print(value!);

      msg = value.message!;
      statusCode = value.success;
      print("status----------" + statusCode.toString());
      setState(() {
        loginToken = value.data!.token.toString();
        clgName = value.data!.user!.collegeName.toString();
        week = value.data!.user!.week.toString();
        emailtoken = value.userData!.userEmail.toString();
        fname = value.userData!.firstName.toString();
        lname = value.userData!.lastName.toString();
        id = value.userData!.id.toString();
      });
      var pref = await SharedPreferences.getInstance();

      print("login tojen------" + loginToken.toString());
      print("cgname---------" + clgName);
      print("week---------" + week);
      print("email---------" + emailtoken);
      pref.setString("logintoken", loginToken);
      pref.setBool("loginstatus", statusCode!);
      pref.setString("uidtoken", id);
      pref.setString("clgName", clgName);
      pref.setString("week", week);
      pref.setString("useremail", emailtoken);
      pref.setString("flname", fname + " " + lname);
    }).whenComplete(() {
      if (_key.currentState!.validate()) {
        setState(() {
          if (statusCode == true) {
            Fluttertoast.showToast(msg: msg);
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    curve: Curves.decelerate,
                    duration: Duration(seconds: 1),
                    child: BottomBar()));
            // if (clgName == "null") {
            //   Navigator.push(
            //       context,
            //       PageTransition(
            //           type: PageTransitionType.fade,
            //           curve: Curves.decelerate,
            //           duration: Duration(seconds: 1),
            //           child: WeekScreen()));
            // } else {
            //   Navigator.pushReplacement(
            //       context,
            //       PageTransition(
            //           type: PageTransitionType.fade,
            //           curve: Curves.decelerate,
            //           duration: Duration(seconds: 1),
            //           child: BottomBar()));
            // }
          } else {
            Fluttertoast.showToast(
              msg: "Invalid Credentials",
            );
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: "enter all details",
        );
      }
    }).onError((error, stackTrace) {
      // Fluttertoast.showToast(
      //   msg: error.toString(),
      // );
    });
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
                  height: height / 30,
                ),
                Text(
                  'Join the Coca-Cola Internship Program',
                  style: GoogleFonts.ibmPlexSerif(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height / 70,
                ),
                Text(
                  'Unlock new opportunities and gain valuable experience',
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabel(label: "Email"),
                      Container(
                        width: width / 1,
                        height: 42,
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: email,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "";
                            }
                          },
                          onChanged: (value) {
                            value = email.text;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(
                              IconlyLight.message,
                              color: Colors.black,
                            ),
                            hintText: "Eg.alex@gmail.com",
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
                        height: 20,
                      ),
                      CustomLabel(label: "Password"),
                      Container(
                        width: width / 1,
                        height: 42,
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "";
                            } else if (value.length < 8) {
                              return "";
                            }
                          },
                          onChanged: (value) {
                            value = password.text;
                          },
                          cursorColor: Colors.black,
                          obscureText: isObscure,
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
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
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
                    Text(
                      'Remember Me',
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    getData();
                  },
                  child: Center(
                    child: Container(
                      width: 230,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Sign In',
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
                // SizedBox(
                //   height: 30,
                // ),
                // SvgPicture.asset("assets/images/cc2.svg")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
