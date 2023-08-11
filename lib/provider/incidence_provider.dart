import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IncidenceProvider extends ChangeNotifier {
  TextEditingController grocery1 = TextEditingController();
  TextEditingController grocery2 = TextEditingController();
  TextEditingController ambient1 = TextEditingController();
  TextEditingController ambient2 = TextEditingController();
  TextEditingController counter1 = TextEditingController();
  TextEditingController counter2 = TextEditingController();
  TextEditingController arial1 = TextEditingController();
  TextEditingController arial2 = TextEditingController();
  File? grocery;
  String grocerypath = '';
  String groceryname = '';
  File? ambient;
  String ambientpath = '';
  String ambientname = '';
  File? counter;
  String counterpath = '';
  String countername = '';
  File? arial;
  String arialpath = '';
  String arialname = '';

  Future groceryImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    groceryname = image!.name;
    grocery = File(image.path);
    grocerypath = image.path;
    notifyListeners();
  }

  Future ambientImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    ambientname = image!.name;
    ambient = File(image.path);
    ambientpath = image.path;
    notifyListeners();
  }

  Future counterImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    countername = image!.name;
    counter = File(image.path);
    counterpath = image.path;
    notifyListeners();
  }

  Future arialImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    arialname = image!.name;
    arial = File(image.path);
    arialpath = image.path;
    notifyListeners();
  }
}
