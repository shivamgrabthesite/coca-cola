import 'dart:io';

import 'package:coca_cola/apis/incindence%20apis/grocery_rack_not_available.dart';
import 'package:coca_cola/apis/incindence%20apis/grocery_rack_upload_img.dart';
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'apis/incidence_api.dart';
import 'apis/incindence apis/grocery_rack.dart';
import 'apis/incindence apis/grocery_rack_custom.dart';
import 'model/incidence_model.dart';

class IncidenceScreen extends StatefulWidget {
  const IncidenceScreen({super.key});

  @override
  State<IncidenceScreen> createState() => _IncidenceScreenState();
}

class _IncidenceScreenState extends State<IncidenceScreen> {
  TextEditingController first1 = TextEditingController();
  TextEditingController first2 = TextEditingController();
  TextEditingController second1 = TextEditingController();
  TextEditingController second2 = TextEditingController();
  TextEditingController third1 = TextEditingController();
  TextEditingController third2 = TextEditingController();
  TextEditingController four1 = TextEditingController();
  TextEditingController four2 = TextEditingController();
  int _currentPage = 0;
  late PageController controller;
  String? selectedOption;
  // List<String> img = [
  //   "assets/images/CounterTop.png",
  //   "assets/images/GroceryRack.png",
  //   "assets/images/AmbientRack.png",
  //   "assets/images/AerialHanger.png",
  // ];
  List<First> first = [];
  List<First> second = [];
  List<First> third = [];
  List<First> four = [];
  String title = '';
  String imgTitle = '';
  // String? firstImg, secondImg;
  List<Widget> imgsUpload = [];
  List gorceryList = [];
  XFile? imagesss;
  File? _image;
  String imgName = '';
  String pid = '';
  @override
  void initState() {
    controller = PageController(initialPage: _currentPage);
    super.initState();
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

  // Future _getListImg() async {
  //   imagesss = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (imagesss != null) {
  //     setState(() {
  //       _pickedImages.add(imagesss!);
  //     });
  //   }
  // }

  removeImage() {
    setState(() {
      _image = null;
    });
  }

  getData() {
    IncidenceApi.getData("64c6cf53cfd3911994c43484", "2").then((value) {
      print("incedence data---" + value!.data.toString());
      for (var i = 0; i < value.data.length; i++) {
        setState(() {
          title = value.data[i].title;
          first.add(value.data[i].first);
          second.add(value.data[i].second);
          third.add(value.data[i].third);
          four.add(value.data[i].four);
        });
      }
    });

    Grocaryrackpi.getData().then((value) {
      setState(() {
        pid = value!.id;
      });
      print("grocary id -------" + pid);
    });
  }

  setCustom() {
    GroceryRackCustom.setImage(pid, first2.text, _image!).then((value) {
      print("custom res----" + value.toString());
    });
  }

  setAvailable() {
    if (selectedOption!.contains('first1')) {
      GroceryRackUploadImg.setImage(pid, _image!).then((value) {
        print("avauilable res----" + value.toString());
      });
    }
  }

  setNotAvailable() {
    GroceryRackNotAvailable.setImage(pid, first1.text, _image!).then((value) {
      print("not avauilable res----" + value.toString());
    });
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
                    title,
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
                    count: 4,
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
                  children: [
                    firstColumn(width, context),
                    secondColumn(width, context),
                    thirdColumn(width, context),
                    fourColumn(width, context),
                  ],
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
    );
  }

  // Container uploadImageList(double width, [int index = 0]) {
  //   return Container(
  //     height: 90,
  //     width: width / 1.4,
  //     // margin: EdgeInsets.symmetric(horizontal: 10),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
  //     child: InkWell(
  //       onTap: () {
  //         _getListImg();
  //       },
  //       child: Column(
  //         children: [
  //           _pickedImages.isEmpty
  //               ? const Padding(
  //                   padding: EdgeInsets.only(top: 10),
  //                   child: Icon(
  //                     IconlyLight.paper_upload,
  //                     color: Colors.black,
  //                     size: 40,
  //                   ),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.only(top: 10),
  //                   child: Image.file(File(_pickedImages[index!].path),
  //                       fit: BoxFit.fill, height: 50, width: 50),
  //                 ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Expanded(
  //             child: Text(
  //               _pickedImages.isEmpty ? 'Upload Image' : imagesss!.name,
  //               style: GoogleFonts.inter(
  //                 color: Color(0xFF929292),
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                                              //   if (_pickedImages.length == index + 1) {
                                              //     imgsUpload.add(uploadImage(width));
                                              //   }

                                              //   // _getListImg();
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
                  setAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("first2")) {
                  setNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // first1.clear();
                } else {
                  setCustom();
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
                                              setState(() {
                                                imgsUpload.add(uploadImage(width));
                                              });
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
                                              setState.call(() {
                                                if (imgsUpload.length > 1) {
                                                  imgsUpload.removeAt(index);
                                                }
                                              });
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
                  setAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("second2")) {
                  setNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // second1.clear();
                } else {
                  setCustom();
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
                                              setState(() {
                                                imgsUpload.add(uploadImage(width));
                                              });
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
                                              setState.call(() {
                                                if (imgsUpload.length > 1) {
                                                  imgsUpload.removeAt(index);
                                                }
                                              });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(8),
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
                  setAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("third2")) {
                  setNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else {
                  setCustom();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
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

  Column fourColumn(double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          four[0].title,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(four[0].imageLink)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "four1",
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
            selectedOption == 'four1'
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
                  value: 'four2',
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
                    '${four[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'four2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: four1,
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
                  value: 'four3',
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
            selectedOption == 'four3'
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
                                              setState(() {
                                                imgsUpload.add(uploadImage(width));
                                              });
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
                                              setState.call(() {
                                                if (imgsUpload.length > 1) {
                                                  imgsUpload.removeAt(index);
                                                }
                                              });
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
                            controller: four2,
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
                } else if (selectedOption!.contains("four1")) {
                  setAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("four2")) {
                  setNotAvailable();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // four1.clear();
                } else {
                  setCustom();
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // four2.clear();
                }
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
}
