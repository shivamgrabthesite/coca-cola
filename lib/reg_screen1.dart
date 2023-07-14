import 'package:coca_cola/reg_screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'widgets/custom_label.dart';

class RegScreen1 extends StatefulWidget {
  const RegScreen1({super.key});

  @override
  State<RegScreen1> createState() => _RegScreen1State();
}

class _RegScreen1State extends State<RegScreen1> {
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
                    fontSize: 24,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                CustomLabel(label: "First Name"),
                Container(
                  width: width / 1,
                  height: 40,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(
                        IconlyLight.profile,
                        color: Colors.black,
                      ),
                      hintText: "Eg.Alex",
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
                CustomLabel(label: "Last Name"),
                Container(
                  width: width / 1,
                  height: 40,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(
                        CupertinoIcons.phone,
                        color: Colors.black,
                      ),
                      hintText: 'Eg.Volkov',
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
                CustomLabel(label: "College E-mail ID"),
                Container(
                  width: width / 1,
                  height: 40,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(
                        IconlyLight.message,
                        color: Colors.black,
                      ),
                      hintText: 'Eg.alex@gmail.com',
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
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: RegScreen2()));
                  },
                  child: Center(
                    child: Container(
                      width: 230,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Next',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
