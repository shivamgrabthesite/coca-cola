import 'dart:convert';

import 'package:coca_cola/apis/custom_week_api.dart';
import 'package:coca_cola/select_outlet.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'apis/header_model_api.dart';
import 'apis/market_api.dart';
import 'constant/api.dart';

// class Event {
//   final String area;

//   Event(this.area);
//   @override
//   String toString() {
//     return '$area';
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DateTime now = DateTime.now();
  TabController? tabcontroller;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  // String data = '';
  List mon = [];
  List tue = [];
  List wed = [];
  List thu = [];
  List fri = [];
  List sat = [];
  String headerData = '';
  List monid = [];
  List tueid = [];
  List wedid = [];
  List thuid = [];
  List fridi = [];
  List sarid = [];
  String clgName = '';
  String week = '';
  String flname = '';
  String data='';
  bool? success;
  String _selectedWeek = "1";

  List<String> _weeks = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: days.length, vsync: this);
    getData();
  }

  // getTime() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   data = prefs.getString("token")!;
  //   HeaderModelApi.getData(data!).then((value) {
  //     setState(() {
  //       headerData = value!.data.wishes;
  //     });
  //   });
  // }


  Future getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    mon.clear();
    tue.clear();
    wed.clear();
    thu.clear();
    fri.clear();
    sat.clear();

    data = prefs.getString("logintoken").toString();
    clgName = prefs.getString("clgName").toString();
    week = prefs.getString("week").toString();
    flname = prefs.getString("flname").toString();

    _selectedWeek = week;

    MarketApi.getData(data!).then((value) {
      print("value----" + value!.data.toString());

      setState(() {
        for (var j = 0; j < value.data![0].count!; j++) {
          mon.add(value.data![0].monday![j].area);
          monid.add(value.data![0].monday![j].id);
        }
        for (var k = 0; k < value.data![1].tuesdayCount!; k++) {
          tue.add(value.data![1].tuesday![k].area);
          tueid.add(value.data![1].tuesday![k].id);
        }
        for (var k = 0; k < value.data![2].wednesdayCount!; k++) {
          wed.add(value.data![2].wednesday![k].area);
          wedid.add(value.data![2].wednesday![k].id);
        }
        for (var k = 0; k < value.data![3].thursdayCount!; k++) {
          thu.add(value.data![3].thursday![k].area);
          thuid.add(value.data![3].thursday![k].id);
        }
        for (var k = 0; k < value.data![4].fridayCount!; k++) {
          fri.add(value.data![4].friday![k].area);
          fridi.add(value.data![4].friday![k].id);
        }
        for (var k = 0; k < value.data![5].saturdayCount!; k++) {
          sat.add(value.data![5].saturday![k].area);
          sarid.add(value.data![5].saturday![k].id);
        }
      });
    }).whenComplete(() {
      setState(() {

      });
    });
  }


  getWeek(String weekNo)
  {
    CustomWeekApi.getData(weekNo, data!).then((value) {
      success = value!.success;
    });
  }
  removeData(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("logintoken");
      prefs.remove("loginstatus");
    });
    SystemNavigator.pop();
  }
  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Week Change Successful.\nPlease Restart the App to see the Changes'),
          actions: [
            TextButton(
              onPressed: () {
                removeData(context);
              },
              child: Text('Okay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return getData();
      },
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      color: Colors.red,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: "cocacola",
                    child: Image.asset("assets/images/ccsmall.png", height: 80),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton<String>(
                  underline: null,
                  focusColor: Colors.black,

                  value: _selectedWeek,
                  alignment: Alignment.center,
                  onChanged: (String? newValue) {
                    getWeek(newValue!);
                    if(success==true)
                      {
                        setState(() {
                          showSuccessDialog();
                          _selectedWeek = newValue!;
                        });
                      }

                  },
                  items: _weeks.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text("Week "+value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  clgName + "\nWEEK " + week,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  headerData,
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  flname,
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
              TabBar(
                controller: tabcontroller,
                isScrollable: true,
                onTap: (value) {
                  setState(() {});
                },
                tabs: days.map((day) => Tab(text: day)).toList(),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 500,
                child: TabBarView(
                  controller: tabcontroller,
                  physics: NeverScrollableScrollPhysics(),
                  children: tabcontroller!.index == 0
                      ? days
                          .map(
                            (e) => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mon.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          curve: Curves.decelerate,
                                          duration: Duration(seconds: 1),
                                          child: SelectOutlet(
                                            idz: monid[index],
                                            areaName: mon[index],
                                            day: "Monday",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration:
                                          BoxDecoration(border: Border.all(color: Colors.black)),
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
                                                '10:00-13:00',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.ibmPlexSerif(
                                                  color: Color(0xFF8F9BB3),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            mon[index],
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
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                      : tabcontroller!.index == 1
                          ? days
                              .map(
                                (e) => ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: tue.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              curve: Curves.decelerate,
                                              duration: Duration(seconds: 1),
                                              child: SelectOutlet(
                                                idz: tueid[index],
                                                areaName: tue[index],
                                                day: "Tuesday",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)),
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
                                                    '10:00-13:00',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.ibmPlexSerif(
                                                      color: Color(0xFF8F9BB3),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                tue[index],
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
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                          : tabcontroller!.index == 2
                              ? days
                                  .map(
                                    (e) => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: wed.length,
                                      itemBuilder: (context, index) => Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  curve: Curves.decelerate,
                                                  duration: Duration(seconds: 1),
                                                  child: SelectOutlet(
                                                    idz: wedid[index],
                                                    areaName: wed[index],
                                                    day: "Wednesday",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
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
                                                        '10:00-13:00',
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.ibmPlexSerif(
                                                          color: Color(0xFF8F9BB3),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    wed[index],
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()
                              : tabcontroller!.index == 3
                                  ? days
                                      .map(
                                        (e) => ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: thu.length,
                                          itemBuilder: (context, index) => Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      curve: Curves.decelerate,
                                                      duration: Duration(seconds: 1),
                                                      child: SelectOutlet(
                                                        idz: thuid[index],
                                                        areaName: thu[index],
                                                        day: "Thursday",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black)),
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
                                                            '10:00-13:00',
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.ibmPlexSerif(
                                                              color: Color(0xFF8F9BB3),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        thu[index],
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList()
                                  : tabcontroller!.index == 4
                                      ? days
                                          .map(
                                            (e) => ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: fri.length,
                                              itemBuilder: (context, index) => Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type: PageTransitionType.fade,
                                                          curve: Curves.decelerate,
                                                          duration: Duration(seconds: 1),
                                                          child: SelectOutlet(
                                                            idz: fridi[index],
                                                            areaName: fri[index],
                                                            day: "Friday",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                  "assets/images/reddot.png"),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '10:00-13:00',
                                                                textAlign: TextAlign.center,
                                                                style: GoogleFonts.ibmPlexSerif(
                                                                  color: Color(0xFF8F9BB3),
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            fri[index],
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList()
                                      : days
                                          .map(
                                            (e) => ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: sat.length,
                                              itemBuilder: (context, index) => Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type: PageTransitionType.fade,
                                                          curve: Curves.decelerate,
                                                          duration: Duration(seconds: 1),
                                                          child: SelectOutlet(
                                                            idz: sarid[index],
                                                            areaName: sat[index],
                                                            day: "Saturday",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                  "assets/images/reddot.png"),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '10:00-13:00',
                                                                textAlign: TextAlign.center,
                                                                style: GoogleFonts.ibmPlexSerif(
                                                                  color: Color(0xFF8F9BB3),
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            sat[index],
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration:
              //       BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
              //   child: TableCalendar(
              //     availableGestures: AvailableGestures.horizontalSwipe,
              //     firstDay: DateTime.utc(2010, 10, 16),
              //     lastDay: DateTime.utc(2030, 3, 14),
              //     focusedDay: _focusedDay,
              //     calendarFormat: _calendarFormat,
              //     onCalendarCreated: (pageController) {
              //       // print("focusday-------" + _focusedDay.toString());
              //       _getEventsForDay(_focusedDay);
              //     },
              //     onDaySelected: (selectedDay, focusedDay) {
              //       setState(() {
              //         _selectedDay = selectedDay;
              //         _focusedDay = focusedDay;
              //         print("selectedday-----" + _selectedDay.toString());
              //         print("focusday-----" + _focusedDay.toString());
              //       });
              //     },
              //     selectedDayPredicate: (day) {
              //       return isSameDay(_selectedDay, day);
              //     },
              //     eventLoader: (day) {
              //       return _getEventsForDay(day);
              //     },
              //     daysOfWeekStyle: const DaysOfWeekStyle(
              //         weekdayStyle: TextStyle(color: Colors.white),
              //         weekendStyle: TextStyle(color: Colors.white)),
              //     headerStyle: const HeaderStyle(
              //         formatButtonVisible: false,
              //         titleTextStyle: TextStyle(color: Colors.white),
              //         titleCentered: true,
              //         leftChevronVisible: true,
              //         leftChevronIcon: Icon(
              //           Icons.arrow_back_ios_new_rounded,
              //           color: Colors.white,
              //         ),
              //         rightChevronIcon: Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           color: Colors.white,
              //         )),
              //     calendarStyle: const CalendarStyle(
              //       defaultTextStyle: TextStyle(color: Colors.white),
              //       todayTextStyle: TextStyle(color: Colors.white),
              //       outsideTextStyle: TextStyle(color: Colors.white),
              //       selectedTextStyle: TextStyle(color: Colors.white),
              //       weekendTextStyle: TextStyle(color: Colors.white),
              //       markerMargin: EdgeInsets.only(top: 6, left: 1.5),
              //       markerDecoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.all(Radius.circular(50)),
              //       ),
              //       markersMaxCount: 3,
              //       canMarkersOverflow: true,
              //       markerSize: 6,
              //       selectedDecoration:
              //           BoxDecoration(color: Color(0xFFE61D2B), shape: BoxShape.circle),
              //       todayDecoration: BoxDecoration(
              //           color: Color.fromARGB(0, 131, 131, 131), shape: BoxShape.circle),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     clgName + "_week#" + week,
              //     style: GoogleFonts.ibmPlexSerif(
              //       color: Colors.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: _getEventsForDay(_selectedDay).length,
              //     itemBuilder: (context, index) {
              //       final marketArea = _getEventsForDay(_selectedDay)[index];
              //       return ListTile(
              //         title: Text(marketArea),
              //       );
              //     })
              // ListView.separated(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              // var event = _getEventsForDay(_selectedDay)[index];
              // print("inllist------------" + event);
              //   return Column(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           print("data name--------" + marketName[index]);
              //           Navigator.push(
              //             context,
              //             PageTransition(
              //               type: PageTransitionType.fade,
              //               curve: Curves.decelerate,
              //               duration: Duration(seconds: 1),
              //               child: SelectOutlet(
              //                 id: id,
              //               ),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           padding: EdgeInsets.all(8),
              //           decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Image.asset("assets/images/reddot.png"),
              //                   SizedBox(
              //                     width: 5,
              //                   ),
              //                   Text(
              //                     '10:00-13:00',
              //                     textAlign: TextAlign.center,
              //                     style: GoogleFonts.ibmPlexSerif(
              //                       color: Color(0xFF8F9BB3),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                   Spacer(),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 _getEventsForDay(_selectedDay)[index],
              //                 style: GoogleFonts.ibmPlexSerif(
              //                   color: Color(0xFF222B45),
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 'Check the boarding',
              //                 style: GoogleFonts.ibmPlexSans(
              //                   color: Color(0xFF8F9BB3),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   );
              // },
              // separatorBuilder: (context, index) {
              //   return SizedBox(
              //     height: 10,
              //   );
              // },
              // itemCount: _events.length),
              // ..._getEventsForDay(_selectedDay).map((e) {
              //   return Column(
              //     children: [
              //       InkWell(
              //         // onTap: () => Navigator.push(
              //         //     context,
              //         //     PageTransition(
              //         //         type: PageTransitionType.fade,
              //         //         curve: Curves.decelerate,
              //         //         duration: Duration(seconds: 1),
              //         //         child: SelectOutlet())),
              //         child: Container(
              //           padding: EdgeInsets.all(8),
              //           decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Image.asset("assets/images/reddot.png"),
              //                   SizedBox(
              //                     width: 5,
              //                   ),
              //                   Text(
              //                     '10:00-13:00',
              //                     textAlign: TextAlign.center,
              //                     style: GoogleFonts.ibmPlexSerif(
              //                       color: Color(0xFF8F9BB3),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                   Spacer(),
              //                 ],
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 e.toString(),
              //                 style: GoogleFonts.ibmPlexSerif(
              //                   color: Color(0xFF222B45),
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 'Check the boarding',
              //                 style: GoogleFonts.ibmPlexSans(
              //                   color: Color(0xFF8F9BB3),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       )
              //     ],
              //   );
              // }),
            ],
          ),
        ),
      )),
    );
  }
}

List<Map<String, dynamic>> apiData = [
  {
    "success": true,
    "data": [
      {
        "monday": [
          {"area": "Market Area 1", "id": "64c24df6abf3850f1bdc7d0a"},
          {"area": "Market Area 1", "id": "64c24df6abf3850f1bdc7d0a"}
        ],
        "count": 2
      },
      {
        "tuesday": [
          {"area": "Market Area 7", "id": "64c24df6abf3850f1bdc7d10"}
        ],
        "tuesdayCount": 1
      },
      {"Wednesday": [], "WednesdayCount": 0},
      {"Thursday": [], "ThursdayCount": 0},
      {"Friday": [], "FridayCount": 0},
      {"saturday": [], "saturdayCount": 0}
    ]
  }
];
