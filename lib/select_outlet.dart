// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:coca_cola/shop_pic.dart';
import 'package:coca_cola/widgets/custom_badge.dart';

import 'apis/outlet_api.dart';
import 'model/outlet_model.dart';

class SelectOutlet extends StatefulWidget {
  String? id;
  SelectOutlet({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SelectOutlet> createState() => _SelectOutletState();
}

class _SelectOutletState extends State<SelectOutlet> {
  List priCustomerName = [];
  List address = [];
  List customerGccId = [];
  List channel = [];

  @override
  void initState() {
    super.initState();
    getOutlet();
  }

  getOutlet() {
    print("id----" + widget.id!);
    OutletApi.getData(widget.id!).then((value) {
      setState(() {
        for (var i = 0; i < value!.data.length; i++) {
          priCustomerName.add(value.data[i].priCustomerName);
          address.add(value.data[i].address);
          customerGccId.add(value.data[i].customerGccId);
          channel.add(value.data[i].imageChannal);
        }
      });

      print(priCustomerName);
      print(address);
      print(customerGccId);
      print(channel);
    });
  }

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
                    const Spacer(),
                    const CustomBadge()
                  ],
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: ShopPic(
                              customerGccId: customerGccId[index],
                              address: address[index],
                              priCustomerName: priCustomerName[index],
                              channel: channel[index],
                            ),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/reddot.png"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '11/06/2023',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ibmPlexSerif(
                                      color: Color(0xFF8F9BB3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                priCustomerName[index],
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      address[index],
                                      style: GoogleFonts.ibmPlexSans(
                                        color: Color(0xFF8F9BB3),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Text(
                                    customerGccId[index],
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
                    itemCount: priCustomerName.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
