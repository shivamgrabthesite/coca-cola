// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

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

import 'package:coca_cola/provider/price_provider.dart';
import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'apis/population apis/cooler_available.dart';
import 'apis/price apis/brand_available.dart';
import 'apis/price apis/brand_custom.dart';
import 'apis/price apis/brand_not_available.dart';
import 'apis/price apis/brand_strip_api.dart';
import 'apis/price apis/pack_available.dart';
import 'apis/price apis/pack_custom.dart';
import 'apis/price apis/pack_cutout_api.dart';
import 'apis/price apis/pack_not_availble.dart';
import 'apis/price apis/price_custom.dart';
import 'apis/price apis/price_strip_api.dart';
import 'apis/price apis/price_strip_available.dart';
import 'apis/price apis/price_strip_not_available.dart';
import 'apis/price_communication_api.dart';
import 'constant/flag.dart';
import 'model/price_communication_model.dart';

class PriceCommunicationScreen extends StatefulWidget {
  String? tid;
  PriceCommunicationScreen({
    Key? key,
    this.tid,
  }) : super(key: key);

  @override
  State<PriceCommunicationScreen> createState() => _PriceCommunicationScreenState();
}

class _PriceCommunicationScreenState extends State<PriceCommunicationScreen> {
  // TextEditingController first1 = TextEditingController();
  // TextEditingController first2 = TextEditingController();
  // TextEditingController second1 = TextEditingController();
  // TextEditingController second2 = TextEditingController();
  // TextEditingController third1 = TextEditingController();
  // TextEditingController third2 = TextEditingController();
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

  // List<Widget> imgsUpload = [];
  // File? _image;
  // String imgName = '';
  String brandid = '', priceid = '', packid = '';
  String tid = '';
  String flname = '';
  @override
  void initState() {
    getData();
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

  // Future _getImage() async {
  //   var image = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //   );
  //   imgName = image!.name;

  //   setState(() {
  //     if (image != null) {
  //       _image = File(image.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tid = prefs.getString("tid").toString();
    flname = prefs.getString("flname").toString();
    print("tid----------" + tid);
    PriceCommunicationApi.getData("64c6cf53cfd3911994c43484", "3").then((value) {
      for (var i = 0; i < value!.data!.length; i++) {
        setState(() {
          title = value.data![i].title!;
          first.add(value.data![i].first!);
          second.add(value.data![i].second!);
          third.add(value.data![i].third!);
        });
      }
    });
  }

  brandUploadImage(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    BrandStripApi.getData(tid!).then((value) {
      setState(() {
        brandid = value!.id!;
      });
    }).whenComplete(() {
      // BrandAvailable.setImage(brandid!, provider.brand!).then((value) {
      //   print("image upload response---------" + value.toString());
      // });
      setState(() {
        if (provider.brandList != null) {
          //passing file bytes and file name for API call
          BrandAvailable.setImage(brandid!, provider.brandList!.first.bytes!).then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  priceUploadImage(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PriceStripApi.getData(tid!).then((value) {
      setState(() {
        priceid = value!.id!;
      });
    }).whenComplete(() {
      // PriceStripAvailable.setImage(priceid!, provider.price!).then((value) {
      //   print("image upload response---------" + value.toString());
      // });
      setState(() {
        if (provider.priceList != null) {
          //passing file bytes and file name for API call
          PriceStripAvailable.setImage(priceid!, provider.priceList!.first.bytes!).then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  packUploadImage(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PackCutoutApi.getData(tid!).then((value) {
      setState(() {
        packid = value!.id!;

        print("packid-----" + packid);
      });
      prefs.setString("packid", value!.tid!);
    }).whenComplete(() {
      setState(() {
        flagNumber = 1;
        if (provider.packList != null) {
          PackAvailable.setImage(packid!, provider.packList!.first.bytes!).then((value) {
            print("packk res----" + value['success'].toString());
          });
        }
      });
    });
  }

  brandNotAvailable(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    BrandStripApi.getData(tid!).then((value) {
      setState(() {
        brandid = value!.id!;
      });
    }).whenComplete(() {
      // BrandNotAvailable.setImage(brandid!, provider.brand1.text, provider.brand!);
      setState(() {
        if (provider.brandList != null) {
          //passing file bytes and file name for API call
          BrandNotAvailable.setImage(
                  brandid!, provider.brand1.text, provider.brandList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  priceNotAvailable(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PriceStripApi.getData(tid!).then((value) {
      setState(() {
        priceid = value!.id!;
      });
    }).whenComplete(() {
      // PriceStripNotAvailable.setImage(priceid!, provider.price1.text, provider.price!);
      setState(() {
        if (provider.priceList != null) {
          //passing file bytes and file name for API call
          PriceStripNotAvailable.setImage(
                  priceid!, provider.price1.text, provider.priceList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  packNotAvailable(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PackCutoutApi.getData(tid!).then((value) {
      setState(() {
        packid = value!.id!;
      });
      prefs.setString("packid", value!.tid!);
    }).whenComplete(() {
      setState(() {
        flagNumber = 1;
        if (provider.brandList != null) {
          //passing file bytes and file name for API call
          PackNotAvailable.setImage(packid!, provider.pack1.text, provider.packList!.first.bytes!)
              .then((value) {
            print("packk res----" + value!.success!.toString());
          });
        }
      });
    });
  }

  brandCustom(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    BrandStripApi.getData(tid!).then((value) {
      setState(() {
        brandid = value!.id!;
        print("brand custom------" + brandid);
      });
    }).whenComplete(() {
      // BrandCustom.setImage(brandid!, provider.brand2.text, provider.brand!);
      setState(() {
        if (provider.brandList != null) {
          //passing file bytes and file name for API call
          BrandCustom.setImage(brandid!, provider.brand2.text, provider.brandList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  priceCustom(BuildContext context) {
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PriceStripApi.getData(tid!).then((value) {
      setState(() {
        priceid = value!.id!;
      });
    }).whenComplete(() {
      // PriceStripCustom.setImage(priceid, provider.price2.text, provider.price!);
      setState(() {
        if (provider.priceList != null) {
          //passing file bytes and file name for API call
          PriceStripCustom.setImage(
                  priceid!, provider.price2.text, provider.priceList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  packCustom(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var provider = Provider.of<PriceProvider>(context, listen: false);
    PackCutoutApi.getData(tid!).then((value) {
      setState(() {
        packid = value!.id!;
      });
      prefs.setString("packid", value!.tid!);
    }).whenComplete(() {
      setState(() {
        flagNumber = 1;
        if (provider.packList != null) {
          //passing file bytes and file name for API call
          PackCustom.setImage(packid!, provider.pack2.text, provider.packList!.first.bytes!)
              .then((value) {
            print("packk res----" + value!.success!.toString());
          });
        }
      });
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
                    // // Align(alignment: Alignment.center, child: CustomBadge()),
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
    var firstProvider = Provider.of<PriceProvider>(context);
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
        Center(
            child: Image.network(
          first[0].imageLink!,
          height: 200,
          width: 200,
        )),
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
                        firstProvider.brandImage();
                      },
                      child: Column(
                        children: [
                          firstProvider.brandList == null
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
                                  child: Image.memory(firstProvider.brandList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              firstProvider.brand == null
                                  ? 'Upload Image'
                                  : firstProvider.brandname,
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
                          controller: firstProvider.brand1,
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
                            firstProvider.brandImage();
                          },
                          child: Column(
                            children: [
                              firstProvider.brandList == null
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
                                      child: Image.memory(firstProvider.brandList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  firstProvider.brand == null
                                      ? 'Upload Image'
                                      : firstProvider.brandname,
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
                          Container(
                            height: 90,
                            width: width / 1,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                firstProvider.brandImage();
                              },
                              child: Column(
                                children: [
                                  firstProvider.brandList == null
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
                                          child: Image.memory(firstProvider.brandList!.first.bytes!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      firstProvider.brand == null
                                          ? 'Upload Image'
                                          : firstProvider.brandname,
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
                            controller: firstProvider.brand2,
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
                if (selectedOption == null) {
                  Fluttertoast.showToast(
                    msg: "select one option",
                  );
                } else if (selectedOption!.contains("first1")) {
                  if (firstProvider.brandList != null) {
                    brandUploadImage(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("first2")) {
                  if (firstProvider.brand1.text.isNotEmpty) {
                    brandNotAvailable(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("first3")) {
                  if (firstProvider.brand2.text.isNotEmpty && firstProvider.brandList != null) {
                    brandCustom(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark and image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
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
    var secondProvider = Provider.of<PriceProvider>(context);
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
        Center(
            child: Image.network(
          second[0].imageLink!,
          height: 200,
          width: 200,
        )),
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
                        // _getImage();
                        secondProvider.priceImage();
                      },
                      child: Column(
                        children: [
                          secondProvider.priceList == null
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
                                  child: Image.memory(secondProvider.priceList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              secondProvider.price == null
                                  ? 'Upload Image'
                                  : secondProvider.pricename,
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
                          controller: secondProvider.price1,
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
                            secondProvider.priceImage();
                          },
                          child: Column(
                            children: [
                              secondProvider.priceList == null
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
                                      child: Image.memory(secondProvider.priceList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  secondProvider.price == null
                                      ? 'Upload Image'
                                      : secondProvider.pricename,
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
                            width: width / 1,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                secondProvider.priceImage();
                              },
                              child: Column(
                                children: [
                                  secondProvider.priceList == null
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
                                          child: Image.memory(
                                              secondProvider.priceList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      secondProvider.price == null
                                          ? 'Upload Image'
                                          : secondProvider.pricename,
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
                            controller: secondProvider.price2,
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
                if (selectedOption == null) {
                  Fluttertoast.showToast(
                    msg: "select one option",
                  );
                } else if (selectedOption!.contains("second1")) {
                  if (secondProvider.priceList != null) {
                    priceUploadImage(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("second2")) {
                  if (secondProvider.price1.text.isNotEmpty) {
                    priceNotAvailable(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("second3")) {
                  if (secondProvider.priceList != null && secondProvider.price2.text.isNotEmpty) {
                    priceCustom(context);
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark and image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
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
    var thirdProvider = Provider.of<PriceProvider>(context);
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
        Center(
            child: Image.network(
          third[0].imageLink!,
          height: 200,
          width: 200,
        )),
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
                        thirdProvider.packImage();
                      },
                      child: Column(
                        children: [
                          thirdProvider.packList == null
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
                                  child: Image.memory(thirdProvider.packList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              thirdProvider.pack == null ? 'Upload Image' : thirdProvider.packname,
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
                          controller: thirdProvider.pack1,
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
                            thirdProvider.packImage();
                          },
                          child: Column(
                            children: [
                              thirdProvider.packList == null
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
                                      child: Image.memory(thirdProvider.packList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  thirdProvider.pack == null
                                      ? 'Upload Image'
                                      : thirdProvider.packname,
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
                            width: width / 1,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                thirdProvider.packImage();
                              },
                              child: Column(
                                children: [
                                  thirdProvider.packList == null
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
                                          child: Image.memory(thirdProvider.packList!.first.bytes!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      thirdProvider.pack == null
                                          ? 'Upload Image'
                                          : thirdProvider.packname,
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
                            controller: thirdProvider.pack2,
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
                if (selectedOption == null) {
                  Fluttertoast.showToast(
                    msg: "select one option",
                  );
                } else if (selectedOption!.contains("third1")) {
                  if (thirdProvider.packList != null) {
                    packUploadImage(context);
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: TransactionScreen()));
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("third2")) {
                  if (thirdProvider.pack1.text.isNotEmpty) {
                    packNotAvailable(context);
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: TransactionScreen()));
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                } else if (selectedOption!.contains("third3")) {
                  if (thirdProvider.packList != null && thirdProvider.pack2.text.isNotEmpty) {
                    packCustom(context);
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            curve: Curves.decelerate,
                            duration: Duration(seconds: 1),
                            child: TransactionScreen()));
                  } else {
                    Fluttertoast.showToast(
                      msg: "enter remark and image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
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
