import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/extension/custom_button_extension.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/screen/add_product/add_product_screen.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';
import 'package:product/ui/screen/home/widget/edit_stock_dialog.dart';
import 'package:product/ui/screen/home/widget/main_list_tile.dart';
import 'package:product/ui/shared/custom_button.dart';
import 'package:product/ui/shared/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: appBar(title: "My Product"),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomAppTextField(
              textEditingController: homeController.search,
              textFieldType: TextFieldType.searchField),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: GetBuilder(
              builder: (HomeController controller) => controller
                      .allProducts.isEmpty
                  ? const Center(child: Text("No data found"))
                  : ListView(
                      children: controller.allProducts
                          .map((key, categoryModel) => MapEntry(
                              key,
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.20),
                                        offset: const Offset(0, 8),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 10),
                                      margin: categoryModel.isExpanded
                                          ? const EdgeInsets.only(bottom: 5)
                                          : null,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.20),
                                              offset: const Offset(0, 8),
                                              blurRadius: 10,
                                              spreadRadius: 1),
                                        ],
                                      ),
                                      child: MainListTile(
                                        categoryModel: categoryModel,
                                      ),
                                    ),
                                    categoryModel.isExpanded
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                                children: categoryModel
                                                    .productDetailModel!
                                                    .map(
                                                      (e) =>
                                                          CustomProductListTile(
                                                        productDetailModel: e,
                                                      ),
                                                    )
                                                    .toList()),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              )))
                          .values
                          .toList()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomButtons(),
    );
  }

  SizedBox bottomButtons() {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                        type: CustomButtonType.shareButton, onTap: () {})),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomButton(
                        type: CustomButtonType.addProduct,
                        onTap: () {
                          Get.toNamed(AddProductScreen.routeName);
                        })),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class CustomProductListTile extends StatelessWidget {
  final ProductDetailModel productDetailModel;
  const CustomProductListTile({
    Key? key,
    required this.productDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) => Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: FileImage(File(productDetailModel.image)),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${productDetailModel.name} (${productDetailModel.unit}${productDetailModel.scale})",
                maxLines: 2,
                style: TextStyle(fontSize: getWidth(14)),
              ),
              Text(
                "₹ ${productDetailModel.actualPrice}",
                style: TextStyle(fontSize: getWidth(14)),
              ),
            ],
          )),
          GestureDetector(
            onTap: () {
              showEditStockDialog(
                  context: context, productDetailModel: productDetailModel);
            },
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.30)),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Stock ",
                        style: TextStyle(
                            color: Colors.black, fontSize: getWidth(13)),
                      ),
                      const Icon(
                        Icons.edit,
                        size: 14,
                      ),
                    ],
                  ),
                  Text(
                    productDetailModel.stockUnit.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 7,
              ),
              Text(
                "(in-stock)",
                style: TextStyle(color: Colors.black, fontSize: getWidth(13)),
              ),
              Switch(
                value: productDetailModel.inStock,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (val) {
                  productDetailModel.inStock = !productDetailModel.inStock;
                  controller.update();
                },
                activeColor: AppColor.kSwitchActive,
                // inactiveTrackColor: AppColor.kSwitchInActive,
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
