import 'package:get/get.dart';
import 'package:product/ui/screen/add_product/controller/add_product_controller.dart';
import 'package:product/ui/screen/home/controller/home_controller.dart';
import 'package:product/ui/screen/inventory/controller/invetory_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController(),
        fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<InventoryController>(() => InventoryController(), fenix: true);
  }
}
