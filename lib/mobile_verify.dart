import 'package:coca_cola/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

import 'otp_screen.dart';

class MobileVerify extends StatefulWidget {
  const MobileVerify({super.key});

  @override
  State<MobileVerify> createState() => _MobileVerifyState();
}

class _MobileVerifyState extends State<MobileVerify> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(
                        IconlyLight.message,
                        color: Colors.black,
                      ),
                      hintText: "Eg.alex@gmail.com",
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
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: OTPScreen()));
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
    );
  }
}
