import 'package:coca_cola/congrats_screen.dart';
import 'package:coca_cola/getstarted_screen.dart';
import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/incidence_screen.dart';
import 'package:coca_cola/leaderboard_screen.dart';
import 'package:coca_cola/login_screen.dart';
import 'package:coca_cola/notification_Screen.dart';
import 'package:coca_cola/outlet_detail.dart';
import 'package:coca_cola/provider/incidence_provider.dart';
import 'package:coca_cola/provider/population_provider.dart';
import 'package:coca_cola/provider/price_provider.dart';
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
import 'package:provider/provider.dart';

import 'bonus_screen.dart';
import 'edit_profile.dart';
import 'onboard0.dart';
import 'package:universal_io/io.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());

  bool kisweb;
  try{
    if(Platform.isAndroid||Platform.isIOS) {
      kisweb=false;
    } else {
      kisweb=true;
    }
  } catch(e){
    kisweb=true;
  }

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PopulationProvider>(create: (context) => PopulationProvider()),
        ChangeNotifierProvider<IncidenceProvider>(create: (context) => IncidenceProvider()),
        ChangeNotifierProvider<PriceProvider>(create: (context) => PriceProvider()),
      ],
      child: MaterialApp(
        // routes: {
        //   "/": (context) => SplashScreen(),
        //   "/onBoarding": (context) => Onboard0(),
        //   "/getStarted": (context) => GetstartedScreen(),
        //   "/login": (context) => LoginScreen(),
        //   "/bottombar": (context) => BottomBar(),
        //   "/HomeScreen": (context) => HomeScreen(),
        // },
        // initialRoute: "/",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
