import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();
  double get total => cartController.cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.toNamed('/homescreen'),
        ),
      ),
      body: Obx(
        () => cartController.cartItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              item['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('Price: KSh ${item['price']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (item['quantity'] > 1) {
                                        item['quantity']--;
                                      } else {
                                        cartController.cartItems.removeAt(
                                          index,
                                        );
                                      }
                                    });
                                  },
                                ),
                                Text('${item['quantity']}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      item['quantity']++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'KSh ${total.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Select Payment Method'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.phone_android,
                                          color: Colors.green,
                                        ),
                                        title: const Text('M-Pesa'),
                                        onTap: () {
                                          Get.back();
                                          final TextEditingController
                                          mpesaController =
                                              TextEditingController();
                                          Get.dialog(
                                            AlertDialog(
                                              title: const Text(
                                                'M-Pesa Payment',
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Total: KSh ${total.toStringAsFixed(0)}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.pinkAccent,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  TextField(
                                                    controller: mpesaController,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Enter M-Pesa Number',
                                                      hintText: '07XXXXXXXX',
                                                      prefixIcon: Icon(
                                                        Icons.phone_android,
                                                        color: Colors.green,
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (mpesaController
                                                        .text
                                                        .isEmpty) {
                                                      Get.snackbar(
                                                        'Error',
                                                        'Please enter your M-Pesa number',
                                                      );
                                                    } else {
                                                      Get.back();
                                                      Get.dialog(
                                                        AlertDialog(
                                                          title: const Text(
                                                            'Payment Initiated',
                                                          ),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .phone_android,
                                                                color: Colors
                                                                    .green,
                                                                size: 50,
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              Text(
                                                                'An STK push has been sent to ${mpesaController.text}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                'Amount: KSh ${total.toStringAsFixed(0)}',
                                                                style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .pinkAccent,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              const Text(
                                                                'Enter your M-Pesa PIN on your phone to complete payment.',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                                cartController
                                                                    .cartItems
                                                                    .clear();
                                                                Get.offAllNamed(
                                                                  '/homescreen',
                                                                );
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                              child: const Text(
                                                                'Done',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                  child: const Text(
                                                    'Pay Now',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.credit_card,
                                          color: Colors.blue,
                                        ),
                                        title: const Text(
                                          'Credit / Debit Card',
                                        ),
                                        onTap: () {
                                          Get.back();
                                          Get.snackbar(
                                            'Card Payment',
                                            'Redirecting to card payment for KSh ${total.toStringAsFixed(0)}',
                                          );
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.delivery_dining,
                                          color: Colors.orange,
                                        ),
                                        title: const Text('Cash on Delivery'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Get.snackbar(
                                            'Cash on Delivery',
                                            'Order placed! Pay KSh ${total.toStringAsFixed(0)} on delivery',
                                          );
                                          cartController.cartItems.clear();
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            child: const Text(
                              'Checkout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            Get.toNamed('/dashboard');
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
