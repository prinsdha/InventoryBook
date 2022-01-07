import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/global.dart';
import 'package:product/main.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';

class AddProductController extends GetxController {
  String? _productImage;

  String? get productImage => _productImage;

  set productImage(String? value) {
    _productImage = value;
    update();
  }

  final TextEditingController itemName = TextEditingController();
  final TextEditingController actualPrice = TextEditingController();
  final TextEditingController discountedPrice = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController scale = TextEditingController();
  final TextEditingController scale2 = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController stockUnit = TextEditingController();
  late CategoryModel categoryModel;

  pickImage() async {
    await appImagePicker.openBottomSheet();
    if (appImagePicker.imagePickerController.image != "") {
      productImage = appImagePicker.imagePickerController.image;
    }
    appImagePicker.imagePickerController.resetImage();
  }

  HomeController homeController = Get.find<HomeController>();
  late ProductDetailModel productDetailModel;

  void saveDataToModel() {
    disposeKeyboard();
    productDetailModel = ProductDetailModel(
        image: productImage!,
        description: description.text.trim(),
        name: itemName.text.trim(),
        actualPrice: actualPrice.text.trim(),
        discountedPrice: discountedPrice.text.trim(),
        unit: int.parse(unit.text.trim()),
        stockUnit: int.parse(stockUnit.text.trim()),
        scale2: scale2.text.trim(),
        scale: scale.text.trim(),
        categoryModel: categoryModel,
        dateTime: DateTime.now());
    if (Get.arguments != null) {
      ProductDetailModel data = Get.arguments[0];
      homeController.allProducts[data.categoryModel.name]!
          .productDetailModel![Get.arguments[1]] = productDetailModel;
      Get.back();
    } else {
      if (!homeController.allProducts.containsKey(categoryModel.name)) {
        homeController.allProducts.putIfAbsent(
            categoryModel.name,
            () => CategoryModel(
                name: categoryModel.name,
                searchText: productDetailModel.name,
                image: categoryModel.image,
                productDetailModel: [productDetailModel]));
      } else {
        homeController.allProducts.update(categoryModel.name, (value) {
          List<ProductDetailModel> list = value.productDetailModel ?? [];
          String str = value.searchText ?? "";
          for (var element in list) {
            if (element.name.toLowerCase() !=
                productDetailModel.name.toLowerCase()) {
              str = str + " ${productDetailModel.name}";
              list.add(productDetailModel);
              Get.back();
              break;
            } else {
              flutterToast("Item already present");
              break;
            }
          }
          value.productDetailModel = list;
          value.searchText = str;
          return value;
        });
      }
    }
    homeController.update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      productDetailModel = Get.arguments[0];
      scale.text = productDetailModel.scale;
      scale2.text = productDetailModel.scale2;
      categoryModel = productDetailModel.categoryModel;
      category.text = productDetailModel.categoryModel.name;
      productImage = productDetailModel.image;
      actualPrice.text = productDetailModel.actualPrice;
      discountedPrice.text = productDetailModel.discountedPrice;
      unit.text = productDetailModel.unit.toString();
      stockUnit.text = productDetailModel.stockUnit.toString();
      description.text = productDetailModel.description;
      itemName.text = productDetailModel.name;
    } else {
      scale.text = scaleList[0];
      scale2.text = scaleList[0];
      categoryModel = fixCategory[0];
      category.text = categoryModel.name;
    }
    super.onInit();
  }
}
