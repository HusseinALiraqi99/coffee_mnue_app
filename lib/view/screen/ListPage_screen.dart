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
        // إذا كانت هناك منتجات مضافة
        var products = tabController.productPrices.keys.toList();
        if (products.isEmpty) {
          return Center(child: Text('لا توجد منتجات مضافة بعد.'));
        }
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            String product = products[index];
            double price = tabController.productPrices[product] ?? 0.0;
            return ListTile(
              title: Container(
                color: Colors.amber,
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(product, style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Text("السعر: $price", style: TextStyle(fontSize: 16)),
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
