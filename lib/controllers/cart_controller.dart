import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addItem(Map<String, dynamic> product) {
    final index = cartItems.indexWhere((i) => i['name'] == product['name']);
    if (index >= 0) {
      cartItems[index]['quantity']++;
      cartItems.refresh();
    } else {
      cartItems.add({
        'name': product['name'],
        'price':
            int.tryParse(product['price'].toString().replaceAll('KSh ', '')) ??
            0,
        'quantity': 1,
      });
    }
  }

  void removeItem(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(index);
    }
  }

  double get total => cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );
}
