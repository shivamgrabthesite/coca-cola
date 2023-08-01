import 'package:coca_cola/apis/reg2api.dart';
import 'package:coca_cola/waiting_screen.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:coca_cola/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegScreen2 extends StatefulWidget {
  const RegScreen2({super.key});

  @override
  State<RegScreen2> createState() => _RegScreen2State();
}

class _RegScreen2State extends State<RegScreen2> {
  bool isObscure = true;
  bool isObscure2 = true;
  bool isCheck = false;
  var _key = GlobalKey<FormState>();
  TextEditingController clg_name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_pass = TextEditingController();
  String? data;
  String msgs = '';
  getData() async {
    if (_key.currentState!.validate()) {
      if (password.text != confirm_pass.text) {
        Fluttertoast.showToast(
          msg: "enter both password same",
        );
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        data = prefs.getString("token")!;
        print("tokkkrn----" + data.toString());
        Reg2Api.setData(clg_name.text, password.text, data!).then((value) {
          print("reg2------" + value.toString());
          setState(() {
            msgs = value!.message.toString();
            Fluttertoast.showToast(
              msg: msgs.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          });
        });
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                curve: Curves.decelerate,
                duration: Duration(seconds: 1),
                child: WaitingScreen()));
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg.toString())));
      }
    } else {
      Fluttertoast.showToast(
        msg: "enter all details",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Join the Coca-Cola Internship Program',
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Unlock new opportunities and gain valuable experience',
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomLabel(label: "College Name"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: clg_name,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.location,
                          color: Colors.black,
                        ),
                        hintText: "Eg.Nirma University",
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomLabel(label: "Password"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: password,
                      cursorColor: Colors.black,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? Icon(
                                  IconlyLight.hide,
                                )
                              : Icon(
                                  IconlyLight.show,
                                ),
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomLabel(label: "Confirm Password"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: confirm_pass,
                      cursorColor: Colors.black,
                      obscureText: isObscure2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          IconlyLight.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure2 = !isObscure2;
                            });
                          },
                          icon: isObscure2
                              ? Icon(
                                  IconlyLight.hide,
                                )
                              : Icon(
                                  IconlyLight.show,
                                ),
                          color: Colors.black,
                        ),
                        hintText: "Confirm Password",
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        visualDensity: VisualDensity(horizontal: -4),
                        onChanged: (value) {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        activeColor: Colors.black,
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'you agree to our ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Condition ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy.*',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      getData();
                    },
                    child: Center(
                      child: Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSerif(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
