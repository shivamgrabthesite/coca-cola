import 'dart:io';

import 'package:coca_cola/apis/bonus/counter_custom.dart';
import 'package:coca_cola/apis/bonus_api.dart';
import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'apis/bonus/ambient_api.dart';
import 'apis/bonus/ambient_available.dart';
import 'apis/bonus/ambient_custom.dart';
import 'apis/bonus/counter_available.dart';
import 'apis/bonus/counter_not_availble.dart';
import 'apis/bonus/counting_api.dart';
import 'apis/bonus/slidein_api.dart';
import 'apis/bonus/slidein_available.dart';
import 'apis/bonus/slidein_custom.dart';
import 'apis/bonus/slidein_not_available.dart';
import 'apis/incindence apis/ambient_rack_not_available.dart';
import 'model/bonus_model.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  TextEditingController first1 = TextEditingController();
  TextEditingController first2 = TextEditingController();
  TextEditingController second1 = TextEditingController();
  TextEditingController second2 = TextEditingController();
  TextEditingController third1 = TextEditingController();
  TextEditingController third2 = TextEditingController();
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

  List<Widget> imgsUpload = [];
  File? _image;
  String imgName = '';
  String cid = '';
  String aid = '';
  String sid = '';
  String tid = '';
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

  // String

  Future _getImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
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

  getData() async {
    BonusApi.getData("64c6cf53cfd3911994c43484", "4").then((value) {
      // print(value);
      for (var i = 0; i < value!.data.length; i++) {
        setState(() {
          title = value.data[i].title;
          first.add(value.data[i].first);
          second.add(value.data[i].second);
          third.add(value.data[i].third);
        });
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tid = prefs.getString("tid").toString();

    CounterApi.getData(tid).then((value) {
      setState(() {
        cid = value!.id!;
      });
    });
    AmbientApi.getData(tid).then((value) {
      setState(() {
        aid = value!.id!;
      });
    });
    SplideinApi.getData(tid).then((value) {
      setState(() {
        sid = value!.id;
      });
    });
  }

  counterUploadImage() {
    CounterAvailable.setImage(cid!, _image!).then((value) {
      print("image upload response---------" + value.toString());
    });
  }

  ambientUploadImage() {
    AmbientAvailable.setImage(aid!, _image!).then((value) {
      print("image upload response---------" + value.toString());
    });
  }

  slideinUploadImage() {
    SlideinAvailable.setImage(sid!, _image!).then((value) {
      print("image upload response---------" + value.toString());
    });
  }

  counterNotAvailable() {
    CounterNotAvailable.setImage(cid!, first1.text, _image!);
  }

  ambeintNotAvailable() {
    // AmbientRackNotAvailable.setImage(aid!, second1.text, _image!);
  }

  slideinNotAvailable() {
    SlideinNotAvailable.setImage(sid!, third1.text, _image!);
  }

  counterCustom() {
    CounterCustom.setImage(cid!, first2.text, _image!);
  }

  ambientCustom() {
    AmbientCustom.setImage(aid!, second2.text, _image!);
  }

  slideidCustom() {
    SlideinCustom.setImage(sid!, third2.text, _image!);
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
                ExpandablePageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (value) {},
                  // itemCount: 3,
                  // itemBuilder: (context, index) {
                  //   return firstColumn(index, width, context);
                  // },
                  children: [
                    firstColumn(width, context),
                    secondColumn(width, context),
                    thirdColumn(width, context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column firstColumn(double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          first[0].title,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(first[0].imageLink)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "first1",
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
                    '${first[0].title} available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'first1'
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
                                  child:
                                      Image.file(_image!, fit: BoxFit.fill, height: 50, width: 50),
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
                  value: 'first2',
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
                    '${first[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'first2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: first1,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 'first3',
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
            selectedOption == 'first3'
                ? StatefulBuilder(
                    builder: (context, setState) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      uploadImage(width),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                padding: EdgeInsets.all(4),
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
                                              //   if (imgsUpload.length > 1) {
                                              //     imgsUpload.removeAt(index);
                                              //   }
                                              // });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFE61D2B),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    "x",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
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
                            controller: first2,
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
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (selectedOption!.isEmpty || _image == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("first1")) {
                  // setAvailable();
                  counterUploadImage();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("first2")) {
                  // setNotAvailable();
                  counterNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // first1.clear();
                } else {
                  // setCustom();
                  counterCustom();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // first2.clear();
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
                      "Next",
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
  }

  Column secondColumn(double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          second[0].title,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(second[0].imageLink)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "second1",
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
                    '${second[0].title} available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'second1'
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
                                  child:
                                      Image.file(_image!, fit: BoxFit.fill, height: 50, width: 50),
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
                  value: 'second2',
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
                    '${second[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'second2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: second1,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 'second3',
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
            selectedOption == 'second3'
                ? StatefulBuilder(
                    builder: (context, setState) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      uploadImage(width),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                padding: EdgeInsets.all(4),
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
                                              //   if (imgsUpload.length > 1) {
                                              //     imgsUpload.removeAt(index);
                                              //   }
                                              // });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFE61D2B),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    "x",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
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
                            controller: second2,
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
            // index > 0
            // ?
            GestureDetector(
              onTap: () {
                controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
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
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (selectedOption!.isEmpty || _image == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("second1")) {
                  // setAvailable();
                  ambientUploadImage();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("second2")) {
                  // setNotAvailable();
                  ambeintNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // second1.clear();
                } else {
                  // setCustom();
                  ambientCustom();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // second2.clear();
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
                      "Next",
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
  }

  Column thirdColumn(double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          third[0].title,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(third[0].imageLink)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "third1",
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
                    '${third[0].title} available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'third1'
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
                                  child:
                                      Image.file(_image!, fit: BoxFit.fill, height: 50, width: 50),
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
                  value: 'third2',
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
                    '${third[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'third2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: third1,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 'third3',
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
            selectedOption == 'third3'
                ? StatefulBuilder(
                    builder: (context, setState) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      uploadImage(width),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                padding: EdgeInsets.all(4),
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
                                              //   if (imgsUpload.length > 1) {
                                              //     imgsUpload.removeAt(index);
                                              //   }
                                              // });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFE61D2B),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    "x",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
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
                            controller: third2,
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
            // index > 0
            //     ?
            GestureDetector(
              onTap: () {
                controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
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
            //     : Container(),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (selectedOption!.isEmpty || _image == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("third1")) {
                  // setAvailable();
                  slideinUploadImage();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: TransactionScreen()));
                  // removeImage();
                } else if (selectedOption!.contains("third2")) {
                  // setNotAvailable();
                  slideinNotAvailable();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: TransactionScreen()));
                  // removeImage();
                  // third1.clear();
                } else {
                  // setCustom();
                  slideidCustom();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: TransactionScreen()));
                  // removeImage();
                  // third2.clear();
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
