import 'package:coffee_mnue_app/view/screen/addtup.dart';
import 'package:coffee_mnue_app/view/screen/hompage_sceen.dart';
import 'package:coffee_mnue_app/controller/tab_controller.dart'; // استيراد الكنترولر
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // تسجيل الكنترولر هنا
  Get.put(MyTabController()); // تسجيل MyTabController قبل تشغيل التطبيق

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/addtabs',
      getPages: [
        GetPage(name: '/addtabs', page: () => AddTabs()),
        GetPage(name: '/homepage', page: () => HomePage()),
      ],
    );
  }
}
