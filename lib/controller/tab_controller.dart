import 'package:get/get.dart';

class MyTabController extends GetxController {
  // قائمة الأقسام
  var categories = <String>[].obs;

  // خريطة لربط كل قسم بالمنتجات
  var categoryProducts = <String, List<String>>{}.obs;

  // خريطة لربط كل منتج بسعره
  var productPrices = <String, double>{}.obs;

  // إضافة قسم جديد
  void addCategory(String category) {
    if (category.isNotEmpty && !categories.contains(category)) {
      categories.add(category);
      categoryProducts[category] = [];
    }
  }

  // إضافة منتج مع السعر إلى قسم معين
  void addProductWithPrice(String category, String product, double price) {
    if (product.isNotEmpty && categoryProducts.containsKey(category)) {
      categoryProducts[category]!.add(product);
      productPrices[product] = price;  // تخزين السعر الخاص بالمنتج
    }
  }



}
