import 'package:product/ui/screen/add_product/model/product_detail_model.dart';

class CategoryModel {
  final String name;
  final String image;
  bool isExpanded;
  List<ProductDetailModel>? productDetailModel;

  CategoryModel(
      {required this.name,
      required this.image,
      this.productDetailModel,
      this.isExpanded = false});
}
