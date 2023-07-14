// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabel extends StatelessWidget {
  String? label;
  CustomLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      style: GoogleFonts.ibmPlexSerif(
        color: Colors.black,
        fontSize: 13.77,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
