import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clothes_model.dart';
import 'package:get/get.dart';

var myClothes = [
  ClothesModel(
    name: 'Red Dress',
    size: 'M',
    price: 2000,
    image: "assets/dress.jpeg",
  ),
];

class Clothes extends StatefulWidget {
  const Clothes({super.key});

  @override
  State<Clothes> createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myClothes.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Image.asset(myClothes[index].image, height: 100, width: 100),

            Column(
              children: [
                Text(myClothes[index].name),
                Text(myClothes[index].size),
                Text('Ksh ${myClothes[index].price}'),
              ],
            ),
          ],
        );
      },
    );
    // :Center(
    //   child:CircularProgressIndicator());
  }
}
