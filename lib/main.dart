import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            "Login Screen",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          centerTitle: true,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Jumia Marketplace",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Login screen",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 20),
            Text(
              "Enter username",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
            ),
            TextField(),
            Text(
              "Enter password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
            ),
            TextField(),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("login"),
            ),
          ],
        ),
      ),
    ),
  );
}
