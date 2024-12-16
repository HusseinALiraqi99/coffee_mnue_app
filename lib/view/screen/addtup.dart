import 'package:coffee_mnue_app/controller/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_mnue_app/view/screen/hompage_sceen.dart'; // استيراد الصفحة الرئيسية

class AddTabs extends StatelessWidget {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController productController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MyTabController tabController = Get.find<MyTabController>();

    String? selectedCategory; // متغير لحفظ القسم المختار

    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة قسم أو منتج'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // إدخال اسم القسم
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'اسم القسم',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  tabController.addCategory(categoryController.text);
                  categoryController.clear();
                }
              },
              child: Text('إضافة قسم'),
            ),
            Divider(),
            // اختيار القسم وإدخال المنتج
            Obx(() {
              return DropdownButton<String>(
                isExpanded: true,
                value: selectedCategory,
                hint: Text('اختر القسم'),
                onChanged: (value) {
                  selectedCategory = value; // تحديث القسم المختار
                },
                items: tabController.categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              );
            }),
            TextField(
              controller: productController,
              decoration: InputDecoration(
                labelText: 'اسم المنتج',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedCategory != null && productController.text.isNotEmpty) {
                  tabController.addProduct(selectedCategory!, productController.text);
                  productController.clear();
                  Get.to(() => HomePage());  // الانتقال إلى الصفحة الرئيسية بعد إضافة المنتج
                }
              },
              child: Text('إضافة منتج'),
            ),
          ],
        ),
      ),
    );
  }
}
