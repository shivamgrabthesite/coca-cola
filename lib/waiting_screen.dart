import 'dart:async';
import 'package:coca_cola/week_screen.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'apis/clg_data.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> with TickerProviderStateMixin {
  late final GifController controller;
  List<String> clgList = [];

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    // getData();
    Timer(Duration(milliseconds: 7000), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
              child: WeekScreen(
                  // clgList: clgList,
                  )));
    });
  }

  getData() {
    ClgData.getData().then((value) {
      for (var i = 0; i < value!.data.length; i++) {
        clgList.add(value.data[i].instituteName);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gif(
                  controller: controller,
                  image: AssetImage("assets/images/reg3.gif"),
                  autostart: Autostart.loop,
                  useCache: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Thank you for registering! We are currently processing your information. Please wait while we complete the registration process.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
