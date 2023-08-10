import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentPage = 0;
  late PageController controller;
  String? selectedOption;
  String flname = '';

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _currentPage);
  }

  void goBack() {
    if (_currentPage > 0) {
      controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    flname = prefs.getString("flname").toString();
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
                    Align(alignment: Alignment.center, child: CustomBadge()),
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
                    "Please fill the deatils",
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SmoothPageIndicator(
                    controller: controller,
                    count: 7,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 3,
                        dotWidth: 30,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 330,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${index + 1}',
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Text(
                            'Gorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          index == 6
                              ? TextField(
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                      hintText: "Remark here",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.black)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.black))),
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Option 1',
                                          groupValue: selectedOption,
                                          activeColor: Color(0xFFE61D2B),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Yes',
                                          style: GoogleFonts.ibmPlexSerif(
                                            color: Color(0xFF222B45),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'Option 2',
                                          groupValue: selectedOption,
                                          activeColor: Color(0xFFE61D2B),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'No',
                                          style: GoogleFonts.ibmPlexSerif(
                                            color: Color(0xFF222B45),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              index > 0
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.previousPage(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.ease);
                                      },
                                      child: Container(
                                        width: width / 2.4,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          'Back',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ibmPlexSerif(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 500), curve: Curves.ease);
                                  if (controller.page! == 6) {
                                    //  PageTransition(
                                    //     type: PageTransitionType.fade,
                                    //     curve: Curves.decelerate,
                                    //     duration: Duration(seconds: 1),
                                    //     child: TransactionScreen());
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    width: width / 2.4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFE61D2B),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        index == 6 ? "Submit" : "Next",
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
                        ],
                      );
                    },
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
