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

  final TextEditingController search = TextEditingController();

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
                  textEditingController: search,
                  textFieldType: TextFieldType.searchField),
            ),
            CustomDropDown2(onChanged: (val) {
              if (val.toString() == dayFilterList[3]) {
                inventoryController.datePick();
              }
            }),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            padding: const EdgeInsets.symmetric(vertical: 15),
            itemBuilder: (context, index) => Container(
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
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Apple (1kg)"),
                      SizedBox(
                        height: 5,
                      ),
                      Text("\$ 100"),
                    ],
                  ),
                  const Spacer(),
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
                              style: TextStyle(fontSize: getWidth(12)),
                            ),
                            const Text(
                              "70",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${DateFormat("d").format(dateTime)}${getDayOfMonthSuffix(dateTime.day)} ${DateFormat("LLL, h:mma").format(dateTime)}",
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
            ),
          ),
        )
      ],
    );
  }
}
