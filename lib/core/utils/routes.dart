import 'package:get/get.dart';
import 'package:product/ui/screen/add_product/add_product_screen.dart';
import 'package:product/ui/screen/home/home_screen.dart';
import 'package:product/ui/screen/inventory/inventory_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
      name: AddProductScreen.routeName, page: () => const AddProductScreen()),
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  GetPage(name: InventoryScreen.routeName, page: () => const InventoryScreen()),
];
