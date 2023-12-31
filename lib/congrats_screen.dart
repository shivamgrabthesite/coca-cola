import 'dart:async';

import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> with TickerProviderStateMixin {
  late final GifController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = GifController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/ccsmall.svg"),
                    Spacer(),
                    Align(alignment: Alignment.center, child: CustomBadge()),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Gif(
                  controller: controller,
                  image: AssetImage(
                    "assets/images/congrats.gif",
                  ),
                  autostart: Autostart.loop,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Congratulations you finish your Week 1 tasks',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.fade,
                    //         curve: Curves.decelerate,
                    //         duration: Duration(seconds: 1),
                    //         child: BottomBar()));
                  },
                  child: Center(
                    child: Container(
                      width: 230,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Add college for week 2',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSerif(
                            color: Colors.white,
                            fontSize: 18,
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
    );
  }
}
