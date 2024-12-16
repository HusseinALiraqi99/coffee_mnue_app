import 'package:coffee_mnue_app/controller/tab_controller.dart';
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
                    final products = tabController.categoryProducts[category] ?? [];
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        String product = products[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      tabController.decrementProductCount(product);
                                    },
                                  ),
                                  // استخدام Obx لربط العداد بالواجهة
                                  Obx(() {
                                    return Text('${tabController.productCounts[product] ?? 0}');
                                  }),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      tabController.incrementProductCount(product);
                                    },
                                  ),
                                ],
                              ),
                            ],
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
        ),
      );
    });
  }
}
