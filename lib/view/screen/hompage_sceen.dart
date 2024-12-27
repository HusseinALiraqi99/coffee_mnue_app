import 'package:coffee_mnue_app/view/screen/addtup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_mnue_app/controller/tab_controller.dart';
import 'package:coffee_mnue_app/view/screen/ListPage_screen.dart';

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
                        RxDouble modifiedPrice =
                            tabController.productModifiedPrices[product]!;
                        RxInt addCount = tabController.productAddCounts[product]!;

                        return ListTile(
                          title: Container(
                            color: Colors.amber,
                            width: 200,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(product),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Column(
                                    children: [
                                      Text(
                                        "السعر الثابت: $productPrice",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              tabController.decreaseModifiedPrice(product);
                                            },
                                          ),
                                          Obx(() => Text(
                                                "السعر المعدل: ${modifiedPrice.value} | عدد الإضافات: ${addCount.value}",
                                                style: TextStyle(fontSize: 16),
                                              )),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              tabController.increaseModifiedPrice(product);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.snackbar(
                                      "تم إضافة المنتج",
                                      "تم إضافة المنتج $product بسعر $productPrice مع السعر المعدل ${modifiedPrice.value} وعدد الإضافات ${addCount.value}",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );

                                    tabController.addProductWithPrice(category, product, modifiedPrice.value);
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
