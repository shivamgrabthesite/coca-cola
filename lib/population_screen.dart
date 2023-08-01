// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:coca_cola/apis/options_api.dart';
import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'model/questions_model.dart';

class PopulationScreen extends StatefulWidget {
  String imgId;
  PopulationScreen({
    Key? key,
    required this.imgId,
  }) : super(key: key);

  @override
  State<PopulationScreen> createState() => _PopulationScreenState();
}

class _PopulationScreenState extends State<PopulationScreen> {
  int _currentPage = 0;
  int _currentPage2 = 0;
  late PageController controller;
  late PageController controller2;
  String? selectedOption;
  List<String> img = [
    "assets/images/new1.png",
    "assets/images/new2.png",
  ];

  String title = '';
  String imgTitle = '';
  String? firstImg, secondImg;
  List<First> first = [];
  List<First> second = [];
  List<Third> third = [];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _currentPage);
    controller2 = PageController(initialPage: _currentPage2);
    getData();
  }

  void goBack() {
    if (_currentPage > 0) {
      controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  getData() {
    OptionsApi.getData("64c6e935cfd3911994c43496", "1").then((value) {
      setState(() {
        print(value);
        for (var i = 0; i < value!.data.length; i++) {
          title = value.data[i].title;
          first.add(value.data[i].first[i]);
          second.add(value.data[i].second[i]);
          third.add(value.data[i].third[i]);
        }
      });
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
                    "Population",
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
                Container(
                  height: 620,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index == 0
                                ? first[0].title
                                : index == 1
                                    ? second[0].title
                                    : _currentPage2 == 0
                                        ? third[0].onewayVision.title
                                        : _currentPage2 == 1
                                            ? third[0].standee.title
                                            : _currentPage2 == 2
                                                ? third[0].verticalSignage.title
                                                : third[0].vinylBranding.title,
                            style: GoogleFonts.ibmPlexSans(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          index == 0
                              ? Center(child: Image.network(first[0].imageLink))
                              : index == 1
                                  ? Center(child: Image.network(second[0].imageLink))
                                  : Container(
                                      height: 200,
                                      child: PageView(
                                        controller: controller2,
                                        onPageChanged: (value) {
                                          setState(() {
                                            _currentPage2 = value;
                                          });
                                        },
                                        children: [
                                          Image.network(third[0].onewayVision.imageLink),
                                          Image.network(third[0].standee.imageLink),
                                          Image.network(third[0].verticalSignage.imageLink),
                                          Image.network(third[0].vinylBranding.imageLink),
                                        ],
                                        // children: [
                                        //   Image.asset("assets/images/Standee.png"),
                                        //   Image.asset("assets/images/VerticalSignage.png"),
                                        //   Image.asset("assets/images/OnewayVision.png"),
                                        //   Image.asset("assets/images/VinylBranding.png"),
                                        // ],
                                      ),
                                    ),
                          SizedBox(
                            height: 5,
                          ),
                          index == 2
                              ? Center(
                                  child: SmoothPageIndicator(
                                      controller: controller2,
                                      count: 4,
                                      effect: const ExpandingDotsEffect(
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          dotColor: Colors.grey,
                                          activeDotColor: Colors.black)),
                                )
                              : Container(),
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
                                        ? '${first[0].title} available'
                                        : index == 1
                                            ? "${second[0].title} available"
                                            : _currentPage2 == 0
                                                ? "${third[0].onewayVision.title} available"
                                                : _currentPage2 == 1
                                                    ? "${third[0].standee.title}  available"
                                                    : _currentPage2 == 2
                                                        ? "${third[0].verticalSignage.title}  available"
                                                        : "${third[0].vinylBranding.title}  available",
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
                                            padding: EdgeInsets.only(top: 10),
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
                                            'Upload Image',
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
                                        ? '${first[0].title} not available'
                                        : index == 1
                                            ? "${second[0].title} not available"
                                            : _currentPage2 == 0
                                                ? "${third[0].onewayVision.title}  not available"
                                                : _currentPage2 == 1
                                                    ? "${third[0].standee.title} not available"
                                                    : _currentPage2 == 2
                                                        ? "${third[0].verticalSignage.title} not available"
                                                        : "${third[0].vinylBranding.title} not available",
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
