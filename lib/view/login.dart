import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/bird_2.jpg', height: 100, width: 150),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Enter username",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Use email or phone number",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter password here",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Get.snackbar("Error", "Please enter email and password");
                      return;
                    }
                    try {
                      final response = await http.get(
                        Uri.parse(
                          "http://192.168.11.35/clothes_api/login.php?email=${emailController.text}&password=${passwordController.text}",
                        ),
                      );
                      if (response.statusCode == 200) {
                        final data = jsonDecode(response.body);
                        if (data['success'] != null && data['success'] == 1) {
                          Get.offAllNamed('/dashboard');
                        } else {
                          Get.snackbar(
                            "Error",
                            data['message'] ?? "Login failed",
                          );
                        }
                      }
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    }
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Row(
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Get.toNamed('/signup'),
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                      ),
                      Spacer(),
                      Text("Forgot password?"),
                      SizedBox(width: 5),
                      Text("Reset", style: TextStyle(color: Colors.pinkAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
