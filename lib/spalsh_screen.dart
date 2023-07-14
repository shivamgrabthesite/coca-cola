import 'dart:async';
import 'package:coca_cola/onboard0.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final GifController controller;

  @override
  void initState() {
    super.initState();
    // controller = GifController(vsync: this);
    Timer(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Onboard0(),
      ));
    });
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
