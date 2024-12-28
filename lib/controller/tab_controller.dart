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

 // زيادة السعر المعدل بشكل 1000، 2000، 3000، 4000
  void increaseModifiedPrice(String product) {
    if (productModifiedPrices.containsKey(product)) {
      int addCount = productAddCounts[product]!.value;
      double currentPrice = productPrices[product] ?? 0.0;
      productModifiedPrices[product]!.value = currentPrice *
          (addCount + 1); // زيادة السعر المعدل بناءً على عدد الإضافات
      productAddCounts[product]!.value++; // زيادة عدد الإضافات
    }
  }


  // تقليل السعر المعدل بشكل 1000، 2000، 3000، 4000
  void decreaseModifiedPrice(String product) {
    if (productModifiedPrices.containsKey(product)) {
      int addCount = productAddCounts[product]!.value;
      double currentPrice = productPrices[product] ?? 0.0;

      // التأكد من أن السعر المعدل لا يصبح أقل من السعر الأصلي
      double newPrice = currentPrice * (addCount - 1);
      if (newPrice >= currentPrice) {
        productModifiedPrices[product]!.value =
            newPrice; // تقليل السعر المعدل بناءً على عدد الإضافات
        productAddCounts[product]!.value--; // تقليل عدد الإضافات
      }
    }
  }
  var tableNumbers = <String>[].obs; // قائمة أرقام الطاولات

  void addTableNumber(String tableNumber) {
    if (!tableNumbers.contains(tableNumber)) {
      tableNumbers.add(tableNumber);
    }
  }
  List<Map<String, dynamic>> getProductDetails() {
    return productPrices.keys.map((product) {
      return {
        'name': product,
        'price': productPrices[product] ?? 0.0,
        'modifiedPrice': productModifiedPrices[product]?.value ?? 0.0,
        'addCount': productAddCounts[product]?.value ?? 0,
      };
    }).toList();
  }
}
