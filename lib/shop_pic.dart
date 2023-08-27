import 'package:coca_cola/apis/imagelink_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:coca_cola/incidence_screen.dart';
import 'package:coca_cola/population_screen.dart';
import 'package:coca_cola/price_communication_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/flag.dart';

class ShopPic extends StatefulWidget {
  ShopPic({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopPic> createState() => _ShopPicState();
}

class _ShopPicState extends State<ShopPic> {
  String text = "not clicked";
  String _selectedOption = '';
  String imglink = '';
  String imgId = "";
  String flname = "";
  String tid = "";
  String channel = "";
  bool? vinylCustom;
  bool? vinylNotAvail;
  bool? vinylAvail;
  bool? packAvail;
  bool? packNotAvail;
  bool? packCutsom;
  bool? aerialAvail;
  bool? aerialNotAvail;
  bool? aerialCustom;
  String aerialid = '';
  String packid = '';
  String vinylid = '';

  @override
  void initState() {
    super.initState();
    getId();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      flagNumber = 0;
    });

    setState(() {
      _selectedOption = "Population";
      tid = prefs.getString("tid").toString();
      channel = prefs.getString("channel").toString();
      flname = prefs.getString("flname").toString();
      aerialid = prefs.getString("aerialid" + tid).toString();
      packid = prefs.getString("packid" + tid).toString();
      vinylid = prefs.getString("vinylid" + tid).toString();
    });
    setState(() {
      vinylAvail = prefs.getBool("vinylUploadImage");
      vinylNotAvail = prefs.getBool("vinylNotAvailable");
      vinylCustom = prefs.getBool("vinylCustom");
      packAvail = prefs.getBool("packUploadImage");
      packNotAvail = prefs.getBool("packNotAvailable");
      packCutsom = prefs.getBool("packCustom");
      aerialAvail = prefs.getBool("aerialAvailable");
      aerialNotAvail = prefs.getBool("aerialNotAvailable");
      aerialCustom = prefs.getBool("arialCustom");
    });
    print("tid in pic----" + tid);
    print("tid in aerialid----" + aerialid);
    print("tid in vinylid----" + vinylid);
    print("tid in packid----" + packid);

    ImagelinkApi.getData(channel).then((value) {
      imgId = value!.data!.id!;
      imglink = value.data!.imageLink!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      // CustomBadge()
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Picture of Success",
                      style: GoogleFonts.ibmPlexSerif(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    flname,
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Please select to fill details",
                      style: GoogleFonts.ibmPlexSerif(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   padding: EdgeInsets.all(8),
                  //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Image.asset("assets/images/reddot.png"),
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Text(
                  //             '11/06/2023',
                  //             textAlign: TextAlign.center,
                  //             style: GoogleFonts.ibmPlexSerif(
                  //               color: Color(0xFF8F9BB3),
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 5,
                  //       ),
                  //       Text(
                  //         widget.priCustomerName!,
                  //         style: GoogleFonts.ibmPlexSerif(
                  //           color: Color(0xFF222B45),
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 5,
                  //       ),
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //             child: Text(
                  //               widget.address!,
                  //               style: GoogleFonts.ibmPlexSans(
                  //                 color: Color(0xFF8F9BB3),
                  //                 fontSize: 12.05,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //           // Spacer(),
                  //           Text(
                  //             widget.customerGccId!,
                  //             style: GoogleFonts.ibmPlexSans(
                  //               color: Color(0xFF8F9BB3),
                  //               fontSize: 12.05,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.network(
                    channel.isEmpty ? "NO IMAGE" : imglink,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.red,
                        value: 'Population',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('Population'),
                      vinylid == tid
                          ? vinylAvail == true || vinylNotAvail == true || vinylCustom == true
                              ? Icon(
                                  Icons.done_outline_rounded,
                                  color: Colors.green,
                                )
                              : Container()
                          : Container()
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.red,
                        value: 'Incidence',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('Incidence'),
                      aerialid == tid
                          ? aerialAvail == true || aerialNotAvail == true || aerialCustom == true
                              ? Icon(
                                  Icons.done_outline_rounded,
                                  color: Colors.green,
                                )
                              : Container()
                          : Container()
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.red,
                        value: 'Price Communication',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('Price Communication'),
                      packid == tid
                          ? packAvail == true || packNotAvail == true || packCutsom == true
                              ? Icon(
                                  Icons.done_outline_rounded,
                                  color: Colors.green,
                                )
                              : Container()
                          : Container()
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Radio(
                  //       activeColor: Colors.red,
                  //       value: 'Bonus',
                  //       groupValue: _selectedOption,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _selectedOption = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Bonus'),
                  //   ],
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_selectedOption == "Population") {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.decelerate,
                                duration: Duration(seconds: 1),
                                child: PopulationScreen(
                                  tid: tid,
                                )));
                      } else if (_selectedOption == "Incidence") {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.decelerate,
                                duration: Duration(seconds: 1),
                                child: IncidenceScreen(
                                  tid: tid,
                                )));
                      } else if (_selectedOption == "Price Communication") {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.decelerate,
                                duration: Duration(seconds: 1),
                                child: PriceCommunicationScreen(
                                  tid: tid,
                                )));
                      }
                      // else {
                      //   Navigator.push(
                      //       context,
                      //       PageTransition(
                      //           type: PageTransitionType.fade,
                      //           curve: Curves.decelerate,
                      //           duration: Duration(seconds: 1),
                      //           child: BonusScreen()));
                      // }
                    },
                    child: Center(
                      child: Container(
                        width: 240,
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
            ),
          ),
        ),
      ),
    );
  }
}
