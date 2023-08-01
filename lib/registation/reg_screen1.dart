import 'package:coca_cola/apis/reg1api.dart';
import 'package:coca_cola/registation/reg_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_label.dart';
import 'email_verify.dart';

class RegScreen1 extends StatefulWidget {
  const RegScreen1({super.key});

  @override
  State<RegScreen1> createState() => _RegScreen1State();
}

class _RegScreen1State extends State<RegScreen1> {
  var _key = GlobalKey<FormState>();
  TextEditingController f_name = TextEditingController();
  TextEditingController l_name = TextEditingController();
  TextEditingController clg_email = TextEditingController();
  String authorization = "";
  String msgs = '';

  getData() async {
    if (_key.currentState!.validate()) {
      var prefs = await SharedPreferences.getInstance();
      Reg1API.getData(f_name.text, l_name.text, clg_email.text).then((value) {
        print("msg--------" + value!.data.toString());
        setState(() {
          authorization = value.data;
          msgs = value.message;
          print("authorization-------" + authorization);
          print("msgs--------------" + msgs);
          prefs.setString("token", authorization);
          Fluttertoast.showToast(
            msg: msgs.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        });
      }).onError((error, stackTrace) {
        print("error:------" + error.toString());
      }).catchError((err) {
        print("catch error----- " + err);
      });

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg.toString())));

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
              child: EmailVerify(
                  // authorization: authorization,
                  )));
    } else {
      Fluttertoast.showToast(
        msg: "enter all fields",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
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
                    height: height / 30,
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
                    height: height / 70,
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
                    height: height / 20,
                  ),
                  CustomLabel(label: "First Name"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: f_name,
                      onChanged: (value) {
                        setState(() {
                          value = f_name.text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter First Name";
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: const Icon(
                          IconlyLight.profile,
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        hintText: "Eg.Alex",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomLabel(label: "Last Name"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: l_name,
                      onChanged: (value) {
                        setState(() {
                          value = l_name.text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Last Name";
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: const Icon(
                          IconlyLight.profile,
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        hintText: 'Eg.Volkov',
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomLabel(label: "College E-mail ID"),
                  Container(
                    width: width / 1,
                    height: 40,
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: clg_email,
                      onChanged: (value) {
                        setState(() {
                          value = clg_email.text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email ID";
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: const Icon(
                          IconlyLight.message,
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(fontSize: 0, height: 2),
                        hintText: 'Eg.alex@gmail.com',
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
                    height: 30,
                  ),
                  InkWell(
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
                            'Next',
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
