import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Get.toNamed('/homescreen'),
          child: const Text('TINDI COLLECTIONS'),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/bird_2.jpg', height: 200, width: 200),
              const SizedBox(height: 16),
              const Text(
                'Welcome to TINDI COLLECTIONS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/homescreen'),
        child: const Icon(Icons.arrow_forward),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.pinkAccent,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.shopping_cart, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(
              '/homescreen',
            ); //keep this, dashboars home goes to products
          } else if (index == 1) {
            Get.toNamed('/cart');
          } else if (index == 2) {
            Get.toNamed('/profile');
          }
        },
      ),
    );
  }
}
