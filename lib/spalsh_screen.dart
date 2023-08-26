import 'dart:async';
import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/onboard0.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final GifController controller;
  bool? userToken;
  @override
  void initState() {
    super.initState();
    // controller = GifController(vsync: this);
    getData();
  }

  getData() async {
    var prefs = await SharedPreferences.getInstance();
    userToken = prefs.getBool("loginstatus");
    print("usertoken-------" + userToken.toString());

    Timer(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => userToken == null ? Onboard0() : BottomBar(),
      ));
    });
    // if (userToken == '') {
    //   Timer(Duration(seconds: 7), () {
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) =>userToken==''? Onboard0(): BottomBar(),
    //     ));
    //   });
    // } else {
    //   Timer(Duration(seconds: 7), () {
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) => BottomBar(),
    //     ));
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/images/cocagif.gif"),
          // child: Gif(
          //   controller: controller,
          //   image: AssetImage("assets/images/cocagif.gif"),
          //   autostart: Autostart.once,
          //   // duration: Duration(seconds: 7),
          //   // onFetchCompleted: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   //       builder: (context) => OnboardingScreen(),
          //   //     ))
          // ),
        ),
      ),
    );
  }
}
