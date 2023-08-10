// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coca_cola/shop_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/outlet_detail_api.dart';
import 'apis/task_api.dart';

class OutletDetail extends StatefulWidget {
  String id = '';
  OutletDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<OutletDetail> createState() => _OutletDetailState();
}

class _OutletDetailState extends State<OutletDetail> {
  String Customer_GCC_ID = '',
      Pri_Customer_Name = '',
      Channel = '',
      RedOutletClass = '',
      MarketArea = '',
      Unit = '',
      City = '',
      CollegeName = '',
      SMName = '',
      ASMName = '',
      STLName = '',
      MGRName = '',
      DistName = '',
      Week = '',
      Day = '',
      mid = '',
      uid = '',
      MOBILE = '';
  String flname = '';
  String uidtoken = '', midtoken = '', oidtoken = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  setTask() async {
    var prefs = await SharedPreferences.getInstance();
    uidtoken = prefs.getString("uidtoken").toString();
    midtoken = prefs.getString("midtoken").toString();
    oidtoken = prefs.getString("oidtoken").toString();

    print("uidtoken----" + uidtoken);
    print("midtoken----" + midtoken);
    print("oidtoken----" + oidtoken);

    TaskApi.getData(uidtoken, midtoken, oidtoken).then((value) {
      print("task response---------" + value!.data.id.toString());
      prefs.setString("tid", value.data.id);
    });
  }

  getData() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      flname = pref.getString("flname").toString();
    });
    print("widget id ---------" + widget.id);
    OutletDetailApi.getData(widget.id).then((value) {
      print("data---------" + value!.data.asmName);

      Customer_GCC_ID = value.data.customerGccId;
      Pri_Customer_Name = value.data.priCustomerName;
      Channel = value.data.channel;
      RedOutletClass = value.data.redOutletClass;
      MarketArea = value.data.marketArea;
      Unit = value.data.unit;
      City = value.data.city;
      CollegeName = value.data.collegeName;
      SMName = value.data.smName;
      ASMName = value.data.asmName;
      STLName = value.data.stlName;
      MGRName = value.data.mgrName;
      DistName = value.data.distName;
      Week = value.data.week;
      Day = value.data.day;
      mid = value.data.mid;
      uid = value.data.uid;
      MOBILE = value.data.mobileNumber;
    }).whenComplete(() {
      setState(() {});
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
                        style: GoogleFonts.ibmPlexSans(
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
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Customer_GCC_ID!,
                        style: GoogleFonts.ibmPlexSerif(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            Pri_Customer_Name!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            City!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Outlet Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Area',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            Channel!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80,
                        // ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            RedOutletClass!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Channel',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Red Outlet Class',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            MarketArea!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80,
                        // ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            Unit!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Market Area',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Unit',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            City!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80,
                        // ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            CollegeName!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'City',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'College Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            SMName!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80,
                        // ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            ASMName!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'SM Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'ASM Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            STLName!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Siz
                        Spacer(),
                        Expanded(
                          child: Text(
                            MGRName!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'STL Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'MGR Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            DistName!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80,
                        // ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            Week!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Dist. Name',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Week',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            Day!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedB
                        Spacer(),
                        Expanded(
                          child: Text(
                            mid!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Day',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'mid',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            uid!,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Siz
                        Spacer(),
                        Expanded(
                          child: Text(
                            Unit!,
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
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'uid',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Unit',
                          style: GoogleFonts.ibmPlexSans(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        MOBILE,
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mobile Number',
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
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
                          child: ShopPic(
                            address: "P01265 PADMARAO NAGAR_BOIGUDA",
                            channel: "Grocery - S&B",
                            customerGccId: "G000012245",
                            priCustomerName: "VIJAY KIRANA GEN.STORES",
                          )));
                },
                child: Center(
                  child: Container(
                    width: 230,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Add Details',
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
