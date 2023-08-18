// import 'dart:io';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:universal_io/io.dart';
import 'package:file_picker/file_picker.dart';
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

  List<PlatformFile>? groceryList;
  List<PlatformFile>? ambientList;
  List<PlatformFile>? counterList;
  List<PlatformFile>? arialList;

  Future groceryImage() async {
    groceryList = (await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print("status of file-----" + status.toString()),
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    ))
        ?.files;
    // var image = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    // );
    // groceryname = image!.name;
    // grocery = File(image.path);
    // grocerypath = image.path;
    notifyListeners();
  }

  Future ambientImage() async {
    ambientList = (await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print("status of file-----" + status.toString()),
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    ))
        ?.files;
    // var image = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    // );
    // ambientname = image!.name;
    // ambient = File(image.path);
    // ambientpath = image.path;
    notifyListeners();
  }

  Future counterImage() async {
    counterList = (await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print("status of file-----" + status.toString()),
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    ))
        ?.files;
    // var image = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    // );
    // countername = image!.name;
    // counter = File(image.path);
    // counterpath = image.path;
    notifyListeners();
  }

  Future arialImage() async {
    arialList = (await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print("status of file-----" + status.toString()),
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    ))
        ?.files;
    // var image = await ImagePicker().pickImage(
    //   source: ImageSource.camera,
    // );
    // arialname = image!.name;
    // arial = File(image.path);
    // arialpath = image.path;
    notifyListeners();
  }
}
