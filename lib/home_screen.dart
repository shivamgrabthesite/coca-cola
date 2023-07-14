import 'package:coca_cola/select_outlet.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  Map<DateTime, List> events = {
    DateTime.utc(2023, 7, 15): ['Event 1', 'Event 2', 'Event 3', 'Event 2'],
    DateTime.utc(2023, 7, 18): ['Event 2', 'Event 3'],
    DateTime.utc(2023, 7, 20): ['Event 4'],
  };

  List _listofDate(DateTime date) {
    if (events[date] != null) {
      return events[date]!;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
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
                  Hero(tag: "homeScreen", child: SvgPicture.asset("assets/images/ccsmall.svg")),
                  Spacer(),
                  Align(alignment: Alignment.center, child: CustomBadge()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Good Morning ☀',
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
                  'Alex Volkov',
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                child: TableCalendar(
                  availableGestures: AvailableGestures.horizontalSwipe,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay!,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onCalendarCreated: (pageController) {
                    _listofDate(_focusedDay!);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  eventLoader: (day) {
                    return _listofDate(day);
                  },
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white),
                      weekendStyle: TextStyle(color: Colors.white)),
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(color: Colors.white),
                      titleCentered: true,
                      leftChevronVisible: true,
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      )),
                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.white),
                    todayTextStyle: TextStyle(color: Colors.white),
                    outsideTextStyle: TextStyle(color: Colors.white),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white),
                    markerMargin: EdgeInsets.only(top: 5),
                    markerDecoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(50))),
                    markersMaxCount: 5,
                    canMarkersOverflow: true,
                    markerSize: 6,
                    markerSizeScale: 1,
                    selectedDecoration:
                        BoxDecoration(color: Color(0xFFE61D2B), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Color.fromARGB(0, 131, 131, 131), shape: BoxShape.circle),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ..._listofDate(_selectedDay!).map((e) => InkWell(
                    onTap: () => PageTransition(
                        type: PageTransitionType.fade,
                        curve: Curves.decelerate,
                        duration: Duration(seconds: 1),
                        child: SelectOutlet()),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
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
                            'MarketArea1',
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
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
