import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/extension/custom_button_extension.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/global.dart';
import 'package:product/main.dart';
import 'package:product/ui/screen/add_product/controller/add_product_controller.dart';
import 'package:product/ui/screen/home/home_screen.dart';
import 'package:product/ui/screen/inventory/inventory_screen.dart';
import 'package:product/ui/shared/custom_button.dart';
import 'package:product/ui/shared/custom_textfield.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = "/addProductScreen";
  final AddProductController addProductController =
      Get.find<AddProductController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        appBar: appBar(title: "Add Product"),
        body: Form(
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              GetBuilder(
                builder: (AddProductController controller) => GestureDetector(
                  onTap: () async {
                    disposeKeyboard();
                    controller.pickImage();
                  },
                  child: Container(
                    height: 70,
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
                                      addProductController.category.text =
                                          e.name;
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(),
                                            color:
                                                Colors.grey.withOpacity(0.30)),
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
                              textEditingController:
                                  addProductController.scale2,
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
                type: CustomButtonType.addItem,
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

AppBar appBar({required String title}) {
  return AppBar(
    leading: IconButton(
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
          Get.toNamed(InventoryScreen.routeName);
        },
        icon: const Icon(
          Icons.error,
        ),
      )
    ],
  );
}

class CustomDropDownFiled extends StatefulWidget {
  const CustomDropDownFiled(
      {Key? key,
      required this.textFieldType,
      required this.textEditingController,
      required this.list,
      this.labelToHint = false,
      this.selectedValue,
      this.hint,
      this.onChanged})
      : super(key: key);
  final TextFieldType textFieldType;
  final TextEditingController textEditingController;
  final List<String> list;
  final bool labelToHint;
  final String? selectedValue;
  final String? hint;
  final Function(dynamic value)? onChanged;

  @override
  State<CustomDropDownFiled> createState() => _CustomDropDownFiledState();
}

class _CustomDropDownFiledState extends State<CustomDropDownFiled> {
  String? currentSelectedValue;
  @override
  void initState() {
    if (widget.selectedValue != null) {
      currentSelectedValue = widget.selectedValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero
                .copyWith(left: 10, right: 10, top: 7, bottom: 7),
            labelText: widget.labelToHint ? null : getLabelText(),
            enabledBorder: inputBorder(),
            disabledBorder: inputBorder(),
            labelStyle: inputTextStyle(),
            border: inputBorder(),
            focusedBorder: inputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget.hint ?? widget.list[0],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              value: currentSelectedValue,
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.arrow_back_ios)),
              ),
              style: inputTextStyle(),
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  currentSelectedValue = newValue;
                  widget.textEditingController.text = newValue!;
                });
              },
              items: widget.list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  TextStyle inputTextStyle() {
    return TextStyle(color: Colors.black, fontSize: getWidth(14));
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.black, width: 1));
  }

  String getLabelText() {
    switch (widget.textFieldType) {
      case TextFieldType.quantity:
        return "Quantity";

      default:
        return "";
    }
  }
}
