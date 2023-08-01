import 'package:coca_cola/registation/mobile_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

import 'package:coca_cola/apis/email_verify_api.dart';
import 'package:coca_cola/widgets/custom_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerify extends StatefulWidget {
  // String authorization = "";
  EmailVerify({
    Key? key,
    // required this.authorization,
  }) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  TextEditingController email = TextEditingController();
  String? data;
  String msgs = '';
  var _key = GlobalKey<FormState>();

  getData() async {
    if (_key.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      data = prefs.getString("token")!;
      print("data:----" + data!);
      // print("token:----" + widget.authorization);
      EmailVerifyApi.setEmail(email.text, data!).then((value) {
        print("email verify--------" + value.toString());
        setState(() {
          msgs = value!.message.toString();
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
              child: MobileVerify(
                  // authorization: widget.authorization,
                  )));
    } else {
      Fluttertoast.showToast(
        msg: "enter email Id",
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
                    'Join the Coca-Cola Internship Program',
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
                      getData();
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         curve: Curves.decelerate,
                      //         duration: Duration(seconds: 1),
                      //         child: EmailOtp()));
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
