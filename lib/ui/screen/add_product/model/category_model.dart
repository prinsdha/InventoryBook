import 'package:product/ui/screen/add_product/model/product_detail_model.dart';

class CategoryModel {
  final String name;
  final String image;
  String? searchText;

  bool isExpanded;
  List<ProductDetailModel>? productDetailModel;

  CategoryModel(
      {required this.name,
      this.searchText,
      required this.image,
      this.productDetailModel,
      this.isExpanded = false});
}
