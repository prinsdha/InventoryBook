import 'package:product/ui/screen/add_product/model/category_model.dart';

class ProductDetailModel {
  CategoryModel categoryModel;
  DateTime dateTime;
  String image, description, name, actualPrice, discountedPrice, scale, scale2;
  int unit, stockUnit;
  bool inStock;

  ProductDetailModel(
      {required this.image,
      required this.scale,
      required this.scale2,
      required this.categoryModel,
      required this.description,
      required this.name,
      required this.actualPrice,
      required this.discountedPrice,
      required this.unit,
      this.inStock = true,
      required this.dateTime,
      required this.stockUnit});
}
