import 'package:get/get.dart';
import 'package:flutter_application_1/view/homescreen.dart';
import 'package:flutter_application_1/view/signup.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/view/dashboard.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/view/profile.dart';
import 'package:flutter_application_1/view/clothes.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => const LoginScreen()),
  GetPage(name: '/signup', page: () => const SignupScreen()),
  GetPage(name: '/dashboard', page: () => const HomeScreen()),
  GetPage(name: '/homescreen', page: () => const HomeScreen()),
  GetPage(name: '/clothes', page: () => const Clothes()),
  GetPage(name: '/cart', page: () => const CartScreen()),
  GetPage(name: '/profile', page: () => const ProfileScreen()),
];
