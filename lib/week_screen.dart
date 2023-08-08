import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:coca_cola/widgets/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis/set_clg_name.dart';
import 'constant/api.dart';
import 'model/clg_data_model.dart';

class WeekScreen extends StatefulWidget {
  WeekScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  // final List<String> items = [
  //   "Indian Institute of Technology Kanpur",
  //   "University of Delhi",
  //   "Tata Institute of Fundamental Research",
  //   'Indian Institute of Science',
  //   'Manipal Academy of Higher Education'
  // ];
  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue;
  List clgList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData({String search = ''}) async {
    try {
      var url = Uri.parse(apiPath + "search-college?input=$search");
      print("url--------" + url.toString());
      var response = await http.get(url);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        ClgDataModel getdata = clgDataModelFromJson(response.body);
        for (var i = 0; i < getdata.data.length; i++) {
          setState(() {
            clgList.add(getdata.data[i].instituteName);
          });
        }
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }

  // getData() {
  //   ClgData.getData().then((value) {
  //     setState(() {
  //       for (var i = 0; i < value!.data.length; i++) {
  //         clgList.add(value.data[i].instituteName);
  //       }
  //     });
  //   });
  // }

  setClgName() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("logintoken");
    SetClgName.setData(selectedValue!, token!).then((value) {
      print("selected clg---------" + selectedValue.toString());
    });
  }

  // Future<void> getList() async {
  //   String jsonString = await rootBundle.loadString('assets/json/clgList.json');
  //   Map<String, dynamic> jsonData = json.decode(jsonString);
  //   ClgDataModel clgDataModel = ClgDataModel.fromJson(jsonData);
  //   setState(() {
  //     for (var i = 0; i < clgDataModel.data.length; i++) {
  //       clgList.add(clgDataModel.data[i].instituteName);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Alex Volkov',
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please select college",
                    style: GoogleFonts.ibmPlexSerif(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Week 1',
                  style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  'Please select your college for tailored information and surroundings.',
                  style: GoogleFonts.ibmPlexSerif(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // ListView.separated(
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(clgList[index]),
                //       );
                //     },
                //     separatorBuilder: (context, index) {
                //       return SizedBox(
                //         height: 10,
                //       );
                //     },
                //     itemCount: clgList.length),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    autofocus: true,
                    iconStyleData: IconStyleData(
                      icon: SvgPicture.asset("assets/images/Arrow.svg"),
                    ),
                    hint: Text(
                      'Select',
                      style: GoogleFonts.inter(
                        color: Color(0xFF4A4F4A),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    items: clgList
                        .map((item) => DropdownMenuItem(
                              value: item.toString(),
                              child: Row(
                                children: [
                                  // SvgPicture.asset("assets/images/Arrow.svg"),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  Expanded(
                                    child: Text(
                                      item.toString(),
                                      style: GoogleFonts.inter(
                                        color: Color(0xFF4A4F4A),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    // selectedItemBuilder: (context) {
                    //   return items
                    //       .map(
                    //         (item) => DropdownMenuItem(
                    //           value: selectedValue,
                    //           child: Text(
                    //             item,
                    //             style: GoogleFonts.inter(
                    //               color: Color(0xFF4A4F4A),
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //       .toList();
                    // },
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.only(left: 8, right: 10),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                                bottom: BorderSide(color: Colors.grey),
                                left: BorderSide(color: Colors.grey),
                                right: BorderSide(color: Colors.grey),
                                top: BorderSide(color: Colors.grey)))),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    menuItemStyleData: MenuItemStyleData(
                      height: 60,
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: textEditingController,
                          onChanged: (value) {
                            setState(() {
                              textEditingController.text = value.toUpperCase();
                              textEditingController.selection = TextSelection.fromPosition(
                                TextPosition(offset: textEditingController.text.length),
                              );
                              getData(search: textEditingController.text.toUpperCase().toString());
                              // url.toString() + value.toString();
                            });
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for Colleges',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value!.toString().contains(searchValue);
                      },
                    ),
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Hero(
                  tag: "cocacola",
                  child: GestureDetector(
                    onTap: () {
                      setClgName();
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              curve: Curves.decelerate,
                              duration: Duration(seconds: 1),
                              child: BottomBar()));
                    },
                    child: Center(
                      child: Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFFE61D2B), borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Submit',
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
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Note: Once you select your college, you won't be able to change it later. After finishing the week 1 then only you can unlock Week 2 task.",
                  // textAlign: TextAlign.justify,
                  style: GoogleFonts.ibmPlexSerif(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
