import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "sign up",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/bird_2.jpg', width: 100, height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "username",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextField(
              controller: fullname,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "enter email",
                hintStyle: TextStyle(fontWeight: FontWeight.w100),
                prefixIcon: Icon(Icons.email, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "enter password",
                hintStyle: TextStyle(fontWeight: FontWeight.w100),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "confirm password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextField(
              controller: confirmPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "confirm password",
                hintStyle: TextStyle(fontWeight: FontWeight.w100),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () async {
                if (fullname.text.isEmpty) {
                  Get.snackbar("Error", "Please enter first name");
                } else if (email.text.isEmpty) {
                  Get.snackbar("Error", "Please enter email name");
                } else if (password.text.isEmpty ||
                    confirmPassword.text.isEmpty ||
                    password.text.toString().compareTo(
                          confirmPassword.text.toString(),
                        ) !=
                        0) {
                  Get.snackbar(
                    "Error",
                    "Password and Password confirmation be none empty and matching",
                  );
                } else {
                  final response = await http.get(
                    Uri.parse(
                      "http://10.0.2.2/library_api/signup.php?username=${fullname.text} User&email=${email.text}@gmail.com&password=${password.text}&phone=${phone.text}",
                    ),
                  );
                  if (response.statusCode == 200) {
                    final serverData = jsonDecode(response.body);
                    if (serverData['success'] == 1) {
                      Get.snackbar("Success", "You are registered");
                      Get.offAndToNamed("/");
                    }
                  } else {
                    Get.snackbar("Registration", "Registration  Failed");
                  }
                }
              },
              color: Colors.blueAccent,
              child: Text(
                "sign up",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 5),
                  Text("sign in", style: TextStyle(color: Colors.pink)),
                  Spacer(),
                  Text("Forgot password?"),
                  SizedBox(width: 5),
                  Text("reset password", style: TextStyle(color: Colors.pink)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/");
                    },
                    child: Text(
                      "sign up",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    phone.dispose();
    super.dispose();
  }
}
