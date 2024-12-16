import 'package:get/get.dart';

class MyTabController  extends GetxController {
  // قائمة الأقسام
  var categories = <String>[].obs;

  // خريطة لربط كل قسم بالمنتجات
  var categoryProducts = <String, List<String>>{}.obs;

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
    }
  }
}
