import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Logincontroller logincontroller = Get.put(Logincontroller());

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                controller: usernameController,
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
              Obx(
                () => TextField(
                  controller: passwordController,
                  obscureText: !logincontroller.PasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Enter password here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: GestureDetector(
                        child: Icon(
                          logincontroller.PasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onTap: () {
                          logincontroller.togglePassword();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              MaterialButton(
                onPressed: () async {
                  if (usernameController.text.isEmpty) {
                    Get.snackbar("Error", "Enter username");
                  } else if (passwordController.text.isEmpty) {
                    Get.snackbar("Error", "Enter password");
                  } else {
                    try {
                      final response = await http
                          .get(
                            Uri.parse(
                              "http://10.0.2.2/library_api/login.php?phone=${usernameController.text}&password=${passwordController.text}",
                            ),
                          )
                          .timeout(Duration(seconds: 5));
                      if (response.statusCode == 200) {
                        final serverData = jsonDecode(response.body);
                        if (serverData['code'] == 1) {
                          String phone = serverData["userdetails"][0]["phone"];
                          print(phone);
                          Get.offAndToNamed('/dashboard');
                        } else {
                          Get.snackbar(
                            "Wrong Credentials",
                            serverData["message"],
                          );
                        }
                      } else {
                        Get.snackbar(
                          "Server Error",
                          "Error occured while logging in",
                        );
                      }
                    } catch (e) {
                      // API not available, use local validation
                      bool success = logincontroller.login(
                        usernameController.text,
                        passwordController.text,
                      );
                      if (success) {
                        Get.offAndToNamed("/dashboard");
                      } else {
                        Get.snackbar(
                          "Error",
                          "Invalid username or password. Use admin/123456",
                        );
                      }
                    }
                  }
                },
                color: Colors.pinkAccent,
                height: 50,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                      onTap: () {
                        Get.offAndToNamed("/signup");
                      },
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
    );
  }
}
