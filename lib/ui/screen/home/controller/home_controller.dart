import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';

class HomeController extends GetxController {
  final TextEditingController search = TextEditingController();
  final TextEditingController unitUpdate = TextEditingController();
  final TextEditingController scale = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime _initDate = DateTime.now();

  DateTime get initDate => _initDate;

  set initDate(DateTime value) {
    _initDate = value;
    update();
  }

  Map<String, CategoryModel> allProducts = {};

  Future datePick() async {
    await showDatePicker(
            context: Get.context!,
            initialDate: initDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2050))
        .then((value) => initDate = value!)
        .catchError((e) {});
  }
}
