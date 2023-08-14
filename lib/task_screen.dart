import 'package:coca_cola/shop_pic.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/fetch_task_api.dart';
import 'apis/market_api.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List marketData = [];
  List status = [];
  List gccid = [];
  String? data;
  String flname = '';
  List channel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    marketData.clear();
    status.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data = prefs.getString("logintoken")!;
      flname = prefs.getString("flname").toString();
    });
    print("uid--------" + data.toString());
    FetchTaskApi.getData(data!).then((value) {
      print("task data-----" + value!.data.toString());
      setState(() {
        for (var i = 0; i < value.data!.length!; i++) {
          marketData.add(value.data![i].market!.outletName!);
          status.add(value.data![i].status);
          channel.add(value.data![i].market!.channel);
          gccid.add(value.data![i].market!.gccCode);
          prefs.setString("taskLength", value.data![i].market!.outletName!.length.toString());
          print("market data---------" + marketData.toString());
        }
        print("data----" + marketData.toString());
        print("status----" + status.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return getData();
        },
        color: Colors.red,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
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
                      Text(
                        flname,
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(IconlyLight.filter)
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's see your tasks",
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
                        return InkWell(
                          onTap: () {
                            if (status[index] == "pending") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      curve: Curves.decelerate,
                                      duration: Duration(seconds: 1),
                                      child: ShopPic(
                                        channel: channel[index],
                                      )));
                            }
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
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'GCC ID: ' + gccid[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ibmPlexSerif(
                                        color: Color(0xFF8F9BB3),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: status[index] == "pending"
                                              ? Colors.blue
                                              : Colors.green,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Text(
                                        // "pending",
                                        status[index],
                                        style: GoogleFonts.ibmPlexSerif(
                                          color: Colors.white,
                                          fontSize: 7,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SvgPicture.asset("assets/images/dot.svg")
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  marketData[index],
                                  style: GoogleFonts.ibmPlexSerif(
                                    color: Color(0xFF222B45),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Check the boarding',
                                  style: GoogleFonts.ibmPlexSans(
                                    color: Color(0xFF8F9BB3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: marketData.length)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
