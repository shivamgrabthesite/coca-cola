import 'dart:io';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'apis/population_api.dart';
import 'model/population_model.dart';

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
  List<First> third = [];
  List<First> four = [];
  List<First> five = [];
  List<First> six = [];
  List<Widget> imgsUpload = [];
  File? _image;
  String imgName = '';
  String pid = '';
  String imgPath = "";
  List<XFile> _pickedImages = [];
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

  Future _getImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _pickedImages.add(image);
      });
    }
    imgName = image!.name;

    setState(() {
      if (image != null) {
        _image = File(image.path);
        imgPath = image.path;
        print("image-------" + _image.toString());
      } else {
        print('No image selected.');
      }
    });
  }

  removeImage() {
    setState(() {
      _image = null;
    });
  }

  uploadImageApi() {
    // CoolerUploadImgApi.setImage(pid, _image!).then((value) {
    //   print("image upload response---------" + value.toString());
    // });
  }

  getData() {
    // OptionsApi.getData("64c6cf53cfd3911994c43484", "1").then((value) {
    //   setState(() {
    //     print(value);
    //     for (var i = 0; i < value!.data.length; i++) {
    //       title = value.data[i].title;
    //       first.add(value.data[i].first[i]);
    //       second.add(value.data[i].second[i]);
    //       third.add(value.data[i].third[i]);
    //     }
    //   });
    // });
    PopulationApi.getData("64c6cf53cfd3911994c43484", "1").then((value) {
      setState(() {
        print(value);
        for (var i = 0; i < value!.data.length; i++) {
          title = value.data[i].title;
          first.add(value.data[i].first);
          second.add(value.data[i].second);
          third.add(value.data[i].third);
          four.add(value.data[i].four);
          five.add(value.data[i].five);
          six.add(value.data[i].six);
        }
      });
    });
    // CoolerApi.getData().then((value) {
    //   setState(() {
    //     pid = value!.id;
    //     print("idddd----------" + value.id);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if (imgsUpload.length < 1) {
      imgsUpload.add(uploadImage(width));
    }

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
                    count: 6,
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 4,
                        dotHeight: 3,
                        dotWidth: 20,
                        spacing: 20,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black)),
                SizedBox(
                  height: 30,
                ),
                ExpandablePageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == 0
                              ? first[0].title
                              : index == 1
                                  ? second[0].title
                                  : index == 2
                                      ? third[0].title
                                      : index == 3
                                          ? four[0].title
                                          : index == 4
                                              ? five[0].title
                                              : six[0].title,
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
                                : index == 2
                                    ? Center(child: Image.network(third[0].imageLink))
                                    : index == 3
                                        ? Center(child: Image.network(four[0].imageLink))
                                        : index == 4
                                            ? Center(child: Image.network(five[0].imageLink))
                                            : Center(child: Image.network(six[0].imageLink)),
                        // index == 0
                        //     ? Center(child: Image.network(first[0].imageLink))
                        //     : index == 1
                        //         ? Center(child: Image.network(second[0].imageLink)):
                        // : Container(
                        //     height: 200,
                        //     child: PageView(
                        //       controller: controller2,
                        //       onPageChanged: (value) {
                        //         setState(() {
                        //           _currentPage2 = value;
                        //         });
                        //       },
                        //       children: [
                        //         Image.network(third[0].onewayVision.imageLink),
                        //         Image.network(third[0].standee.imageLink),
                        //         Image.network(third[0].verticalSignage.imageLink),
                        //         Image.network(third[0].vinylBranding.imageLink),
                        //       ],
                        //       // children: [
                        //       //   Image.asset("assets/images/Standee.png"),
                        //       //   Image.asset("assets/images/VerticalSignage.png"),
                        //       //   Image.asset("assets/images/OnewayVision.png"),
                        //       //   Image.asset("assets/images/VinylBranding.png"),
                        //       // ],
                        //     ),
                        //   ),
                        SizedBox(
                          height: 5,
                        ),
                        // index == 2
                        //     ? Center(
                        //         child: SmoothPageIndicator(
                        //             controller: controller2,
                        //             count: 4,
                        //             effect: const ExpandingDotsEffect(
                        //                 dotHeight: 8,
                        //                 dotWidth: 8,
                        //                 dotColor: Colors.grey,
                        //                 activeDotColor: Colors.black)),
                        //       )
                        //     : Container(),
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
                                          : index == 2
                                              ? "${third[0].title} available"
                                              : index == 3
                                                  ? "${four[0].title}  available"
                                                  : index == 4
                                                      ? "${five[0].title}  available"
                                                      : "${six[0].title}  available",
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
                                                  child: Image.file(_image!,
                                                      fit: BoxFit.fill, height: 50, width: 50),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _image == null ? 'Upload Image' : imgName,
                                              style: GoogleFonts.inter(
                                                color: Color(0xFF929292),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
                                          : index == 2
                                              ? "${third[0].title}  not available"
                                              : index == 3
                                                  ? "${four[0].title} not available"
                                                  : index == 4
                                                      ? "${five[0].title} not available"
                                                      : "${six[0].title} not available",
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
                                                              // setState(() {
                                                              //   imgsUpload.add(uploadImage(width));
                                                              // });
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                // padding: EdgeInsets.all(8),
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
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // setState.call(() {
                                                              //   imgsUpload.removeAt(index);
                                                              // });
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                // padding: EdgeInsets.all(8),
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
                                uploadImageApi();
                                controller.nextPage(
                                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                                removeImage();
                                if (controller.page! == 5) {
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
                                      index == 5 ? "Submit" : "Next",
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
