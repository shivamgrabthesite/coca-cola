import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/outlet_api.dart';
import 'outlet_detail.dart';

class SelectOutlet extends StatefulWidget {
  String areaName = '';
  SelectOutlet({
    Key? key,
    required this.areaName,
  }) : super(key: key);

  @override
  State<SelectOutlet> createState() => _SelectOutletState();
}

class _SelectOutletState extends State<SelectOutlet> {
  List priCustomerName = [];
  List address = [];
  List customerGccId = [];
  List channel = [];
  String loginToken = '';
  List id = [];
  String flname = '';
  List status = [];
  @override
  void initState() {
    super.initState();
    getOutlet();
  }

  getOutlet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginToken = prefs.getString("logintoken")!;
    OutletApi.getData(widget.areaName, loginToken).then((value) {
      for (var i = 0; i < value!.data!.length; i++) {
        setState(() {
          priCustomerName.add(value.data![i].priCustomerName);
          address.add(value.data![i].address);
          customerGccId.add(value.data![i].customerGccId);
          channel.add(value.data![i].imageChannal);
          status.add(value.data![i].status);
          id.add(value.data![i].id);
        });
      }
      print("idzzz----" + id.toString());
    });
    flname = prefs.getString("flname").toString();
  }

  getOid(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("oidtoken", id[index]);
    if (status[index] != "completed") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: OutletDetail(
                  // id: id[index],
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset("assets/images/backbtn.svg"),
                        ),
                      ),
                    ),
                    // const Spacer(),
                    // const CustomBadge()
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                    "Please select the Outlet",
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          getOid(index);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/reddot.png"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '11/06/2023',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ibmPlexSerif(
                                      color: Color(0xFF8F9BB3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Spacer(),
                                  status[index] == "completed"
                                      ? Icon(
                                          Icons.done_outline_rounded,
                                          color: Colors.green,
                                        )
                                      : Container()
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                priCustomerName[index],
                                style: GoogleFonts.ibmPlexSerif(
                                  color: Color(0xFF222B45),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      address[index],
                                      style: GoogleFonts.ibmPlexSans(
                                        color: Color(0xFF8F9BB3),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Text(
                                    customerGccId[index],
                                    style: GoogleFonts.ibmPlexSans(
                                      color: Color(0xFF8F9BB3),
                                      fontSize: 12.05,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: priCustomerName.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
