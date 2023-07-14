import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPic extends StatefulWidget {
  const ShopPic({super.key});

  @override
  State<ShopPic> createState() => _ShopPicState();
}

class _ShopPicState extends State<ShopPic> {
  String text = "not clicked";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset("assets/images/backbtn.svg"),
                        ),
                      ),
                    ),
                    Spacer(),
                    CustomBadge()
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Alex Volkov',
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please select to fill details",
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/reddot.png"),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '10:00-13:00',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Color(0xFF8F9BB3),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset("assets/images/dot.svg")
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'BALAJI KGS',
                        style: GoogleFonts.ibmPlexSerif(
                          color: Color(0xFF222B45),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '015290 MIYAPUR',
                            style: GoogleFonts.ibmPlexSans(
                              color: Color(0xFF8F9BB3),
                              fontSize: 12.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'G000001041',
                            style: GoogleFonts.ibmPlexSans(
                              color: Color(0xFF8F9BB3),
                              fontSize: 12.05,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // Stack(
                //   children: [
                //     Image.asset(
                //       "assets/images/img1.png",
                //     ),
                //     // Positioned(
                //     //   top: height / 20,
                //     //   left: width / 3.4,
                //     //   child: GestureDetector(
                //     //     onTap: () {
                //     //       setState(() {
                //     //         text = "clicked";
                //     //       });
                //     //     },
                //     //     // child: Text("data"),
                //     //   ),
                //     // )
                //   ],
                // ),
                // Text(text)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/i1.png",
                      fit: BoxFit.fill,
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/i3.png",
                        ),
                        Image.asset(
                          "assets/images/i2.png",
                        ),
                        Image.asset(
                          "assets/images/i4.png",
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
