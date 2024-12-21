import 'package:coffee_mnue_app/controller/tab_controller.dart';
import 'package:coffee_mnue_app/view/screen/hompage_sceen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTabs extends StatelessWidget {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController inputpricecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MyTabController tabController = Get.find<MyTabController>();

    String? selectedCategory; // متغير لحفظ القسم المختار

    return PageView(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('إضافة قسم أو منتج'),
          ),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
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
                  // اختيار القسم من القائمة المنسدلة
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
                  // إدخال اسم المنتج
                  TextField(
                    controller: productController,
                    decoration: InputDecoration(
                      labelText: 'اسم المنتج',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // إدخال السعر
                  TextField(
                    controller: inputpricecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'أدخل السعر',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (inputpricecontroller.text.isNotEmpty) {
                        double price = double.parse(inputpricecontroller.text);
                        // إضافة المنتج مع السعر
                        if (selectedCategory != null && productController.text.isNotEmpty) {
                          tabController.addProductWithPrice(
                            selectedCategory!,
                            productController.text,
                            price,
                          );
                          productController.clear();
                          inputpricecontroller.clear();
                          // الانتقال إلى صفحة HomePage بعد إضافة المنتج
                          Get.to(() => HomePage());
                        }
                      }
                    },
                    child: Text('إضافة منتج'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
