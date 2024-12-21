import 'package:coffee_mnue_app/controller/tab_controller.dart';
import 'package:coffee_mnue_app/view/screen/ListPage_screen.dart';
import 'package:coffee_mnue_app/view/screen/addtup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyTabController tabController = Get.find<MyTabController>();

    return Obx(() {
      return DefaultTabController(
        length: tabController.categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('عرض الأقسام والمنتجات'),
            bottom: tabController.categories.isNotEmpty
                ? TabBar(
                    tabs: tabController.categories
                        .map((category) => Tab(text: category))
                        .toList(),
                  )
                : null,
          ),
          body: tabController.categories.isNotEmpty
              ? TabBarView(
                  children: tabController.categories.map((category) {
                    final products =
                        tabController.categoryProducts[category] ?? [];
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        String product = products[index];
                        double productPrice =
                            tabController.productPrices[product] ?? 0.0;
                        return ListTile(
                          title: Container(
                            color: Colors.amber,
                            width: 200, // تحديد عرض الـ Container
                            height: 100, // تحديد ارتفاع الـ Container
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start, // محاذاة العناصر بدايةً
                              crossAxisAlignment: CrossAxisAlignment.center, // محاذاة العناصر عموديًا في الوسط
                              children: [
                                Text(product), // عرض اسم المنتج
                                Padding(
                                  padding: const EdgeInsets.only(left: 50), // إضافة مسافة بين المنتج والسعر
                                  child: Text(
                                    "السعر: $productPrice", // عرض السعر المرتبط بالمنتج
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    // عند الضغط على الزر، نضيف المنتج مع السعر
                                    Get.snackbar(
                                      "تم إضافة المنتج",
                                      "تم إضافة المنتج $product بسعر $productPrice",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                  child: Text('إضافة'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Center(
                  child: Text('لا توجد أقسام. قم بإضافة قسم.'),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // الانتقال إلى صفحة إضافة المنتجات
              Get.to(() => AddTabs());
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: tabController.categoryProducts.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // الانتقال إلى صفحة القائمة بعد إضافة عدد معين من المنتجات
                      if (tabController.categoryProducts.isNotEmpty) {
                        Get.to(() => ListPage());
                      }
                    },
                    child: Text('القائمة'),
                  ),
                )
              : null,
        ),
      );
    });
  }
}
