import 'package:coca_cola/constant/flag.dart';
import 'package:coca_cola/shop_pic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/outlet_detail_api.dart';
import 'apis/task_api.dart';

class OutletDetail extends StatefulWidget {
  // String id = '';
  OutletDetail({
    Key? key,
    // required this.id,
  }) : super(key: key);

  @override
  State<OutletDetail> createState() => _OutletDetailState();
}

class _OutletDetailState extends State<OutletDetail> {
  String MGRName = '',
      mgr_contect_no = '',
      channel = '',
      red_ol_class = '',
      cooler = '',
      outlet_name = '',
      ring_of_magic_area = '',
      gcc_code = '';
  String flname = '';
  String uidtoken = '', oidtoken = '';
  String tid = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setTask() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      flagNumber = 0;
      uidtoken = prefs.getString("uidtoken").toString();
      oidtoken = prefs.getString("oidtoken").toString();
    });
    print("uidtoken----" + uidtoken);
    print("oidtoken----" + oidtoken);

    TaskApi.getData(uidtoken, oidtoken).then((value) {
      tid = value!.data!.id.toString();
      print("tizzzzz---" + tid);
    }).whenComplete(() {
      prefs.setString("tid", tid);
      prefs.setString("channel", channel);
    });
  }

  getData() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      flname = pref.getString("flname").toString();
      oidtoken = pref.getString("oidtoken").toString();
    });
    OutletDetailApi.getData(oidtoken).then((value) {
      setState(() {
        gcc_code = value!.data!.gccCode!;
        mgr_contect_no = value.data!.mgrContectNo!;
        MGRName = value.data!.mgrPresellerName!;
        red_ol_class = value.data!.redOlClass!;
        ring_of_magic_area = value.data!.ringOfMagicArea!;
        cooler = value.data!.cooler!;
        channel = value.data!.channel!;
        outlet_name = value.data!.outletName!;
        print("populationStatus---------" + value.data!.populationStatus!);
        print("incidenceStatus---------" + value.data!.incidenceStatus!);
        print("priceCommunicationStatus---------" + value.data!.priceCommunicationStatus!);
        pref.setString("populationStatus", value.data!.populationStatus!);
        pref.setString("incidenceStatus", value.data!.incidenceStatus!);
        pref.setString("priceCommunicationStatus", value.data!.priceCommunicationStatus!);
      });
    }).whenComplete(() {
      if (flagNumber == 1) {
        setTask();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.decelerate,
                duration: Duration(seconds: 1),
                child: ShopPic()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/ccsmall.png", height: 80),
                  Spacer(),
                  // Align(alignment: Alignment.center, child: CustomBadge()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flname,
                        style: GoogleFonts.ibmPlexSerif(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Let's see your tasks",
                        style: GoogleFonts.ibmPlexSerif(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "GCC No:",
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            gcc_code,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Channel Class:",
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            channel,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Red OL Class:',
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            red_ol_class,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Coolers:",
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            cooler,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Outlet Name:",
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            outlet_name,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Market Area:',
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            ring_of_magic_area,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "MGR Name:",
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            MGRName,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'MGR Contact Number:',
                      style: GoogleFonts.ibmPlexSerif(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      mgr_contect_no,
                      style: GoogleFonts.ibmPlexSerif(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  setTask();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          curve: Curves.decelerate,
                          duration: Duration(seconds: 1),
                          child: ShopPic()));
                },
                child: Center(
                  child: Container(
                    width: 230,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Submit Details',
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
    );
  }
}
