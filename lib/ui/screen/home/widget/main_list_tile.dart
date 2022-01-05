import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/screen/add_product/model/category_model.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';

class MainListTile extends StatelessWidget {
  final CategoryModel categoryModel;
  const MainListTile({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) => Row(
        children: [
          Container(
            height: 60,
            width: SizeConfig.width * 0.60,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(50), left: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.30),
                      offset: const Offset(-2, 2),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(categoryModel.image))),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "${categoryModel.name}\n(${categoryModel.productDetailModel!.length})",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              categoryModel.isExpanded = !categoryModel.isExpanded;
              controller.update();
            },
            icon: RotatedBox(
                quarterTurns: categoryModel.isExpanded ? 3 : 1,
                child: const Icon(Icons.arrow_forward_ios_outlined)),
          )
        ],
      ),
    );
  }
}
