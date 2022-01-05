import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/constant/app_settings.dart';
import 'package:product/core/extension/custom_button_extension.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/screen/add_product/add_product_screen.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';
import 'package:product/ui/shared/custom_button.dart';
import 'package:product/ui/shared/custom_textfield.dart';

import '../../../../global.dart';

Future showEditStockDialog(
    {required BuildContext context,
    required ProductDetailModel productDetailModel}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: FittedBox(
          child: GetBuilder(
            builder: (HomeController controller) {
              controller.unitUpdate.text =
                  productDetailModel.stockUnit.toString();
              return Container(
                width: SizeConfig.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Update your stock",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getWidth(20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "${DateFormat("EEE, MMMM d, yyyy").format(controller.initDate)}\n${DateFormat("hh:mm a").format(controller.initDate)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                controller.datePick();
                              },
                              child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(Icons.calendar_today))),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomAppTextField(
                                onEditing: (val) {
                                  if (val != null) {
                                    productDetailModel.stockUnit =
                                        int.parse(val);
                                  }
                                },
                                textEditingController: controller.unitUpdate,
                                wantBorder: false,
                                textFieldType: TextFieldType.unit),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: 100,
                            child: CustomDropDownFiled(
                              textFieldType: TextFieldType.quantity,
                              textEditingController: controller.scale,
                              list: scaleList,
                              labelToHint: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                          type: CustomButtonType.update,
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.formKey.currentState!.save();
                            }
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class PopUpContent extends StatelessWidget {
  const PopUpContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
