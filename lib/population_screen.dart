import 'dart:io';
import 'package:coca_cola/provider/population_provider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'apis/population apis/cooler_api.dart';
import 'apis/population apis/cooler_available.dart';
import 'apis/population apis/cooler_custom.dart';
import 'apis/population apis/cooler_not_avaliable.dart';
import 'apis/population apis/dps_api.dart';
import 'apis/population apis/dps_available.dart';
import 'apis/population apis/dps_custom.dart';
import 'apis/population apis/dps_not_available.dart';
import 'apis/population apis/oneway_vision_api.dart';
import 'apis/population apis/oneway_vision_available.dart';
import 'apis/population apis/oneway_vision_custom.dart';
import 'apis/population apis/oneway_vision_not_available.dart';
import 'apis/population apis/standee_api.dart';
import 'apis/population apis/standee_available.dart';
import 'apis/population apis/standee_custom.dart';
import 'apis/population apis/standee_not_available.dart';
import 'apis/population apis/vertical_signage_api.dart';
import 'apis/population apis/vertical_signage_available.dart';
import 'apis/population apis/vertical_signage_custom.dart';
import 'apis/population apis/vertical_signage_not_available.dart';
import 'apis/population apis/vinyl_branding_api.dart';
import 'apis/population apis/vinyl_branding_available.dart';
import 'apis/population apis/vinyl_branding_custom.dart';
import 'apis/population apis/vinyl_branding_not_available.dart';
import 'apis/population_api.dart';
import 'model/population_model.dart';

class PopulationScreen extends StatefulWidget {
  String? tid;
  PopulationScreen({
    Key? key,
    this.tid,
  }) : super(key: key);

  @override
  State<PopulationScreen> createState() => _PopulationScreenState();
}

class _PopulationScreenState extends State<PopulationScreen> {
  // TextEditingController dps1 = TextEditingController();
  // TextEditingController dps2 = TextEditingController();
  // TextEditingController cooler1 = TextEditingController();
  // TextEditingController cooler2 = TextEditingController();
  // TextEditingController standee1 = TextEditingController();
  // TextEditingController standee2 = TextEditingController();
  // TextEditingController vertical1 = TextEditingController();
  // TextEditingController vertical2 = TextEditingController();
  // TextEditingController oneway1 = TextEditingController();
  // TextEditingController oneway2 = TextEditingController();
  // TextEditingController vinyl1 = TextEditingController();
  // TextEditingController vinyl2 = TextEditingController();
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
  // String? firstImg, secondImg;
  List<First> first = [];
  List<First> second = [];
  List<First> third = [];
  List<First> four = [];
  List<First> five = [];
  List<First> six = [];
  List<Widget> imgsUpload = [];
  // File? _image;
  // String imgName = "";
  // String imgPath = "";
  String? dpsid, cooleid, standeeid, verticalid, onewayid, vinylid;
  // List<XFile> _pickedImages = [];
  String tid = '';
  String flname = '';
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

  // Future _getImage() async {
  //   var image = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //   );
  //   imgName = image!.name;

  //   setState(() {
  //     if (image != null) {
  //       _image = File(image.path);
  //       imgPath = image.path;
  //       print("image-------" + _image.toString());
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // removeImage() {
  //   setState(() {
  //     _image = null;
  //   });
  // }

  getData() async {
    print("tid in population:" + widget.tid!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tid = prefs.getString("tid").toString();
      flname = prefs.getString("flname").toString();
      print("tid----------" + tid);
    });
    PopulationApi.getData("64c6cf53cfd3911994c43484", "1").then((value) {
      for (var i = 0; i < value!.data!.length; i++) {
        setState(() {
          title = value.data![i].title!;
          first.add(value.data![i].first!);
          second.add(value.data![i].second!);
          third.add(value.data![i].third!);
          four.add(value.data![i].four!);
          five.add(value.data![i].five!);
          six.add(value.data![i].six!);
        });
      }
    });
  }

  coolerUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    CoolerApi.getData(tid!).then((value) {
      setState(() {
        cooleid = value!.id;
        print("cooler----------" + value.id!);
      });
    }).whenComplete(() {
      CoolerAvailable.setImage(cooleid!, provider.cooler!).then((value) {});
    });
  }

  dpsUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
      });
    }).whenComplete(() {
      DPsAvailable.setImage(dpsid!, provider.dps!).then((value) {
        // print("image upload response---------" + value.toString());
      });
    });
  }

  standeeUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    StandeeApi.getData(tid!).then((value) {
      setState(() {
        standeeid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      StandeeAvailable.setImage(standeeid!, provider.standee!).then((value) {
        // print("image upload response---------" + value.toString());
      });
    });
  }

  verticalUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VerticalSignageApi.getData(tid!).then((value) {
      setState(() {
        verticalid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VerticalSignageAvailable.setImage(verticalid!, provider.vertical!).then((value) {
        // print("image upload response---------" + value.toString());
      });
    });
  }

  onewayUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    OnewayApi.getData(tid!).then((value) {
      setState(() {
        onewayid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      OnewayVisionAvailable.setImage(onewayid!, provider.oneway!).then((value) {
        // print("image upload response---------" + value.toString());
      });
    });
  }

  vinylUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VinylBrandingApi.getData(tid!).then((value) {
      setState(() {
        vinylid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VVinylBrandingAvailable.setImage(vinylid!, provider.vinyl!).then((value) {
        // print("image upload response---------" + value.toString());
      });
    });
  }

  coolerNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    CoolerApi.getData(tid!).then((value) {
      setState(() {
        cooleid = value!.id;
        // print("cooler----------" + value.id!);
      });
    }).whenComplete(() {
      CoolerNotAvailableApi.setImage(cooleid!, provider.cooler1.text, provider.cooler!);
    });
  }

  dpsNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      DpsNotAvailable.setImage(dpsid!, provider.dps1.text, provider.dps!);
    });
  }

  standeeNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    StandeeApi.getData(tid!).then((value) {
      setState(() {
        standeeid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      StandeeNotAvailable.setImage(standeeid!, provider.standee1.text, provider.standee!);
    });
  }

  verticalNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VerticalSignageApi.getData(tid!).then((value) {
      setState(() {
        verticalid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VerticalSignageNotAvailable.setImage(
          verticalid!, provider.vertical1.text, provider.vertical!);
    });
  }

  onewayNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    OnewayApi.getData(tid!).then((value) {
      setState(() {
        onewayid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      OnewayVisionNotAvailable.setImage(onewayid!, provider.oneway1.text, provider.oneway!);
    });
  }

  vinylNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VinylBrandingApi.getData(tid!).then((value) {
      setState(() {
        vinylid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VinylBrandingNotAvailable.setImage(vinylid!, provider.vinyl1.text, provider.vinyl!);
    });
  }

  coolerCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    CoolerApi.getData(tid!).then((value) {
      setState(() {
        cooleid = value!.id;
        // print("cooler----------" + value.id!);
      });
    }).whenComplete(() {
      CoolerCustom.setImage(cooleid!, provider.cooler2.text, provider.cooler!);
    });
  }

  standeeCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    StandeeApi.getData(tid!).then((value) {
      setState(() {
        standeeid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      StandeeCustom.setImage(standeeid!, provider.standee2.text, provider.standee!);
    });
  }

  dpsCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      DpsCustom.setImage(dpsid!, provider.dps2.text, provider.dps!);
    });
  }

  verticalCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VerticalSignageApi.getData(tid!).then((value) {
      setState(() {
        verticalid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VerticalSignageCustom.setImage(verticalid!, provider.vertical2.text, provider.vertical!);
    });
  }

  onewayCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    OnewayApi.getData(tid!).then((value) {
      setState(() {
        onewayid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      OnewayVisionCustom.setImage(onewayid!, provider.oneway2.text, provider.oneway!);
    });
  }

  vinylCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VinylBrandingApi.getData(tid!).then((value) {
      setState(() {
        vinylid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() {
      VinylBrandingCustom.setImage(vinylid!, provider.vinyl2.text, provider.vinyl!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    // if (imgsUpload.length < 1) {
    //   imgsUpload.add(uploadImage(width));
    // }

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
                    // Spacer(),
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
                ExpandablePageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    firstColumn(width, context),
                    seocndColumn(width, context),
                    thirdColumn(width, context),
                    fourColumn(width, context),
                    fiveColumn(width, context),
                    sixColumn(width, context),
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
    var firstProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          first[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(first[0].imageLink!)),
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
                        // _getImage();
                        firstProvider.dpsImage();
                      },
                      child: Column(
                        children: [
                          firstProvider.dps == null
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
                                  child: Image.file(firstProvider.dps!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              firstProvider.dps == null ? 'Upload Image' : firstProvider.dpsname,
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
                          controller: firstProvider.dps1,
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
                            // _getImage();
                            firstProvider.dpsImage();
                          },
                          child: Column(
                            children: [
                              firstProvider.dps == null
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
                                      child: Image.file(firstProvider.dps!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  firstProvider.dps == null
                                      ? 'Upload Image'
                                      : firstProvider.dpsname,
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
                          // ListView.separated(
                          //     shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          //     itemBuilder: (context, index) => Row(
                          //           children: [

                          //             Spacer(),
                          //             Column(
                          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //               children: [
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     // setState(() {
                          //                     //   imgsUpload.add(uploadImage(width));
                          //                     // });
                          //                   },
                          //                   child: Center(
                          //                     child: Container(
                          //                       height: 40,
                          //                       width: 40,
                          //                       padding: EdgeInsets.all(4),
                          //                       decoration: BoxDecoration(
                          //                           color: Color(0xFFE61D2B),
                          //                           shape: BoxShape.circle),
                          //                       child: Center(
                          //                         child: Text(
                          //                           "+",
                          //                           style: GoogleFonts.ibmPlexSerif(
                          //                             color: Colors.white,
                          //                             fontSize: 22,
                          //                             fontWeight: FontWeight.w600,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 // Spacer(),
                          //                 SizedBox(
                          //                   height: 5,
                          //                 ),
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     // setState.call(() {
                          //                     //   if (imgsUpload.length > 1) {
                          //                     //     imgsUpload.removeAt(index);
                          //                     //   }
                          //                     // });
                          //                   },
                          //                   child: Center(
                          //                     child: Container(
                          //                       height: 40,
                          //                       width: 40,
                          //                       padding: EdgeInsets.all(4),
                          //                       decoration: BoxDecoration(
                          //                           color: Color(0xFFE61D2B),
                          //                           shape: BoxShape.circle),
                          //                       child: Center(
                          //                         child: Text(
                          //                           "x",
                          //                           style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontSize: 18,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //     separatorBuilder: (context, index) => SizedBox(
                          //           height: 10,
                          //         ),
                          //     itemCount: imgsUpload.length),
                          Container(
                            height: 90,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                firstProvider.dpsImage();
                              },
                              child: Column(
                                children: [
                                  firstProvider.dps == null
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
                                          child: Image.file(firstProvider.dps!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      firstProvider.dps == null
                                          ? 'Upload Image'
                                          : firstProvider.dpsname,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: firstProvider.dps2,
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
                if (selectedOption!.isEmpty || firstProvider.dps == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("first1")) {
                  dpsUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else if (selectedOption!.contains("first2")) {
                  dpsNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else {
                  dpsCustom(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
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

  Column seocndColumn(double width, BuildContext context) {
    var secondProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          second[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(second[0].imageLink!)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 'second1',
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
                        // _getImage();
                        secondProvider.coolerImage();
                      },
                      child: Column(
                        children: [
                          secondProvider.cooler == null
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
                                  child: Image.file(secondProvider.cooler!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              secondProvider.cooler == null
                                  ? 'Upload Image'
                                  : secondProvider.coolername,
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
                          controller: secondProvider.cooler1,
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
                            // _getImage();
                            secondProvider.coolerImage();
                          },
                          child: Column(
                            children: [
                              secondProvider.cooler == null
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
                                      child: Image.file(secondProvider.cooler!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  secondProvider.cooler == null
                                      ? 'Upload Image'
                                      : secondProvider.coolername,
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
                          Container(
                            height: 90,
                            width: width / 1.1,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                secondProvider.coolerImage();
                              },
                              child: Column(
                                children: [
                                  secondProvider.cooler == null
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
                                          child: Image.file(secondProvider.cooler!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      secondProvider.cooler == null
                                          ? 'Upload Image'
                                          : secondProvider.coolername,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: secondProvider.cooler2,
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
                if (selectedOption!.isEmpty || secondProvider.cooler == null) {
                  setState(() {
                    Fluttertoast.showToast(msg: "select one option");
                  });
                } else if (selectedOption!.contains("second1")) {
                  coolerUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else if (selectedOption!.contains("second2")) {
                  coolerNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else {
                  coolerCustom(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
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
    var thirdProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          third[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(third[0].imageLink!)),
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
                        // _getImage();
                        thirdProvider.standeeImage();
                      },
                      child: Column(
                        children: [
                          thirdProvider.standee == null
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
                                  child: Image.file(thirdProvider.standee!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              thirdProvider.standee == null
                                  ? 'Upload Image'
                                  : thirdProvider.standeename,
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
                          controller: thirdProvider.standee1,
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
                            // _getImage();
                            thirdProvider.standeeImage();
                          },
                          child: Column(
                            children: [
                              thirdProvider.standee == null
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
                                      child: Image.file(thirdProvider.standee!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  thirdProvider.standee == null
                                      ? 'Upload Image'
                                      : thirdProvider.standeename,
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
                          Container(
                            height: 90,
                            width: width / 1.1,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                thirdProvider.standeeImage();
                              },
                              child: Column(
                                children: [
                                  thirdProvider.standee == null
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
                                          child: Image.file(thirdProvider.standee!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      thirdProvider.standee == null
                                          ? 'Upload Image'
                                          : thirdProvider.standeename,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: thirdProvider.standee2,
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
                if (selectedOption!.isEmpty || thirdProvider.standee == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("third1")) {
                  // setAvailable();
                  standeeUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("third2")) {
                  // setNotAvailable();
                  standeeNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else {
                  // setCustom();
                  standeeCustom(context);
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
    var fourProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          four[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(four[0].imageLink!)),
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
                    '${four[0].title} available',
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
                        // _getImage();
                        fourProvider.verticalImage();
                      },
                      child: Column(
                        children: [
                          fourProvider.vertical == null
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
                                  child: Image.file(fourProvider.vertical!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              fourProvider.vertical == null
                                  ? 'Upload Image'
                                  : fourProvider.verticalname,
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
                          controller: fourProvider.vertical1,
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
                            // _getImage();
                            fourProvider.verticalImage();
                          },
                          child: Column(
                            children: [
                              fourProvider.vertical == null
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
                                      child: Image.file(fourProvider.vertical!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  fourProvider.vertical == null
                                      ? 'Upload Image'
                                      : fourProvider.verticalname,
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
                          Container(
                            height: 90,
                            width: width / 1.1,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                fourProvider.verticalImage();
                              },
                              child: Column(
                                children: [
                                  fourProvider.vertical == null
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
                                          child: Image.file(fourProvider.vertical!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      fourProvider.vertical == null
                                          ? 'Upload Image'
                                          : fourProvider.verticalname,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: fourProvider.vertical2,
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
                if (selectedOption!.isEmpty || fourProvider.vertical == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("four1")) {
                  // setAvailable();
                  verticalUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("four2")) {
                  // setNotAvailable();
                  verticalNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else {
                  // setCustom();
                  verticalCustom(context);
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

  Column fiveColumn(double width, BuildContext context) {
    var fiveProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          five[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(five[0].imageLink!)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "five1",
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
                    '${five[0].title} available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'five1'
                ? Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        // _getImage();
                        fiveProvider.onewayImage();
                      },
                      child: Column(
                        children: [
                          fiveProvider.oneway == null
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
                                  child: Image.file(fiveProvider.oneway!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              fiveProvider.oneway == null
                                  ? 'Upload Image'
                                  : fiveProvider.onewayname,
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
                  value: 'five2',
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
                    '${five[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'five2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: fiveProvider.oneway1,
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
                            // _getImage();
                            fiveProvider.onewayImage();
                          },
                          child: Column(
                            children: [
                              fiveProvider.oneway == null
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
                                      child: Image.file(fiveProvider.oneway!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  fiveProvider.oneway == null
                                      ? 'Upload Image'
                                      : fiveProvider.onewayname,
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
                  value: 'five3',
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
            selectedOption == 'five3'
                ? StatefulBuilder(
                    builder: (context, setState) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 90,
                            width: width / 1.1,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                fiveProvider.onewayImage();
                              },
                              child: Column(
                                children: [
                                  fiveProvider.oneway == null
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
                                          child: Image.file(fiveProvider.oneway!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      fiveProvider.oneway == null
                                          ? 'Upload Image'
                                          : fiveProvider.onewayname,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: fiveProvider.oneway2,
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
                if (selectedOption!.isEmpty || fiveProvider.oneway == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("five1")) {
                  // setAvailable();
                  onewayUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("five2")) {
                  // setNotAvailable();
                  onewayNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else {
                  // setCustom();
                  onewayCustom(context);
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

  Column sixColumn(double width, BuildContext context) {
    var sixProvider = Provider.of<PopulationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          six[0].title!,
          style: GoogleFonts.ibmPlexSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Center(child: Image.network(six[0].imageLink!)),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "six1",
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
                    '${six[0].title} available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'six1'
                ? Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        // _getImage();
                        sixProvider.vinylImage();
                      },
                      child: Column(
                        children: [
                          sixProvider.vinyl == null
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
                                  child: Image.file(sixProvider.vinyl!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              sixProvider.vinyl == null ? 'Upload Image' : sixProvider.vinylname,
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
                  value: 'six2',
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
                    '${six[0].title} not available',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Color(0xFF222B45),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            selectedOption == 'six2'
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLines: 2,
                          controller: sixProvider.vinyl1,
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
                            // _getImage();
                            sixProvider.vinylImage();
                          },
                          child: Column(
                            children: [
                              sixProvider.vinyl == null
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
                                      child: Image.file(sixProvider.vinyl!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  sixProvider.vinyl == null
                                      ? 'Upload Image'
                                      : sixProvider.vinylname,
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
                  value: 'six3',
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
            selectedOption == 'six3'
                ? StatefulBuilder(
                    builder: (context, setState) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 90,
                            width: width / 1,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                sixProvider.vinylImage();
                              },
                              child: Column(
                                children: [
                                  sixProvider.vinyl == null
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
                                          child: Image.file(sixProvider.vinyl!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      sixProvider.vinyl == null
                                          ? 'Upload Image'
                                          : sixProvider.vinylname,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 2,
                            controller: sixProvider.vinyl2,
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
                if (selectedOption!.isEmpty || sixProvider.vinyl == null) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("six1")) {
                  // setAvailable();
                  vinylUploadImage(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: TransactionScreen()));
                  // removeImage();
                } else if (selectedOption!.contains("six2")) {
                  // setNotAvailable();
                  vinylNotAvailable(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: TransactionScreen()));
                  // removeImage();
                  // remark1.clear();
                } else {
                  vinylCustom(context);
                  Navigator.pushReplacement(
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
