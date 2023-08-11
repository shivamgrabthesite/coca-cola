import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PriceProvider extends ChangeNotifier {
  TextEditingController brand1 = TextEditingController();
  TextEditingController brand2 = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController pack1 = TextEditingController();
  TextEditingController pack2 = TextEditingController();
  File? brand;
  String brandpath = '';
  String brandname = '';
  File? price;
  String pricepath = '';
  String pricename = '';
  File? pack;
  String packpath = '';
  String packname = '';

  Future brandImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    brandname = image!.name;
    brand = File(image.path);
    brandpath = image.path;
    notifyListeners();
  }

  Future priceImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    pricename = image!.name;
    price = File(image.path);
    pricepath = image.path;
    notifyListeners();
  }

  Future packImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    packname = image!.name;
    pack = File(image.path);
    packpath = image.path;
    notifyListeners();
  }
}
