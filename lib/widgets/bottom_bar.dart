import 'package:coca_cola/home_screen.dart';
import 'package:coca_cola/profile_screen.dart';
import 'package:coca_cola/starterkit_screen.dart';
import 'package:coca_cola/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          backgroundColor: Colors.white.withOpacity(.85),
          screenTransitionAnimation: ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.linear,
              duration: Duration(milliseconds: 600)),
          // itemAnimationProperties: ItemAnimationProperties(
          //     duration: Duration(
          //       milliseconds: 800,
          //     ),
          //     curve: Curves.decelerate),
          onItemSelected: (value) {},
          screens: const [
            HomeScreen(),
            TaskScreen(),
            StarterkitScreen(),
            ProfileScreen(),
          ],
          decoration: NavBarDecoration(border: Border(top: BorderSide(color: Colors.black))),
          items: [
            PersistentBottomNavBarItem(
                icon: Icon(
                  IconlyLight.home,
                  color: Colors.black,
                ),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: ""),
            PersistentBottomNavBarItem(
                icon: Icon(
                  Icons.task_alt_rounded,
                  color: Colors.black,
                ),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: ""),
            PersistentBottomNavBarItem(
                icon: Icon(
                  Icons.star_outline,
                  color: Colors.black,
                ),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: ""),
            PersistentBottomNavBarItem(
                icon: Icon(
                  IconlyLight.profile,
                  color: Colors.black,
                ),
                activeColorPrimary: Colors.red,
                inactiveColorPrimary: Colors.grey,
                title: "")
          ],
          navBarStyle: NavBarStyle.style12,
        ),
      ),
    );
  }
}
