import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/configs/routes.dart';

void main() {
  Get.put(CartController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      //debugShowCheckedModeBanner: false,
      //home: LoginScreen(),
    ),
  );
}
