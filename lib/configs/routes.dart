import 'package:get/get.dart';
import 'package:flutter_application_1/view/homescreen.dart';
import 'package:flutter_application_1/view/signup.dart';
import 'package:flutter_application_1/view/login.dart';
import 'package:flutter_application_1/view/dashboard.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/view/profile.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => const LoginScreen()),
  GetPage(name: '/signup', page: () => const SignupScreen()),
  GetPage(name: '/homescreen', page: () => const HomeScreen()),
  GetPage(name: '/dashboard', page: () => const Dashboard()),
  GetPage(name: '/cart', page: () => const CartScreen()),
  GetPage(name: '/profile', page: () => const ProfileScreen()),
];
