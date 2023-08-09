import 'package:coca_cola/login_screen.dart';
import 'package:coca_cola/registation/email_verify.dart';
import 'package:coca_cola/registation/reg_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset("assets/images/backbtn.svg"))),
                ),
                SvgPicture.asset(
                  "assets/images/cc1.svg",
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: RegScreen1()));
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Get Started',
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
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: LoginScreen()));
                  },
                  child: Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Have an account?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSerif(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
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
