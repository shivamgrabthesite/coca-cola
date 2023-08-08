import 'package:coca_cola/congrats_screen.dart';
import 'package:coca_cola/getstarted_screen.dart';
import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/incidence_screen.dart';
import 'package:coca_cola/leaderboard_screen.dart';
import 'package:coca_cola/login_screen.dart';
import 'package:coca_cola/notification_Screen.dart';
import 'package:coca_cola/registation/mobile_otp.dart';
import 'package:coca_cola/population_screen.dart';
import 'package:coca_cola/price_communication_screen.dart';
import 'package:coca_cola/privacy_policy.dart';
import 'package:coca_cola/profile_screen.dart';
import 'package:coca_cola/question_screen.dart';
import 'package:coca_cola/registation/mobile_verify.dart';
import 'package:coca_cola/registation/reg_screen1.dart';
import 'package:coca_cola/registation/reg_screen2.dart';
import 'package:coca_cola/waiting_screen.dart';
import 'package:coca_cola/select_outlet.dart';
import 'package:coca_cola/shop_pic.dart';
import 'package:coca_cola/spalsh_screen.dart';
import 'package:coca_cola/starterkit_screen.dart';
import 'package:coca_cola/task_screen.dart';
import 'package:coca_cola/week_screen.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bonus_screen.dart';
import 'edit_profile.dart';
import 'onboard0.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
