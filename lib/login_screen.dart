import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:coca_cola/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  bool isCheck = false;
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
                CustomLabel(label: "Email"),
                Container(
                  width: width / 1,
                  height: 42,
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
                CustomLabel(label: "Password"),
                Container(
                  width: width / 1,
                  height: 42,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) {
                    //     return BottomBar();
                    //   },
                    // ));
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: BottomBar()));
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
