import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/profile_screen.dart';
import 'package:coca_cola/starterkit_screen.dart';
import 'package:coca_cola/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  int index = 0;
  bool? status;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white12,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white12,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: PersistentTabView(
          context,
          controller: _controller,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          popActionScreens: PopActionScreensType.all,
          backgroundColor: Colors.white.withOpacity(.85),
          screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.linear,
              duration: Duration(milliseconds: 500)),
          screens: [
            HomeScreen(),
            TaskScreen(),
            StarterkitScreen(),
            ProfileScreen(),
          ],
          decoration: const NavBarDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          items: [
            PersistentBottomNavBarItem(
                icon: SvgPicture.asset("assets/images/Home.svg"),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: "HOME"),
            PersistentBottomNavBarItem(
                icon: SvgPicture.asset("assets/images/Card.svg"),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: "TASK"),
            PersistentBottomNavBarItem(
                icon: SvgPicture.asset("assets/images/Money.svg"),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: "STARTERKIT"),
            PersistentBottomNavBarItem(
                icon: const Icon(
                  IconlyLight.profile,
                  color: Colors.black,
                ),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: "PROFILE")
          ],
          navBarStyle: NavBarStyle.style12,
        ),
      ),
    );
  }
}
