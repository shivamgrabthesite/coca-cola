// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

import 'package:coca_cola/apis/mobile_verify_api.dart';
import 'package:coca_cola/registation/reg_screen2.dart';
import 'package:coca_cola/widgets/custom_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileVerify extends StatefulWidget {
  // String authorization;
  MobileVerify({
    Key? key,
    // required this.authorization,
  }) : super(key: key);

  @override
  State<MobileVerify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
  TextEditingController mobile = TextEditingController();
  var _key = GlobalKey<FormState>();
  String? data;

  getMobile() async {
    String msgs = '';
    if (_key.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      data = prefs.getString("token")!;
      print("data:----" + data!);
      MobileVerifyApi.setMobile(mobile.text, data!).then((value) {
        print("mobile verify--------" + value!.toString());
        setState(() {
          msgs = value.message.toString();
          Fluttertoast.showToast(
            msg: msgs.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        });
      });
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg.toString())));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
              child: RegScreen2()));
    } else {
      Fluttertoast.showToast(
        msg: "enter 10 digit mobile number",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
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
                    'Join the HCCBPL Internship Program',
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
                    'Unlock new opportunities and gain valuable experience',
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(alignment: Alignment.centerLeft, child: CustomLabel(label: "Phone no")),
                  Container(
                    width: width / 1,
                    height: 70,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: mobile,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        } else if (value.length >= 11) {
                          return "";
                        }
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.call,
                          color: Colors.black,
                        ),
                        hintText: "Eg. 9823564578",
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Gorem ipsum dolor sit amet, Gorem ipsum dolor sit amet, Gorem ipsum dolor sit amet, ',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms & conditions',
                          style: GoogleFonts.ibmPlexSans(
                            color: Color(0xFFE61D2B),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy ',
                          style: GoogleFonts.ibmPlexSans(
                            color: Color(0xFFE61D2B),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'ac aliquet odio mattis.',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      getMobile();
                    },
                    child: Center(
                      child: Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Send OTP',
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
