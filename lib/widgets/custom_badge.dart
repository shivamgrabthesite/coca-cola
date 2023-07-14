import 'package:coca_cola/notification_Screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';

class CustomBadge extends StatefulWidget {
  const CustomBadge({super.key});

  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => PageTransition(
          type: PageTransitionType.fade,
          curve: Curves.decelerate,
          duration: Duration(seconds: 1),
          child: NotificationScreen()),
      child: badges.Badge(
        position: badges.BadgePosition.custom(
          top: -10,
          end: 3,
        ),
        badgeContent: Text(
          '3',
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(
          IconlyLight.notification,
          size: 28,
          color: Colors.black,
        ),
      ),
    );
  }
}
