import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/global.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';

class InventoryController extends GetxController {
  DateTime? initDate;

  Future datePick() async {
    return await showDatePicker(
            context: Get.context!,
            initialDate: initDate ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2050))
        .then((value) => initDate = value);
  }

  String? _currentSort;

  String? get currentSort => _currentSort;

  set currentSort(String? value) {
    _currentSort = value;
    update();
  }

  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController search = TextEditingController();
  List<ProductDetailModel> get allProductDetail {
    if (currentSort == dayFilterList[0]) {
      return homeController.listOfProducts
          .where((element) =>
              element.dateTime.isAfter(startDate) &&
              element.dateTime.isBefore(endDate))
          .toList();
    } else if (currentSort == dayFilterList[1]) {
      return homeController.listOfProducts
          .where((element) =>
              element.dateTime.month ==
              DateTime(DateTime.now().year, DateTime.now().month - 1).month)
          .toList();
    } else if (currentSort == dayFilterList[2]) {
      return homeController.listOfProducts
          .where((element) =>
              element.dateTime.year ==
              DateTime(DateTime.now().year - 1, DateTime.now().month).year)
          .toList();
    } else if (currentSort == dayFilterList[3]) {
      return homeController.listOfProducts
          .where((element) => element.dateTime.day == initDate!.day)
          .toList();
    } else {
      return homeController.listOfProducts;
    }
  }

  List<ProductDetailModel> get searchedProduct {
    if (search.text.isNotEmpty && search.text.length > 1) {
      return allProductDetail
          .where((element) =>
              element.name.toLowerCase().contains(search.text.toLowerCase()))
          .toList();
    } else {
      return allProductDetail;
    }
  }
}

DateTime get mostRecentMonday => DateTime(DateTime.now().year,
    DateTime.now().month, DateTime.now().day - (DateTime.now().weekday - 1));
DateTime startDate = mostRecentMonday.subtract(const Duration(days: 8));
DateTime endDate = mostRecentMonday;
