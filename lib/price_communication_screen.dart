import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'apis/price_communication_api.dart';
import 'model/price_communication_model.dart';

class PriceCommunicationScreen extends StatefulWidget {
  const PriceCommunicationScreen({super.key});

  @override
  State<PriceCommunicationScreen> createState() => _PriceCommunicationScreenState();
}

class _PriceCommunicationScreenState extends State<PriceCommunicationScreen> {
  int _currentPage = 0;
  late PageController controller;
  String? selectedOption;
  List<String> img = [
    "assets/images/PackCutout.png",
    "assets/images/POSM.png",
    "assets/images/PriceStrip.png",
    "assets/images/BrandStrip.png",
  ];
  List<First> first = [];
  List<First> second = [];
  List<First> third = [];
  String title = '';
  String imgTitle = '';
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _currentPage);
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
    PriceCommunicationApi.getData("64c6e935cfd3911994c43496", "3").then((value) {
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
                    "Price Communication",
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
                                    : third[0].title,
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
                                  : Center(child: Image.network(third[0].imageLink)),
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
                                  Expanded(
                                    child: Text(
                                      index == 0
                                          ? '${first[0].title} available'
                                          : index == 1
                                              ? "${second[0].title} available"
                                              : "${third[0].title} available",
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Color(0xFF222B45),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                  Expanded(
                                    child: Text(
                                      index == 0
                                          ? '${first[0].title} not available'
                                          : index == 1
                                              ? "${second[0].title} not available"
                                              : "${third[0].title} not available",
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Color(0xFF222B45),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                  if (controller.page! == 3) {
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
                                        index == 3 ? "Submit" : "Next",
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
