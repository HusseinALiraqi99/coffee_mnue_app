import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_mnue_app/controller/tab_controller.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyTabController tabController = Get.find<MyTabController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المنتجات المضافة'),
      ),
      body: Obx(() {
        var products = tabController.productPrices.keys.toList();
        if (products.isEmpty) {
          return Center(child: Text('لا توجد منتجات مضافة بعد.'));
        }
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            String product = products[index];
            double price = tabController.productPrices[product] ?? 0.0;
            double modifiedPrice = tabController.productModifiedPrices[product]!.value;
            int addCount = tabController.productAddCounts[product]!.value;

            return ListTile(
              title: Container(
                color: Colors.amber,
                width: double.infinity,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(product, style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("السعر المدخل: $price", style: TextStyle(fontSize: 16)),
                        Text("السعر المعدل: $modifiedPrice", style: TextStyle(fontSize: 16)),
                        Text("عدد الإضافات: $addCount", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
