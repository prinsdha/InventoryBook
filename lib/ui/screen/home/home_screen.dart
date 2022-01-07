import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/extension/custom_button_extension.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/screen/add_product/add_product_screen.dart';
import 'package:product/ui/screen/add_product/model/product_detail_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';
import 'package:product/ui/screen/home/widget/edit_stock_dialog.dart';
import 'package:product/ui/screen/home/widget/main_list_tile.dart';
import 'package:product/ui/shared/custom_button.dart';
import 'package:product/ui/shared/custom_textfield.dart';
import 'package:product/ui/shared/doubleTaptoback.dart';
import 'package:share_plus/share_plus.dart';

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
    return DoubleBackToCloseApp(
      child: GestureDetector(
        onTap: () {
          disposeKeyboard();
        },
        child: Scaffold(
          appBar: appBar(title: "My Product", route: HomeScreen.routeName),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomAppTextField(
                  onEditing: (val) {
                    Get.find<HomeController>().update();
                  },
                  textEditingController: homeController.search,
                  textFieldType: TextFieldType.searchField),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GetBuilder(
                  builder: (HomeController controller) => controller
                          .searchedProduct.isEmpty
                      ? const Center(child: Text("No data found"))
                      : ListView(
                          physics: const BouncingScrollPhysics(),
                          children: controller.searchedProduct
                              .map((key, categoryModel) => MapEntry(
                                  key,
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.20),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Column(
                                                    children: categoryModel
                                                        .productDetailModel!
                                                        .asMap()
                                                        .map((key, value) =>
                                                            MapEntry(
                                                                key,
                                                                customProductListTile(
                                                                  productDetailModel:
                                                                      value,
                                                                  index: key,
                                                                )))
                                                        .values
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
        ),
      ),
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
                    type: CustomButtonType.shareButton,
                    onTap: () {
                      disposeKeyboard();
                      if (homeController.searchedProduct.isNotEmpty) {
                        String shareNote = "";
                        homeController.searchedProduct.forEach((key, value) {
                          int i = 0;
                          String str = "$key\n";
                          for (var e in value.productDetailModel!) {
                            i += 1;
                            str = str +
                                "($i)${e.name}(${e.unit}${e.scale})\nprice:${e.discountedPrice}\nstock:${e.stockUnit}${e.scale2}\n";
                          }
                          shareNote = shareNote + str + "\n";
                        });
                        Share.share(shareNote);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                      type: CustomButtonType.addProduct,
                      onTap: () {
                        disposeKeyboard();
                        Get.toNamed(AddProductScreen.routeName);
                      }),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget customProductListTile(
      {required ProductDetailModel productDetailModel, required int index}) {
    return GetBuilder(
      builder: (HomeController controller) => GestureDetector(
        onTap: () {
          Get.toNamed(AddProductScreen.routeName,
              arguments: [productDetailModel, index]);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
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
                    context: context,
                    productDetailModel: productDetailModel,
                  );
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
                    style:
                        TextStyle(color: Colors.black, fontSize: getWidth(13)),
                  ),
                  Switch(
                    value: productDetailModel.inStock,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (val) {
                      if (val) {
                        showEditStockDialog(
                          context: context,
                          productDetailModel: productDetailModel,
                        );
                      } else {
                        productDetailModel.inStock = false;
                        productDetailModel.stockUnit = 0;
                      }

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
        ),
      ),
    );
  }
}
