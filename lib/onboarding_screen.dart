import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'getstarted_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController(keepPage: true, viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Positioned(
                  bottom: -20,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/images/blackpic.svg")),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GetstartedScreen(),
                            )),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Welcome to the \nCoca-Cola Internship',
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
                                      'Unleash your potential and gain real-world experience',
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: height / 2.4,
                                        child: SvgPicture.asset(
                                          "assets/images/ob1.svg",
                                          // height: height / 2,
                                        ),
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/coca.svg",
                                    // )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explore Endless Possibilities',
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
                                      'Discover Coca-Cola stores near your university',
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Center(
                                      child: SvgPicture.asset(
                                        "assets/images/ob2.svg",
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/coca.svg",
                                    // )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Your \nCoca-Cola Adventure',
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
                                      'Make a lasting impact and build your career',
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: SvgPicture.asset(
                                        "assets/images/ob3.svg",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/coca.svg",
                                    // )
                                  ],
                                ),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return GetstartedScreen();
                                    },
                                  ));
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
            ],
          ),
        ),
      ),
    );
  }
}
