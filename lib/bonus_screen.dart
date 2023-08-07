import 'dart:io';

import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  int _currentPage = 0;
  late PageController controller;
  String? selectedOption;
  List<String> img = [
    "assets/images/CounterBranding.png",
    "assets/images/SlideinPosterFrame.png",
    "assets/images/PriceStrip.png",
  ];

  List<Widget> imgsUpload = [];
  File? _image;
  String imgName = '';
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

  Future _getImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );
    imgName = image!.name;

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
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
                    "Bonus",
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
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 4,
                        dotHeight: 3,
                        dotWidth: 40,
                        spacing: 20,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black)),
                SizedBox(
                  height: 30,
                ),
                ExpandablePageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == 0
                              ? 'Counter Branding'
                              : index == 1
                                  ? "Slide-in Poster Frame"
                                  : "Price Strip",
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Center(child: Image.asset(img[index])),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'op1',
                                  groupValue: selectedOption,
                                  activeColor: Color(0xFFE61D2B),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                                Text(
                                  index == 0
                                      ? 'Counter Branding available'
                                      : index == 1
                                          ? "Slide-in Poster Frame available"
                                          : "Price Strip available",
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Color(0xFF222B45),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            selectedOption == 'op1'
                                ? Container(
                                    height: 90,
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: width,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Icon(
                                            IconlyLight.paper_upload,
                                            color: Colors.black,
                                            size: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Upload Image of Counter Branding',
                                          style: GoogleFonts.inter(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'op2',
                                  groupValue: selectedOption,
                                  activeColor: Color(0xFFE61D2B),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                                Text(
                                  index == 0
                                      ? 'Counter Branding not available'
                                      : index == 1
                                          ? "Slide-in Poster Frame not available"
                                          : "Price Strip not available",
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Color(0xFF222B45),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            selectedOption == 'op2'
                                ? Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
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
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'op3',
                                  groupValue: selectedOption,
                                  activeColor: Color(0xFFE61D2B),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Add custom',
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Color(0xFF222B45),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            selectedOption == 'op3'
                                ? StatefulBuilder(
                                    builder: (context, setState) => Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        children: [
                                          // imgsUpload.isEmpty
                                          //     ? Row(
                                          //         children: [
                                          //           uploadImage(width),
                                          //           Spacer(),
                                          //           GestureDetector(
                                          //             onTap: () {
                                          //               setState.call(
                                          //                 () {
                                          //                   imgsUpload.add(uploadImage(width));
                                          //                 },
                                          //               );
                                          //             },
                                          //             child: Center(
                                          //               child: Container(
                                          //                 padding: EdgeInsets.all(10),
                                          //                 height: 50,
                                          //                 decoration: BoxDecoration(
                                          //                     color: Color(0xFFE61D2B),
                                          //                     shape: BoxShape.circle),
                                          //                 child: Center(
                                          //                   child: Text(
                                          //                     "+",
                                          //                     textAlign: TextAlign.center,
                                          //                     style: GoogleFonts.ibmPlexSerif(
                                          //                       color: Colors.white,
                                          //                       fontSize: 22,
                                          //                       fontWeight: FontWeight.w600,
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       )
                                          // :
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) => Row(
                                                    children: [
                                                      uploadImage(width),
                                                      Spacer(),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                imgsUpload.add(uploadImage(width));
                                                              });
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xFFE61D2B),
                                                                    shape: BoxShape.circle),
                                                                child: Center(
                                                                  child: Text(
                                                                    "+",
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
                                                          // Spacer(),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState.call(() {
                                                                imgsUpload.removeAt(index);
                                                              });
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xFFE61D2B),
                                                                    shape: BoxShape.circle),
                                                                child: Center(
                                                                  child: Text(
                                                                    "-",
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
                                              separatorBuilder: (context, index) => SizedBox(
                                                    height: 10,
                                                  ),
                                              itemCount: imgsUpload.length),
                                          SizedBox(
                                            height: 10,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container()
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
                                if (controller.page! == 2) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          curve: Curves.decelerate,
                                          duration: Duration(seconds: 1),
                                          child: TransactionScreen()));
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
                                      index == 2 ? "Submit" : "Next",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container uploadImage(double width) {
    return Container(
      height: 90,
      width: width / 1.4,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          _getImage();
        },
        child: Column(
          children: [
            _image == null
                ? const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      IconlyLight.paper_upload,
                      color: Colors.black,
                      size: 40,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(_image!, fit: BoxFit.fill, height: 50, width: 50),
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              _image == null ? 'Upload Image' : imgName,
              style: GoogleFonts.inter(
                color: Color(0xFF929292),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
