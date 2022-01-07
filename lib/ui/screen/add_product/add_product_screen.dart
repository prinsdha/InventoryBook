import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/extension/custom_button_extension.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/global.dart';
import 'package:product/ui/screen/add_product/controller/add_product_controller.dart';
import 'package:product/ui/screen/home/home_screen.dart';
import 'package:product/ui/screen/inventory/inventory_screen.dart';
import 'package:product/ui/shared/custom_button.dart';
import 'package:product/ui/shared/custom_dropdown_field.dart';
import 'package:product/ui/shared/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/addProductScreen";

  const AddProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final AddProductController addProductController =
      Get.find<AddProductController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(title: Get.arguments != null ? "Edit Product" : "Add Product"),
      body: Form(
        key: formKey,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            GetBuilder(
              builder: (AddProductController controller) => GestureDetector(
                onTap: () async {
                  disposeKeyboard();
                  controller.pickImage();
                },
                child: Container(
                  height: 140,
                  width: SizeConfig.width,
                  child: addProductController.productImage != null
                      ? Image.file(
                          File(addProductController.productImage!),
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  color: addProductController.productImage != null
                      ? Colors.transparent
                      : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAppTextField(
                      textEditingController: addProductController.itemName,
                      textFieldType: TextFieldType.itemName),
                  Row(
                    children: [
                      Expanded(
                        child: CustomAppTextField(
                            textEditingController:
                                addProductController.actualPrice,
                            textFieldType: TextFieldType.price),
                      ),
                      Expanded(
                        child: CustomAppTextField(
                            validator: (val) => val!.trim().isNotEmpty
                                ? int.parse(val) <
                                        int.parse(addProductController
                                            .actualPrice.text
                                            .trim())
                                    ? null
                                    : "Discounted price less than actual price"
                                : "Field is required",
                            textEditingController:
                                addProductController.discountedPrice,
                            textFieldType: TextFieldType.discountedPrice),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomAppTextField(
                            textEditingController: addProductController.unit,
                            textFieldType: TextFieldType.unit),
                      ),
                      Expanded(
                        child: dropDownLook(
                          CustomDropDownFiled(
                            textEditingController: addProductController.scale,
                            textFieldType: TextFieldType.quantity,
                            list: scaleList,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomAppTextField(
                      textEditingController: addProductController.category,
                      foot: Wrap(
                        spacing: 5,
                        children: fixCategory
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    disposeKeyboard();
                                    addProductController.category.text = e.name;
                                    addProductController.categoryModel = e;
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(),
                                          color: Colors.grey.withOpacity(0.30)),
                                      child: Text(
                                        e.name,
                                        style:
                                            TextStyle(fontSize: getWidth(10)),
                                      )),
                                ))
                            .toList(),
                      ),
                      textFieldType: TextFieldType.category),
                  CustomAppTextField(
                      textEditingController: addProductController.description,
                      textFieldType: TextFieldType.description),
                  Row(
                    children: [
                      Expanded(
                        child: CustomAppTextField(
                            textInputAction: TextInputAction.done,
                            textEditingController:
                                addProductController.stockUnit,
                            textFieldType: TextFieldType.stockUnit),
                      ),
                      Expanded(
                        child: dropDownLook(
                          CustomDropDownFiled(
                            textEditingController: addProductController.scale2,
                            textFieldType: TextFieldType.quantity,
                            list: scaleList,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            CustomButton(
              type: Get.arguments != null
                  ? CustomButtonType.updateProduct
                  : CustomButtonType.addItem,
              onTap: () {
                disposeKeyboard();
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (addProductController.productImage != null) {
                    addProductController.saveDataToModel();
                  } else {
                    flutterToast("Image required");
                  }
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

Widget dropDownLook(Widget child, {double? width}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: AppColor.kFieldFillColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.40),
              offset: const Offset(-2, 2),
              blurRadius: 5)
        ]),
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(8),
    child: child,
  );
}

AppBar appBar({required String title, String? route}) {
  return AppBar(
    leading: route == HomeScreen.routeName
        ? null
        : IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(
        onPressed: () {
          disposeKeyboard();
          Get.toNamed(InventoryScreen.routeName);
        },
        icon: const Icon(
          Icons.error,
        ),
      )
    ],
  );
}
