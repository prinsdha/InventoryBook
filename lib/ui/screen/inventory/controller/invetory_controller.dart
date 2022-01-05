import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
  DateTime? _initDate;

  DateTime? get initDate => _initDate;

  set initDate(DateTime? value) {
    _initDate = value;
    update();
  }

  Future datePick() async {
    try {
      await showDatePicker(
              context: Get.context!,
              initialDate: initDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2050))
          .then((value) => initDate = value!);
    } on Exception catch (e) {}
  }
}
