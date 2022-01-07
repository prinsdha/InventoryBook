import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:product/core/constant/app_settings.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/screen/inventory/controller/invetory_controller.dart';
import 'package:product/ui/shared/custom_textfield.dart';

import '../../../../global.dart';
import 'drop_down2.dart';

class StockRecord extends StatefulWidget {
  const StockRecord({Key? key}) : super(key: key);

  @override
  State<StockRecord> createState() => _StockRecordState();
}

class _StockRecordState extends State<StockRecord> {
  final InventoryController inventoryController =
      Get.find<InventoryController>();

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomAppTextField(
                  textEditingController: inventoryController.search,
                  onEditing: (val) {
                    inventoryController.update();
                  },
                  textFieldType: TextFieldType.searchField),
            ),
            CustomDropDown2(onChanged: (val) async {
              if (val == dayFilterList[3]) {
                await inventoryController.datePick().then((value) {
                  if (value != null) {
                    inventoryController.currentSort = val;
                    return;
                  }
                });
              } else {
                inventoryController.currentSort = val;
              }
            }),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        GetBuilder(
          builder: (InventoryController controller) => Expanded(
            child: inventoryController.allProductDetail.isEmpty
                ? const Center(
                    child: Text("No data found"),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: inventoryController.searchedProduct.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      final productDetail =
                          inventoryController.searchedProduct[index];

                      return Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding, vertical: 7),
                        width: SizeConfig.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffe1e1e1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.20),
                                  blurRadius: 2,
                                  offset: const Offset(0, 3))
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 60,
                              width: 70,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image:
                                          FileImage(File(productDetail.image)),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${productDetail.name} (${productDetail.unit}${productDetail.scale})"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("₹ ${productDetail.actualPrice}"),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Stock",
                                        style:
                                            TextStyle(fontSize: getWidth(12)),
                                      ),
                                      Text(
                                        productDetail.stockUnit.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${DateFormat("d").format(productDetail.dateTime)}${getDayOfMonthSuffix(productDetail.dateTime.day)} ${DateFormat("LLL, h:mma").format(productDetail.dateTime)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: getWidth(10)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
