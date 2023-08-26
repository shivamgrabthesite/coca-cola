import 'package:coca_cola/apis/email_otp_api.dart';
import 'package:coca_cola/registation/mobile_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../waiting_screen.dart';

class EmailOtp extends StatefulWidget {
  const EmailOtp({super.key});

  @override
  State<EmailOtp> createState() => _EmailOtpState();
}

class _EmailOtpState extends State<EmailOtp> {
  String data = '';
  String otp = '';
  sendOtp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getString("token")!;

    EmailOtpApi.setEmail(otp, data).then((value) {
      if (value!.success! == true) {
        Fluttertoast.showToast(
          msg: value.message.toString(),
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.decelerate,
                duration: Duration(seconds: 1),
                child: MobileVerify()));
      } else {
        Fluttertoast.showToast(
          msg: value.message.toString(),
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
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
                  height: 60,
                ),
                OtpTextField(
                  onSubmit: (value) {
                    setState(() {
                      otp = value;
                    });
                    print("otppppp----" + otp);
                  },
                  numberOfFields: 4,
                  hasCustomInputDecoration: true,
                  showFieldAsBox: true,
                  borderRadius: BorderRadius.circular(100),
                  fieldWidth: 60,
                  cursorColor: Colors.black,
                  borderWidth: 1,
                  decoration: InputDecoration(
                    counterStyle: TextStyle(color: Colors.white),
                    // filled: true,
                    // fillColor: Colors.red,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    sendOtp();
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
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Don't receive any code?",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'RESEND OTP',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.ibmPlexSans(
                        color: Color(0xFFE61D2B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
