import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QuestionsAfterPic extends StatefulWidget {
  const QuestionsAfterPic({super.key});

  @override
  State<QuestionsAfterPic> createState() => _QuestionsAfterPicState();
}

class _QuestionsAfterPicState extends State<QuestionsAfterPic> {
  final controller = PageController(keepPage: true, viewportFraction: 1);
  String? selectedOption;
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
                    SvgPicture.asset("assets/images/ccsmall.svg"),
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
                    'Alex Volkov',
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
                    count: 6,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 3,
                        dotWidth: 27,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black)),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 280,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 1',
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
                              height: height / 28,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 2',
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height / 28,
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
                              height: height / 28,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 3',
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height / 28,
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
                              height: height / 28,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 4',
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height / 28,
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
                              height: height / 28,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 5',
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height / 28,
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
                              height: height / 28,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 6',
                              style: GoogleFonts.ibmPlexSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height / 28,
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
                              height: height / 28,
                            ),
                            TextField(
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
                          ],
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.previousPage(
                            duration: Duration(milliseconds: 500), curve: Curves.ease);
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
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500), curve: Curves.ease);
                        if (controller.page! == 6) {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) {
                          //     return GetstartedScreen();
                          //   },
                          // ));
                        }
                      },
                      child: Center(
                        child: Container(
                          width: width / 2.4,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Submit",
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
            ),
          ),
        ),
      ),
    );
  }
}
