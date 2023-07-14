import 'package:coca_cola/getstarted_screen.dart';
import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/login_screen.dart';
import 'package:coca_cola/notification_Screen.dart';
import 'package:coca_cola/otp_screen.dart';
import 'package:coca_cola/privacy_policy.dart';
import 'package:coca_cola/profile_screen.dart';
import 'package:coca_cola/question_screen.dart';
import 'package:coca_cola/reg_screen2.dart';
import 'package:coca_cola/email_verify.dart';
import 'package:coca_cola/waiting_screen.dart';
import 'package:coca_cola/select_outlet.dart';
import 'package:coca_cola/shop_pic.dart';
import 'package:coca_cola/spalsh_screen.dart';
import 'package:coca_cola/reg_screen1.dart';
import 'package:coca_cola/starterkit_screen.dart';
import 'package:coca_cola/task_screen.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';
import 'onboard0.dart';
import 'onboarding_screen.dart';

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
      home: WaitingScreen(),
    );
  }
}
