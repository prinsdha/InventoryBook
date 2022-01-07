import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/utils/app_function.dart';

import 'package:product/ui/screen/inventory/controller/invetory_controller.dart';
import 'package:product/ui/screen/inventory/widget/stock_record.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);
  static const String routeName = "/inventoryScreen";

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  final InventoryController inventoryController =
      Get.find<InventoryController>();
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        appBar: appBarPro(),
        body: TabBarView(
          controller: tabController,
          children: [
            const StockRecord(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

  AppBar appBarPro() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      centerTitle: true,
      title: const Text("Inventory"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          isScrollable: true,
          unselectedLabelColor: Colors.white,
          indicator: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          indicatorPadding:
              const EdgeInsets.only(top: 10, bottom: 10.0, left: 8, right: 8),
          tabs: ["Stock Record", "Sales Analysis", "Inward Bills"]
              .map(
                (e) => Tab(
                  text: e,
                ),
              )
              .toList()),
    );
  }
}
