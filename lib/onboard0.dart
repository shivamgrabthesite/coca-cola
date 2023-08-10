import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'getstarted_screen.dart';

class Onboard0 extends StatefulWidget {
  const Onboard0({super.key});

  @override
  State<Onboard0> createState() => _Onboard0State();
}

class _Onboard0State extends State<Onboard0> {
  final controller = PageController(keepPage: true, viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return SafeArea(
      bottom: false,
      maintainBottomViewPadding: true,
      child: Container(
        height: height,
        color: Colors.white,
        child: Stack(children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // child: SvgPicture.asset("assets/images/blackpic.svg")
            child: ClipPath(
              clipper: WaveClipperTwo(
                reverse: true,
              ),
              child: Container(
                height: height / 2,
                color: Colors.black,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.decelerate,
                                duration: Duration(seconds: 1),
                                child: GetstartedScreen())),
                        child: Text(
                          'Skip',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: height / 1.4,
                      child: PageView(
                          controller: controller,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Welcome to HCCBPL RING OF MAGIC',
                                    style: GoogleFonts.ibmPlexSerif(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Step into a world of possibilities where learning meets adventure.',
                                  style: GoogleFonts.ibmPlexSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Image.asset(
                                  "assets/images/w3.png",
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Explore Endless Possibilities',
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Discover the magic that lies ahead. Embark on a journey of exploration as you uncover Coca-Cola stores near your university. ',
                                  style: GoogleFonts.ibmPlexSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/w1.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Your \nCoca-Cola Adventure',
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Embrace innovation, leadership, and growth with our internship. From store interactions to understanding consumer dynamics, every step is a leap towards becoming a change-maker.',
                                  style: GoogleFonts.ibmPlexSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/w2.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SizedBox(
                            //       height: 30,
                            //     ),
                            //     Text(
                            //       'Welcome to the \nCoca-Cola Internship',
                            //       style: GoogleFonts.ibmPlexSerif(
                            //         color: Colors.black,
                            //         fontSize: 24,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 10,
                            //     ),
                            //     Text(
                            //       'Unleash your potential and gain real-world experience',
                            //       style: GoogleFonts.ibmPlexSerif(
                            //         color: Colors.black,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: height / 20,
                            //     ),
                            //     SvgPicture.asset(
                            //       "assets/images/ob1.svg",
                            //       fit: BoxFit.contain,
                            //     ),
                            //     // SvgPicture.asset(
                            //     //   "assets/images/coca.svg",
                            //     // )
                            //   ],
                            // ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Column(
                            //       children: [
                            //         Text(
                            //           'Explore Endless Possibilities',
                            //           style: GoogleFonts.ibmPlexSerif(
                            //             color: Colors.black,
                            //             fontSize: 24,
                            //             fontWeight: FontWeight.w600,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 10,
                            //         ),
                            //         Text(
                            //           'Discover Coca-Cola stores near your university',
                            //           style: GoogleFonts.ibmPlexSerif(
                            //             color: Colors.black,
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w400,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(
                            //       height: height / 6,
                            //     ),
                            //     Center(
                            //       child: SvgPicture.asset(
                            //         "assets/images/ob2.svg",
                            //         alignment: Alignment.center,
                            //       ),
                            //     ),
                            //     // SvgPicture.asset(
                            //     //   "assets/images/coca.svg",
                            //     // )
                            //   ],
                            // ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Start Your \nCoca-Cola Adventure',
                            //       style: GoogleFonts.ibmPlexSerif(
                            //         color: Colors.black,
                            //         fontSize: 24,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 10,
                            //     ),
                            //     Text(
                            //       'Make a lasting impact and build your career',
                            //       style: GoogleFonts.ibmPlexSerif(
                            //         color: Colors.black,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: height / 10,
                            //     ),
                            //     Center(
                            //       child: SvgPicture.asset(
                            //         "assets/images/ob3.svg",
                            //         fit: BoxFit.contain,
                            //       ),
                            //     ),
                            //     // SvgPicture.asset(
                            //     //   "assets/images/coca.svg",
                            //     // )
                            //   ],
                            // ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: const ExpandingDotsEffect(
                                dotHeight: 10,
                                dotWidth: 14,
                                dotColor: Colors.white,
                                activeDotColor: Colors.red)),
                        GestureDetector(
                          onTap: () {
                            controller.nextPage(
                                duration: Duration(milliseconds: 500), curve: Curves.ease);
                            if (controller.page! == 2) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      curve: Curves.decelerate,
                                      duration: Duration(seconds: 1),
                                      child: GetstartedScreen()));
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/nextbtn.svg",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
