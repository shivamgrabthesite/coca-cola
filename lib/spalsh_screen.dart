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
  String? userToken;
  @override
  void initState() {
    super.initState();
    // controller = GifController(vsync: this);
    getData();
  }

  getData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      userToken = prefs.getString("logintoken");
      print("usertoken-------" + userToken!);
    });
    if (userToken != null) {
      Timer(Duration(seconds: 7), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomBar(),
        ));
      });
    } else {
      Timer(Duration(seconds: 7), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Onboard0(),
        ));
      });
    }
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
