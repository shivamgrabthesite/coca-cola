import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PopulationProvider extends ChangeNotifier {
  TextEditingController dps1 = TextEditingController();
  TextEditingController dps2 = TextEditingController();
  TextEditingController cooler1 = TextEditingController();
  TextEditingController cooler2 = TextEditingController();
  TextEditingController standee1 = TextEditingController();
  TextEditingController standee2 = TextEditingController();
  TextEditingController vertical1 = TextEditingController();
  TextEditingController vertical2 = TextEditingController();
  TextEditingController oneway1 = TextEditingController();
  TextEditingController oneway2 = TextEditingController();
  TextEditingController vinyl1 = TextEditingController();
  TextEditingController vinyl2 = TextEditingController();
  File? dps;
  String dpspath = '';
  String dpsname = '';
  File? cooler;
  String coolerpath = '';
  String coolername = '';
  File? standee;
  String standeepath = '';
  String standeename = '';
  File? vertical;
  String verticalpath = '';
  String verticalname = '';
  File? oneway;
  String onewaypath = '';
  String onewayname = '';
  File? vinyl;
  String vinylpath = '';
  String vinylname = '';

  Future dpsImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    dpsname = image!.name;
    dps = File(image.path);
    dpspath = image.path;
    notifyListeners();
  }

  Future coolerImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    coolername = image!.name;
    cooler = File(image.path);
    coolerpath = image.path;
    notifyListeners();
  }

  Future standeeImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    standeename = image!.name;
    standee = File(image.path);
    standeepath = image.path;
    notifyListeners();
  }

  Future verticalImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    verticalname = image!.name;
    vertical = File(image.path);
    verticalpath = image.path;
    notifyListeners();
  }

  Future onewayImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    onewayname = image!.name;
    oneway = File(image.path);
    onewaypath = image.path;
    notifyListeners();
  }

  Future vinylImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    vinylname = image!.name;
    vinyl = File(image.path);
    vinylpath = image.path;
    notifyListeners();
  }
}
