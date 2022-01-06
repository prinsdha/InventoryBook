import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';

class HomeController extends GetxController {
  final TextEditingController search = TextEditingController();
  final TextEditingController unitUpdate = TextEditingController();
  final TextEditingController scale = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map<String, CategoryModel> allProducts = {};
  List<ProductDetailModel> get listOfProducts {
    List<ProductDetailModel> list = [];

    allProducts.forEach((key, value) {
      list.addAll(value.productDetailModel!.map((e) => e));
    });
    return list;
  }

  Map<String, CategoryModel> get searchedProduct {
    if (search.text.isNotEmpty && search.text.length > 1) {
      Map<String, CategoryModel> searchProduct = {};

      allProducts.forEach((key, value) {
        if (value.searchText!
            .toLowerCase()
            .contains(search.text.trim().toLowerCase())) {
          searchedProduct.putIfAbsent(key, () => value);
        }
      });
      return searchProduct;
    } else {
      return allProducts;
    }
  }

  Future<DateTime?> datePick(DateTime dateTime) async {
    return await showDatePicker(
            context: Get.context!,
            initialDate: dateTime,
            firstDate: DateTime(2020),
            lastDate: DateTime(2050))
        .then((value) => value);
  }
}
