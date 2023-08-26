// import 'package:universal_io/io.dart';
import 'dart:io';
import 'package:coca_cola/shop_pic.dart';
import 'package:flutter/foundation.dart';
import 'package:coca_cola/provider/population_provider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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

    getData();
    controller = PageController(initialPage: _currentPage);
    controller2 = PageController(initialPage: _currentPage2);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tid = prefs.getString("tid").toString();
      flname = prefs.getString("flname").toString();
      print("tid in pop----------" + tid);
    });
    PopulationApi.getData("64c6cf53cfd3911994c43484", "1").then((value) {
      for (var i = 0; i < value!.data!.length; i++) {
        setState(() {
          title = value.data![0].title!;
          first.add(value.data![0].first!);
          second.add(value.data![0].second!);
          third.add(value.data![0].third!);
          four.add(value.data![0].four!);
          five.add(value.data![0].five!);
          six.add(value.data![0].six!);
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
    }).whenComplete(() async {
      // CoolerAvailable.setImage(cooleid!, provider.cooler!).then((value) {});

      setState(() {
        if (provider.coolerList != null) {
          //passing file bytes and file name for API call
          CoolerAvailable.setImage(cooleid!, provider.coolerList!.first.bytes!).then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  dpsUploadImage(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);

    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
      });
    }).whenComplete(() {
      //   DPsAvailable.setImage(dpsid!, provider.dps!).then((value) {
      //     print("image upload response---------" + value.toString());
      //   });
      // });

      setState(() {
        if (provider.dpsList != null) {
          //passing file bytes and file name for API call
          DPsAvailable.setImage(dpsid!, provider.dpsList!.first.bytes!).then((value) {
            print("dps res----" + value.toString());
          });
        }
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
    }).whenComplete(() async {
      // StandeeAvailable.setImage(standeeid!, provider.standee!).then((value) {
      //   // print("image upload response---------" + value.toString());
      // });

      setState(() {
        if (provider.standeeList != null) {
          //passing file bytes and file name for API call
          StandeeAvailable.setImage(standeeid!, provider.standeeList!.first.bytes!).then((value) {
            print("dps res----" + value['success'].toString());
          });
        }
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
    }).whenComplete(() async {
      // VerticalSignageAvailable.setImage(verticalid!, provider.vertical!).then((value) {
      //   // print("image upload response---------" + value.toString());
      // });

      setState(() {
        if (provider.verticalList != null) {
          //passing file bytes and file name for API call
          VerticalSignageAvailable.setImage(verticalid!, provider.verticalList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
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
    }).whenComplete(() async {
      // OnewayVisionAvailable.setImage(onewayid!, provider.oneway!).then((value) {
      //   // print("image upload response---------" + value.toString());
      // });

      setState(() {
        if (provider.onewayList != null) {
          //passing file bytes and file name for API call
          OnewayVisionAvailable.setImage(onewayid!, provider.onewayList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
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
    }).whenComplete(() async {
      // VVinylBrandingAvailable.setImage(vinylid!, provider.vinyl!).then((value) {
      //   // print("image upload response---------" + value.toString());
      // });
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        if (provider.vinylList != null) {
          //passing file bytes and file name for API call
          VVinylBrandingAvailable.setImage(vinylid!, provider.vinylList!.first.bytes!)
              .then((value) {
            print("dps res----" + value!.success!.toString());
            prefs.setBool("vinylUploadImage", value!.success!);
          });
        }
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
    }).whenComplete(() async {
      // CoolerNotAvailableApi.setImage(cooleid!, provider.cooler1.text, provider.cooler!);

      setState(() {
        if (provider.coolerList != null) {
          CoolerNotAvailableApi.setImage(
                  cooleid!, provider.cooler1.text, provider.coolerList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  dpsNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // DpsNotAvailable.setImage(dpsid!, provider.dps1.text, provider.dps!);

      setState(() {
        if (provider.dpsList != null) {
          //passing file bytes and file name for API call
          DpsNotAvailable.setImage(dpsid!, provider.dps1.text, provider.dpsList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  standeeNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    StandeeApi.getData(tid!).then((value) {
      setState(() {
        standeeid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // StandeeNotAvailable.setImage(standeeid!, provider.standee1.text, provider.standee!);

      setState(() {
        if (provider.standeeList != null) {
          //passing file bytes and file name for API call
          StandeeNotAvailable.setImage(
                  standeeid!, provider.standee1.text, provider.standeeList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  verticalNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VerticalSignageApi.getData(tid!).then((value) {
      setState(() {
        verticalid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // VerticalSignageNotAvailable.setImage(
      //     verticalid!, provider.vertical1.text, provider.vertical!);

      setState(() {
        if (provider.verticalList != null) {
          //passing file bytes and file name for API call
          VerticalSignageNotAvailable.setImage(
                  verticalid!, provider.vertical1.text, provider.verticalList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  onewayNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    OnewayApi.getData(tid!).then((value) {
      setState(() {
        onewayid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // OnewayVisionNotAvailable.setImage(onewayid!, provider.oneway1.text, provider.oneway!);

      setState(() {
        if (provider.onewayList != null) {
          //passing file bytes and file name for API call
          OnewayVisionNotAvailable.setImage(
                  onewayid!, provider.oneway1.text, provider.onewayList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  vinylNotAvailable(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VinylBrandingApi.getData(tid!).then((value) {
      setState(() {
        vinylid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // VinylBrandingNotAvailable.setImage(vinylid!, provider.vinyl1.text, provider.vinyl!);
      var prefs = await SharedPreferences.getInstance();

      setState(() {
        if (provider.vinylList != null) {
          //passing file bytes and file name for API call
          VinylBrandingNotAvailable.setImage(
                  vinylid!, provider.vinyl1.text, provider.vinylList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
            prefs.setBool("vinylNotAvailable", value!.success!);
          });
        }
      });
    });
  }

  coolerCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    CoolerApi.getData(tid!).then((value) {
      setState(() {
        cooleid = value!.id;
        // print("cooler----------" + value.id!);
      });
    }).whenComplete(() async {
      // CoolerCustom.setImage(cooleid!, provider.cooler2.text, provider.cooler!);

      setState(() {
        if (provider.coolerList != null) {
          //passing file bytes and file name for API call
          CoolerCustom.setImage(cooleid!, provider.cooler2.text, provider.coolerList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  standeeCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    StandeeApi.getData(tid!).then((value) {
      setState(() {
        standeeid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // StandeeCustom.setImage(standeeid!, provider.standee2.text, provider.standee!);

      setState(() {
        if (provider.standeeList != null) {
          //passing file bytes and file name for API call
          StandeeCustom.setImage(
                  standeeid!, provider.standee2.text, provider.standeeList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  dpsCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    DpsApi.getData(tid!).then((value) {
      setState(() {
        dpsid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // DpsCustom.setImage(dpsid!, provider.dps2.text, provider.dps!);

      setState(() {
        if (provider.dpsList != null) {
          //passing file bytes and file name for API call
          DpsCustom.setImage(dpsid!, provider.dps2.text, provider.dpsList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  verticalCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VerticalSignageApi.getData(tid!).then((value) {
      setState(() {
        verticalid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // VerticalSignageCustom.setImage(verticalid!, provider.vertical2.text, provider.vertical!);

      setState(() {
        if (provider.verticalList != null) {
          //passing file bytes and file name for API call
          VerticalSignageCustom.setImage(
                  verticalid!, provider.vertical2.text, provider.verticalList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  onewayCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    OnewayApi.getData(tid!).then((value) {
      setState(() {
        onewayid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // OnewayVisionCustom.setImage(onewayid!, provider.oneway2.text, provider.oneway!);

      setState(() {
        if (provider.onewayList != null) {
          //passing file bytes and file name for API call
          OnewayVisionCustom.setImage(
                  onewayid!, provider.oneway2.text, provider.onewayList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  vinylCustom(BuildContext context) {
    var provider = Provider.of<PopulationProvider>(context, listen: false);
    VinylBrandingApi.getData(tid!).then((value) {
      setState(() {
        vinylid = value!.id;
        // print("idddd----------" + value.id!);
      });
    }).whenComplete(() async {
      // VinylBrandingCustom.setImage(vinylid!, provider.vinyl2.text, provider.vinyl!);
      var prefs = await SharedPreferences.getInstance();

      setState(() {
        if (provider.vinylList != null) {
          //passing file bytes and file name for API call
          VinylBrandingCustom.setImage(
                  vinylid!, provider.vinyl2.text, provider.vinylList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
            prefs.setBool("vinylCustom", value!.success!);
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
                        firstProvider.dpsImage();
                      },
                      child: Column(
                        children: [
                          firstProvider.dpsList == null
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
                                  child: Image.memory(firstProvider.dpsList!.first.bytes!,
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
                              firstProvider.dpsList == null
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
                                      child: Image.memory(firstProvider.dpsList!.first.bytes!,
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
                            width: width / 1,
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
                                  firstProvider.dpsList == null
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
                                          child: Image.memory(firstProvider.dpsList!.first.bytes!,
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
                if (selectedOption!.isEmpty || firstProvider.dpsList == null) {
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
                          secondProvider.coolerList == null
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
                                  child: Image.memory(secondProvider.coolerList!.first.bytes!,
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
                              secondProvider.coolerList == null
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
                                      child: Image.memory(secondProvider.coolerList!.first.bytes!,
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
                            width: width / 1,
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
                                  secondProvider.coolerList == null
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
                                              secondProvider.coolerList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(msg: "select one option");
                  });
                } else if (selectedOption!.contains("second1") &&
                    secondProvider.coolerList!.isNotEmpty) {
                  coolerUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else if (selectedOption!.contains("second2") &&
                    secondProvider.cooler1.text.isNotEmpty) {
                  coolerNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                } else if (secondProvider.cooler1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("second3") &&
                    secondProvider.coolerList!.isNotEmpty &&
                    secondProvider.cooler2.text.isNotEmpty) {
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
                        thirdProvider.standeeImage();
                      },
                      child: Column(
                        children: [
                          thirdProvider.standeeList == null
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
                                  child: Image.memory(thirdProvider.standeeList!.first.bytes!,
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
                              thirdProvider.standeeList == null
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
                                      child: Image.memory(thirdProvider.standeeList!.first.bytes!,
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
                            width: width / 1,
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
                                  thirdProvider.standeeList == null
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
                                              thirdProvider.standeeList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("third1") &&
                    thirdProvider.standeeList!.isNotEmpty) {
                  // setAvailable();
                  standeeUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("third2") &&
                    thirdProvider.standee1.text.isNotEmpty) {
                  // setNotAvailable();
                  standeeNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else if (thirdProvider.standee1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("third3") &&
                    thirdProvider.standee2.text.isNotEmpty &&
                    thirdProvider.standeeList!.isNotEmpty) {
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
        Center(
            child: Image.network(
          four[0].imageLink!,
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
                          fourProvider.verticalList == null
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
                                  child: Image.memory(fourProvider.verticalList!.first.bytes!,
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
                              fourProvider.verticalList == null
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
                                      child: Image.memory(fourProvider.verticalList!.first.bytes!,
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
                            width: width / 1,
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
                                  fourProvider.verticalList == null
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
                                              fourProvider.verticalList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("four1") &&
                    fourProvider.verticalList!.isNotEmpty) {
                  // setAvailable();
                  verticalUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("four2") &&
                    fourProvider.vertical1.text.isNotEmpty) {
                  verticalNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else if (fourProvider.vertical1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("four3") &&
                    fourProvider.vertical2.text.isNotEmpty &&
                    fourProvider.verticalList!.isNotEmpty) {
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
        Center(
            child: Image.network(
          five[0].imageLink!,
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
                          fiveProvider.onewayList == null
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
                                  child: Image.memory(fiveProvider.onewayList!.first.bytes!,
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
                              fiveProvider.onewayList == null
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
                                      child: Image.memory(fiveProvider.onewayList!.first.bytes!,
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
                            width: width / 1,
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
                                  fiveProvider.onewayList == null
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
                                          child: Image.memory(fiveProvider.onewayList!.first.bytes!,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("five1") &&
                    fiveProvider.onewayList!.isNotEmpty) {
                  onewayUploadImage(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("five2") &&
                    fiveProvider.oneway1.text.isNotEmpty) {
                  // setNotAvailable();
                  onewayNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else if (fiveProvider.oneway1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("five3") &&
                    fiveProvider.onewayList!.isNotEmpty &&
                    fiveProvider.oneway2.text.isNotEmpty) {
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
        Center(
            child: Image.network(
          six[0].imageLink!,
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
                          sixProvider.vinylList == null
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
                                  child: Image.memory(sixProvider.vinylList!.first.bytes!,
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
                              sixProvider.vinylList == null
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
                                      child: Image.memory(sixProvider.vinylList!.first.bytes!,
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
                                  sixProvider.vinylList == null
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
                                          child: Image.memory(sixProvider.vinylList!.first.bytes!,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("six1") && sixProvider.vinylList!.isNotEmpty) {
                  // setAvailable();
                  vinylUploadImage(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
                  // removeImage();
                } else if (selectedOption!.contains("six2") && sixProvider.vinyl1.text.isNotEmpty) {
                  vinylNotAvailable(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
                } else if (sixProvider.vinyl1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("six3") &&
                    sixProvider.vinyl2.text.isNotEmpty &&
                    sixProvider.vinylList!.isNotEmpty) {
                  vinylCustom(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
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
