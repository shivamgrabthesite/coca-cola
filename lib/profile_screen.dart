import 'package:coca_cola/edit_profile.dart';
import 'package:coca_cola/privacy_policy.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/ccsmall.svg"),
                    Spacer(),
                    Align(alignment: Alignment.center, child: CustomBadge()),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://s.yimg.com/ny/api/res/1.2/dfso95r7vP1yT9qL.g10pg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/gobankingrates_644/2afc0ebc2a13c7132a21889e2bb0c0b9"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alex Volkov',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'alex@gmail.com',
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    PageTransition(
                        type: PageTransitionType.fade,
                        curve: Curves.decelerate,
                        duration: Duration(seconds: 1),
                        child: EditProfile());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset("assets/images/forwardbtn.svg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    PageTransition(
                        type: PageTransitionType.fade,
                        curve: Curves.decelerate,
                        duration: Duration(seconds: 1),
                        child: PrivacyPolicy());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset("assets/images/forwardbtn.svg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Term and Conditions',
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/images/forwardbtn.svg"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'About us',
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/images/forwardbtn.svg"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Contact us',
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/images/forwardbtn.svg"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'FAQ',
                      style: GoogleFonts.ibmPlexSans(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/images/forwardbtn.svg"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
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
