import 'package:coca_cola/shop_pic.dart';
import 'package:coca_cola/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SelectOutlet extends StatefulWidget {
  const SelectOutlet({super.key});

  @override
  State<SelectOutlet> createState() => _SelectOutletState();
}

class _SelectOutletState extends State<SelectOutlet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
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
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
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
                    "Please select the Outlet",
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
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(context,
                            PageTransition(type: PageTransitionType.fade, child: ShopPic())),
                        child: Container(
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
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
