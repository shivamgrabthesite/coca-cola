// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/profile_screen.dart';
import 'package:coca_cola/starterkit_screen.dart';
import 'package:coca_cola/task_screen.dart';

class BottomBar extends StatefulWidget {
  int index;
  BottomBar({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;
  // int index = 0;
  bool? status;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.index);
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
        body:PersistentTabView(
            context,
            controller: _controller,
            resizeToAvoidBottomInset: true,
            stateManagement: false,
            hideNavigationBar: false,
            onItemSelected: (value) {
              // setState.call(
              //   () {
              //     widget.index = value;
              //   },
              // );
              // setState(() {
              //   switch (value) {
              //     case 0:
              //       _controller.index = 0;
              //       _controller.dispose();
              //       break;
              //     case 1:
              //       _controller.index = 1;
              //       _controller.dispose();
              //       break;
              //     case 2:
              //       _controller.index = 2;
              //       _controller.dispose();
              //       break;
              //     case 3:
              //       _controller.index = 3;
              //       _controller.dispose();
              //       break;
              //     default:
              //   }
              // });
            },
            hideNavigationBarWhenKeyboardShows: true,
            popActionScreens: PopActionScreensType.all,
            backgroundColor: Colors.white.withOpacity(.85),
            screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.linear,
                duration: Duration(milliseconds: 500)),
            screens: const [
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
