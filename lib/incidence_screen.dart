// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:coca_cola/shop_pic.dart';
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

import 'package:coca_cola/apis/incindence%20apis/grocery_rack_not_available.dart';
import 'package:coca_cola/apis/incindence%20apis/grocery_rack_upload_img.dart';
import 'package:coca_cola/provider/incidence_provider.dart';
import 'package:coca_cola/transaction_screen.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'apis/bonus/ambient_api.dart';
import 'apis/bonus/ambient_available.dart';
import 'apis/bonus/ambient_custom.dart';
import 'apis/bonus/counter_available.dart';
import 'apis/bonus/counter_custom.dart';
import 'apis/bonus/counter_not_availble.dart';
import 'apis/bonus/counting_api.dart';
import 'apis/incidence_api.dart';
import 'apis/incindence apis/aerial_hanger.dart';
import 'apis/incindence apis/aerial_hanger_available.dart';
import 'apis/incindence apis/aerial_hanger_custom.dart';
import 'apis/incindence apis/aerial_hanger_not_available.dart';
import 'apis/incindence apis/ambient_rack_avaliable.dart';
import 'apis/incindence apis/ambient_rack_custom.dart';
import 'apis/incindence apis/ambient_rack_not_available.dart';
import 'apis/incindence apis/counter_top_available.dart';
import 'apis/incindence apis/counter_top_custom.dart';
import 'apis/incindence apis/counter_top_not_available.dart';
import 'apis/incindence apis/grocery_rack.dart';
import 'apis/incindence apis/grocery_rack_custom.dart';
import 'model/incidence_model.dart';

class IncidenceScreen extends StatefulWidget {
  String? tid;
  IncidenceScreen({
    Key? key,
    this.tid,
  }) : super(key: key);

  @override
  State<IncidenceScreen> createState() => _IncidenceScreenState();
}

class _IncidenceScreenState extends State<IncidenceScreen> {
  // TextEditingController first1 = TextEditingController();
  // TextEditingController first2 = TextEditingController();
  // TextEditingController second1 = TextEditingController();
  // TextEditingController second2 = TextEditingController();
  // TextEditingController third1 = TextEditingController();
  // TextEditingController third2 = TextEditingController();
  // TextEditingController four1 = TextEditingController();
  // TextEditingController four2 = TextEditingController();
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
  List<Widget> imgsUpload = [];
  // List gorceryList = [];
  // XFile? imagesss;
  // File? _image;
  String imgName = '';
  String groceryid = '';
  String ambinetid = '';
  String counterid = '';
  String aerialid = '';
  String tid = '';
  String flname = '';
  @override
  void initState() {
    controller = PageController(initialPage: _currentPage);
    getData();
    super.initState();
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

  // Future _getListImg() async {
  //   imagesss = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (imagesss != null) {
  //     setState(() {
  //       _pickedImages.add(imagesss!);
  //     });
  //   }
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
      print("tid----------" + tid);
    });
    IncidenceApi.getData("64c6cf53cfd3911994c43484", "2").then((value) {
      print("incedence data---" + value!.data.toString());
      for (var i = 0; i < value.data!.length; i++) {
        setState(() {
          title = value.data![i].title!;
          first.add(value.data![i].first!);
          second.add(value.data![i].second!);
          third.add(value.data![i].third!);
          four.add(value.data![i].four!);
        });
      }
    });
  }

  groceryCustom(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    Grocaryrackpi.getData(tid!).then((value) {
      setState(() {
        groceryid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // GroceryRackCustom.setImage(groceryid, provider.grocery2.text, provider.grocery!)
      //     .then((value) {
      //   print("custom res----" + value.toString());
      // });
      setState(() {
        if (provider.groceryList != null) {
          //passing file bytes and file name for API call
          GroceryRackCustom.setImage(
                  groceryid!, provider.grocery2.text, provider.groceryList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  ambientCustom(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AmbientApi.getData(tid!).then((value) {
      setState(() {
        ambinetid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // AmbientCustom.setImage(ambinetid, provider.ambient2.text, provider.ambient!).then((value) {
      //   print("custom res----" + value.toString());
      // });
      setState(() {
        if (provider.ambientList != null) {
          //passing file bytes and file name for API call
          AmbientRackCustom.setImage(
                  ambinetid!, provider.ambient2.text, provider.ambientList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  counterCustom(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    CounterApi.getData(tid!).then((value) {
      setState(() {
        counterid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // CounterCustom.setImage(counterid, provider.counter2.text, provider.counter!).then((value) {
      //   print("custom res----" + value.toString());
      // });
      setState(() {
        if (provider.counterList != null) {
          //passing file bytes and file name for API call
          CounterTopCustom.setImage(
                  counterid!, provider.counter2.text, provider.counterList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  arialCustom(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AerialHanger.getData(tid!).then((value) {
      setState(() {
        aerialid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() async {
      // AerialHangerCustom.setImage(aerialid, provider.arial2.text, provider.arial!).then((value) {
      //   print("custom res----" + value.toString());
      // });
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        if (provider.arialList != null) {
          //passing file bytes and file name for API call
          AerialHangerCustom.setImage(
                  aerialid!, provider.arial2.text, provider.arialList!.first.bytes!)
              .then((value) {
            print("areal res----" + value!.success!.toString());
            prefs.setBool("arialCustom", value!.success!);
          });
        }
      });
    });
  }

  ambientAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AmbientApi.getData(tid!).then((value) {
      setState(() {
        ambinetid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // AmbientAvailable.setImage(ambinetid, provider.ambient!).then((value) {
      //   print("avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.ambientList != null) {
          //passing file bytes and file name for API call
          AmbientRackAvailable.setImage(ambinetid!, provider.ambientList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  groceryAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    Grocaryrackpi.getData(tid!).then((value) {
      setState(() {
        groceryid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // GroceryRackUploadImg.setImage(groceryid, provider.grocery!).then((value) {
      //   print("avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.groceryList != null) {
          //passing file bytes and file name for API call
          GroceryRackUploadImg.setImage(groceryid!, provider.groceryList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  counterAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    CounterApi.getData(tid!).then((value) {
      setState(() {
        counterid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // CounterAvailable.setImage(counterid, provider.counter!).then((value) {
      //   print("avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.counterList != null) {
          //passing file bytes and file name for API call
          CounterTopAvailable.setImage(counterid!, provider.counterList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  aerialAvailable(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AerialHanger.getData(tid!).then((value) {
      setState(() {
        aerialid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // AerialHangerAvailable.setImage(aerialid, provider.arial!).then((value) {
      //   print("avauilable res----" + value.toString());
      // });

      if (provider.arialList != null) {
        //passing file bytes and file name for API call
        AerialHangerAvailable.setImage(aerialid!, provider.arialList!.first.bytes!).then((value) {
          print("areal res----" + value!.success!.toString());
          prefs.setBool("aerialAvailable", value!.success!);
        });
      }
    });
  }

  groceryNotAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    Grocaryrackpi.getData(tid!).then((value) {
      setState(() {
        groceryid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // GroceryRackNotAvailable.setImage(groceryid, provider.grocery1.text, provider.grocery!)
      //     .then((value) {
      //   print("not avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.groceryList != null) {
          //passing file bytes and file name for API call
          GroceryRackNotAvailable.setImage(
                  groceryid!, provider.grocery1.text, provider.groceryList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  ambientNotAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AmbientApi.getData(tid!).then((value) {
      setState(() {
        ambinetid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // AmbientRackNotAvailable.setImage(ambinetid, provider.ambient1.text, provider.ambient!)
      //     .then((value) {
      //   print("not avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.ambientList != null) {
          //passing file bytes and file name for API call
          AmbientRackNotAvailable.setImage(
                  ambinetid!, provider.ambient1.text, provider.ambientList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  counterNotAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    CounterApi.getData(tid!).then((value) {
      setState(() {
        counterid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() {
      // CounterNotAvailable.setImage(counterid, provider.counter1.text, provider.counter!)
      //     .then((value) {
      //   print("not avauilable res----" + value.toString());
      // });
      setState(() {
        if (provider.counterList != null) {
          //passing file bytes and file name for API call
          CounterTopNotAvailable.setImage(
                  counterid!, provider.counter1.text, provider.counterList!.first.bytes!)
              .then((value) {
            print("dps res----" + value.toString());
          });
        }
      });
    });
  }

  aerialNotAvailable(BuildContext context) {
    var provider = Provider.of<IncidenceProvider>(context, listen: false);
    AerialHanger.getData(tid!).then((value) {
      setState(() {
        aerialid = value!.id!;
      });
      // print("grocary id -------" + pid);
    }).whenComplete(() async {
      // AerialHangerNotAvailable.setImage(aerialid, provider.arial1.text, provider.arial!)
      //     .then((value) {
      //   print("not avauilable res----" + value.toString());
      // });
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        if (provider.counterList != null) {
          //passing file bytes and file name for API call
          AerialHangerNotAvailable.setImage(
                  aerialid!, provider.arial1.text, provider.arialList!.first.bytes!)
              .then((value) {
            print("areal res----" + value!.success!.toString());
            prefs.setBool("aerialNotAvailable", value!.success!);
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

  // Container uploadImage(double width) {
  //   var firstProvider = Provider.of<IncidenceProvider>(context);
  //   return Container(
  //     height: 90,
  //     width: width / 1.4,
  //     // margin: EdgeInsets.symmetric(horizontal: 10),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
  //     child: InkWell(
  //       onTap: () {
  //         // _getImage();
  //         firstProvider.groceryImage();
  //       },
  //       child: Column(
  //         children: [
  //           firstProvider.grocery == null
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
  //                   child: Image.file(firstProvider.grocery!, fit: BoxFit.fill, height: 50, width: 50),
  //                 ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Expanded(
  //             child: Text(
  //               firstProvider.grocery == null ? 'Upload Image' : firstProvider.groceryname,
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
    var firstProvider = Provider.of<IncidenceProvider>(context);
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
                        firstProvider.groceryImage();
                      },
                      child: Column(
                        children: [
                          firstProvider.groceryList == null
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
                                  child: Image.memory(firstProvider.groceryList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              firstProvider.groceryList == null ? 'Upload Image' : imgName,
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
                          controller: firstProvider.grocery1,
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
                            firstProvider.groceryImage();
                          },
                          child: Column(
                            children: [
                              firstProvider.groceryList == null
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
                                      child: Image.memory(firstProvider.groceryList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  firstProvider.groceryList == null ? 'Upload Image' : imgName,
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
                            width: width,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                firstProvider.groceryImage();
                              },
                              child: Column(
                                children: [
                                  firstProvider.groceryList == null
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
                                              firstProvider.groceryList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      firstProvider.grocery == null
                                          ? 'Upload Image'
                                          : firstProvider.groceryname,
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
                            controller: firstProvider.grocery2,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("first1") &&
                    firstProvider.groceryList!.isNotEmpty) {
                  // setAvailable();
                  groceryAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("first2") &&
                    firstProvider.grocery1.text.isNotEmpty) {
                  // setNotAvailable();
                  groceryNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // first1.clear();
                } else if (firstProvider.grocery1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("first3") &&
                    firstProvider.groceryList!.isNotEmpty &&
                    firstProvider.grocery2.text.isNotEmpty) {
                  // setCustom();
                  groceryCustom(context);
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
    var secondProvider = Provider.of<IncidenceProvider>(context);
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
                        secondProvider.ambientImage();
                      },
                      child: Column(
                        children: [
                          secondProvider.ambientList == null
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
                                  child: Image.memory(secondProvider.ambientList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              secondProvider.ambient == null
                                  ? 'Upload Image'
                                  : secondProvider.ambientname,
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
                          controller: secondProvider.ambient1,
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
                            secondProvider.ambientImage();
                          },
                          child: Column(
                            children: [
                              secondProvider.ambientList == null
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
                                      child: Image.memory(secondProvider.ambientList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  secondProvider.ambient == null
                                      ? 'Upload Image'
                                      : secondProvider.ambientname,
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
                            width: width,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                secondProvider.ambientImage();
                              },
                              child: Column(
                                children: [
                                  secondProvider.ambientList == null
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
                                              secondProvider.ambientList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      secondProvider.ambient == null
                                          ? 'Upload Image'
                                          : secondProvider.ambientname,
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
                            controller: secondProvider.ambient2,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("second1") &&
                    secondProvider.ambientList!.isNotEmpty) {
                  // setAvailable();
                  ambientAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("second2") &&
                    secondProvider.ambient1.text.isNotEmpty) {
                  // setNotAvailable();
                  ambientNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // second1.clear();
                } else if (secondProvider.ambient1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("second3") &&
                    secondProvider.ambientList!.isNotEmpty &&
                    secondProvider.ambient2.text.isNotEmpty) {
                  // setCustom();
                  ambientCustom(context);
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
    var thirdProvider = Provider.of<IncidenceProvider>(context);
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
                        thirdProvider.counterImage();
                      },
                      child: Column(
                        children: [
                          thirdProvider.counterList == null
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
                                  child: Image.memory(thirdProvider.counterList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              thirdProvider.counter == null
                                  ? 'Upload Image'
                                  : thirdProvider.countername,
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
                          controller: thirdProvider.counter1,
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
                            thirdProvider.counterImage();
                          },
                          child: Column(
                            children: [
                              thirdProvider.counterList == null
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
                                      child: Image.memory(thirdProvider.counterList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  thirdProvider.counter == null
                                      ? 'Upload Image'
                                      : thirdProvider.countername,
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
                            width: width,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                thirdProvider.counterImage();
                              },
                              child: Column(
                                children: [
                                  thirdProvider.counterList == null
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
                                              thirdProvider.counterList!.first.bytes!,
                                              fit: BoxFit.fill,
                                              height: 50,
                                              width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      thirdProvider.counter == null
                                          ? 'Upload Image'
                                          : thirdProvider.countername,
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
                            controller: thirdProvider.counter2,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("third1") &&
                    thirdProvider.counterList!.isNotEmpty) {
                  // setAvailable();
                  counterAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                } else if (selectedOption!.contains("third2") &&
                    thirdProvider.counter1.text.isNotEmpty) {
                  // setNotAvailable();
                  counterNotAvailable(context);
                  controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  // removeImage();
                  // third1.clear();
                } else if (thirdProvider.counter1.text.isEmpty) {
                } else if (selectedOption!.contains("third3") &&
                    thirdProvider.counterList!.isNotEmpty &&
                    thirdProvider.counter2.text.isNotEmpty) {
                  // setCustom();
                  counterCustom(context);
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
    var fourProvider = Provider.of<IncidenceProvider>(context);
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
                        fourProvider.arialImage();
                      },
                      child: Column(
                        children: [
                          fourProvider.arialList == null
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
                                  child: Image.memory(fourProvider.arialList!.first.bytes!,
                                      fit: BoxFit.fill, height: 50, width: 50),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              fourProvider.arial == null ? 'Upload Image' : fourProvider.arialname,
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
                          controller: fourProvider.arial1,
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
                            fourProvider.arialImage();
                          },
                          child: Column(
                            children: [
                              fourProvider.arialList == null
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
                                      child: Image.memory(fourProvider.arialList!.first.bytes!,
                                          fit: BoxFit.fill, height: 50, width: 50),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  fourProvider.arial == null
                                      ? 'Upload Image'
                                      : fourProvider.arialname,
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
                            width: width,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                // _getImage();
                                fourProvider.arialImage();
                              },
                              child: Column(
                                children: [
                                  fourProvider.arialList == null
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
                                          child: Image.memory(fourProvider.arialList!.first.bytes!,
                                              fit: BoxFit.fill, height: 50, width: 50),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      fourProvider.arial == null
                                          ? 'Upload Image'
                                          : fourProvider.arialname,
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
                            controller: fourProvider.arial2,
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
                if (selectedOption!.isEmpty) {
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "select one option",
                    );
                  });
                } else if (selectedOption!.contains("four1") &&
                    fourProvider.arialList!.isNotEmpty) {
                  // setAvailable();
                  aerialAvailable(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
                } else if (selectedOption!.contains("four2") &&
                    fourProvider.arial1.text.isNotEmpty) {
                  // setNotAvailable();
                  aerialNotAvailable(context);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
                } else if (fourProvider.arial1.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "enter remark",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else if (selectedOption!.contains("four3") &&
                    fourProvider.arialList!.isNotEmpty &&
                    fourProvider.arial2.text.isNotEmpty) {
                  // setCustom();
                  arialCustom(context);
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
