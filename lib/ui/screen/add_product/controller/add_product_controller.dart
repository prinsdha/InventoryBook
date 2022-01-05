import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/global.dart';
import 'package:product/main.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';
import 'package:product/ui/screen/home/home_screen.dart';

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

  saveDataToModel() {
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
        categoryModel: categoryModel);
    if (!homeController.allProducts.containsKey(categoryModel.name)) {
      homeController.allProducts.putIfAbsent(
          categoryModel.name,
          () => CategoryModel(
              name: categoryModel.name,
              image: categoryModel.image,
              productDetailModel: [productDetailModel]));
    } else {
      homeController.allProducts.update(categoryModel.name, (value) {
        List<ProductDetailModel> list = value.productDetailModel ?? [];
        for (var element in list) {
          if (element.name.toLowerCase() !=
              productDetailModel.name.toLowerCase()) {
            list.add(productDetailModel);
            break;
          } else {
            flutterToast("Item already present");
            break;
          }
        }
        value.productDetailModel = list;
        return value;
      });
    }
    homeController.update();
    Get.back();
  }

  @override
  void onInit() {
    scale.text = scaleList[0];
    scale2.text = scaleList[0];
    categoryModel = fixCategory[0];
    category.text = categoryModel.name;
    super.onInit();
  }
}
