import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/forgot_email_api1.dart';
import '../widgets/custom_label.dart';
import 'forgot_otp.dart';

class Forgot1 extends StatefulWidget {
  const Forgot1({super.key});

  @override
  State<Forgot1> createState() => _Forgot1State();
}

class _Forgot1State extends State<Forgot1> {
  TextEditingController email = TextEditingController();
  String data='';
  String msgs = '';
  var _key = GlobalKey<FormState>();

  sendMail()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString("token").toString();
    ForgotEmailApi1.setEmail(email.text, data).then((value) {
      if(value!.success ==true)
        {
          prefs.setString("forgotId", value!.data.toString());
          Fluttertoast.showToast(
            msg: value!.message!.toString(),
            gravity: ToastGravity.BOTTOM,
          );
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  curve: Curves.decelerate,
                  duration: Duration(seconds: 1),
                  child: ForgotOtp()));
        }
      else
        {
          Fluttertoast.showToast(
            msg: value!.message!.toString(),
            gravity: ToastGravity.BOTTOM,
          );
        }
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
                    'Forgot Password',
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
                    'Enter your email for the verification process, we will send 4 digits code to your email.',
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomLabel(label: "E-Mail"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: email,
                      onChanged: (value) {
                        setState(() {
                          value = email.text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                      },
                      cursorColor: Colors.black,
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
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                     sendMail();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
