import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyTabController extends GetxController {
  // قائمة الأقسام
  var categories = <String>[].obs;

  // خريطة لربط كل قسم بالمنتجات
  var categoryProducts = <String, List<String>>{}.obs;

  // خريطة لربط كل منتج بعداده
  var productCounts = <String, int>{}.obs;

  // إضافة قسم جديد
  void addCategory(String category) {
    if (category.isNotEmpty && !categories.contains(category)) {
      categories.add(category);
      categoryProducts[category] = [];
    }
  }

  // إضافة منتج إلى قسم معين
  void addProduct(String category, String product) {
    if (product.isNotEmpty && categoryProducts.containsKey(category)) {
      categoryProducts[category]!.add(product);
      productCounts[product] = 0;  // إضافة عداد لكل منتج جديد
    }
  }

  // زيادة العداد للمنتج
  void incrementProductCount(String product) {
    if (productCounts.containsKey(product)) {
      productCounts[product] = productCounts[product]! + 1;
    }
  }

  // تقليل العداد للمنتج
  void decrementProductCount(String product) {
    if (productCounts.containsKey(product) && productCounts[product]! > 0) {
      productCounts[product] = productCounts[product]! - 1;
    }
  }
}
