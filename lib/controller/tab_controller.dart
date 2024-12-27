import 'package:get/get.dart';

class MyTabController extends GetxController {
  // قائمة الأقسام
  var categories = <String>[].obs;

  // خريطة لربط كل قسم بالمنتجات
  var categoryProducts = <String, List<String>>{}.obs;

  // خريطة لربط كل منتج بسعره
  var productPrices = <String, double>{}.obs;

  // خريطة لربط كل منتج بسعره المعدل
  var productModifiedPrices = <String, RxDouble>{}.obs;

  // خريطة لربط كل منتج بعدد الإضافات
  var productAddCounts = <String, RxInt>{}.obs;

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
      productPrices[product] = price;
      productModifiedPrices[product] = (price * 1.0).obs;  // السعر المعدل يبدأ بنفس السعر المدخل
      productAddCounts[product] = 1.obs;  // عدد الإضافات يبدأ من 1
    }
  }

  // زيادة السعر المعدل
  void increaseModifiedPrice(String product) {
    if (productModifiedPrices.containsKey(product)) {
      double currentPrice = productModifiedPrices[product]!.value;
      productModifiedPrices[product]!.value = currentPrice * 2;  // زيادة السعر المعدل
      productAddCounts[product]!.value++;  // زيادة عدد الإضافات
    }
  }

  // تقليل السعر المعدل
  void decreaseModifiedPrice(String product) {
    if (productModifiedPrices.containsKey(product)) {
      double currentPrice = productModifiedPrices[product]!.value;
      productModifiedPrices[product]!.value = (currentPrice / 2).clamp(0.0, double.infinity);  // تقليل السعر المعدل
      productAddCounts[product]!.value = (productAddCounts[product]!.value - 1).clamp(0, 999);  // تقليل عدد الإضافات
    }
  }
}
