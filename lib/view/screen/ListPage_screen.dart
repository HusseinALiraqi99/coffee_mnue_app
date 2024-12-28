import 'package:coffee_mnue_app/view/screen/Table%20number-screen.dart';
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
        return Column(
          children: [
            ElevatedButton(
              onPressed: () => _showTableDialog(context, tabController),
              child: Text('إضافة رقم الطاولة'),
            ),
            Expanded(
              child: Obx(() {
                // عرض قائمة الطاولات كأزرار
                var tableNumbers = tabController.tableNumbers;
                if (tableNumbers.isEmpty) {
                  return Center(child: Text('لا توجد طاولات مضافة.'));
                }
                return ListView.builder(
                  itemCount: tableNumbers.length,
                  itemBuilder: (context, index) {
                    String tableNumber = tableNumbers[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TableNumberPage(
                                tableNumber: tableNumber,
                                productDetails:
                                    tabController.getProductDetails(),
                              ));
                        },
                        child: Container(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'رقم الطاولة: $tableNumber',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  void _showTableDialog(BuildContext context, MyTabController tabController) {
    TextEditingController tableController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('أدخل رقم الطاولة'),
          content: TextField(
            controller: tableController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'رقم الطاولة'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                String tableNumber = tableController.text.trim();
                if (tableNumber.isNotEmpty) {
                  tabController.addTableNumber(tableNumber);
                  Navigator.of(context).pop();
                }
              },
              child: Text('إضافة'),
            ),
          ],
        );
      },
    );
  }
}
