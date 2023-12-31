import 'package:coca_cola/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class StarterkitScreen extends StatefulWidget {
  const StarterkitScreen({super.key});

  @override
  State<StarterkitScreen> createState() => _StarterkitScreenState();
}

class _StarterkitScreenState extends State<StarterkitScreen> {
  final controller = PageController(keepPage: true, viewportFraction: 1);
  String flname = '';
  // late YoutubePlayerController ytcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ytcontroller = YoutubePlayerController.fromVideoId(
    //   videoId: 'ZhqeEyXrXES6nrf1',
    //   autoPlay: true,
    //   params: const YoutubePlayerParams(
    //     showFullscreenButton: true,
    //   ),
    // );

    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      flname = prefs.getString("flname").toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/ccsmall.png", height: 80),
                    Spacer(),
                    // Align(alignment: Alignment.center, child: CustomBadge()),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    flname,
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's see how this app work",
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: height / 1.5,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: controller,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/images/s1.png",
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Welcome to the \nHCCBPL Internship',
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
                            'Unleash your potential and gain real-world experience',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/images/s2.png",
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Welcome to the \nHCCBPL Internship',
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
                            'Unleash your potential and gain real-world experience',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: height / 12,
                          // ),
                          Center(
                              child: Image.asset(
                            "assets/images/s3.png",
                          )),
                          // SizedBox(
                          //   height: height / 10,
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Welcome to the \nHCCBPL Internship',
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
                            'Unleash your potential and gain real-world experience',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   height: 300,
                      //   width: width,
                      //   child: YoutubePlayer(
                      //     aspectRatio: 16 / 9,
                      //     controller: ytcontroller,
                      //   ),
                      // )
                    ],
                  ),
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
                            dotColor: Colors.grey,
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
                                  child: QuestionScreen()));
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
    );
  }
}
