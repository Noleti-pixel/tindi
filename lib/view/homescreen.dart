import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> allProducts = [
    // Clothes
    {
      'name': 'Dress',
      'price': 'KSh 1500',
      'image':
          'https://images.unsplash.com/photo-1595777707802-041d4c4022f5?w=300',
      'category': 'Clothes',
      'sizes': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    },
    {
      'name': 'Shirt',
      'price': 'KSh 1500',
      'image':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300',
      'category': 'Clothes',
      'sizes': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    },
    {
      'name': 'Blouse',
      'price': 'KSh 1200',
      'image':
          'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=300',
      'category': 'Clothes',
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
    },
    {
      'name': 'Jacket',
      'price': 'KSh 2500',
      'image':
          'https://images.unsplash.com/photo-1551028719-00167b16ebc5?w=300',
      'category': 'Clothes',
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
    },
    // Shoes
    {
      'name': 'Shoes',
      'price': 'KSh 3000',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300',
      'category': 'Shoes',
      'sizes': ['6', '7', '8', '9', '10', '11', '12'],
    },
    {
      'name': 'Sneakers',
      'price': 'KSh 2800',
      'image':
          'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=300',
      'category': 'Shoes',
      'sizes': ['5', '6', '7', '8', '9', '10', '11'],
    },
    {
      'name': 'Heels',
      'price': 'KSh 3500',
      'image':
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=300',
      'category': 'Shoes',
      'sizes': ['5', '6', '7', '8', '9', '10'],
    },
    {
      'name': 'Sandals',
      'price': 'KSh 1800',
      'image':
          'https://images.unsplash.com/photo-1572099160559-b5a30f4e7eba?w=300',
      'category': 'Shoes',
      'sizes': ['6', '7', '8', '9', '10', '11'],
    },
    // Accessories
    {
      'name': 'Handbag',
      'price': 'KSh 2200',
      'image':
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=300',
      'category': 'Accessories',
      'sizes': ['One Size'],
    },
    {
      'name': 'Sunglasses',
      'price': 'KSh 1600',
      'image':
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300',
      'category': 'Accessories',
      'sizes': ['One Size'],
    },
    {
      'name': 'Scarf',
      'price': 'KSh 800',
      'image':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=300',
      'category': 'Accessories',
      'sizes': ['One Size'],
    },
    {
      'name': 'Watch',
      'price': 'KSh 4000',
      'image':
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=300',
      'category': 'Accessories',
      'sizes': ['One Size'],
    },
    // Pants
    {
      'name': 'Pants',
      'price': 'KSh 1000',
      'image':
          'https://images.unsplash.com/photo-1542272604-787c62d465d1?w=300',
      'category': 'Clothes',
      'sizes': ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    },
  ];

  final List<String> categories = ['All', 'Clothes', 'Shoes', 'Accessories'];

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedIndex == 0) {
      return allProducts;
    }
    return allProducts
        .where((product) => product['category'] == categories[_selectedIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TINDI COLLECTIONS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              height: 150,
              color: Colors.pinkAccent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/bird_2.jpg', height: 80, width: 80),
                    const SizedBox(height: 8),
                    const Text(
                      'Welcome to TINDI COLLECTIONS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: Text(categories[index]),
                      selected: _selectedIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedIndex = selected ? index : 0;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.pinkAccent,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Products Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            filteredProducts[index]['image'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      ),
                      Text(
                        filteredProducts[index]['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          filteredProducts[index]['price'],
                          style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Sizes: ${filteredProducts[index]['sizes'].join(", ")}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${filteredProducts[index]['name']} added to cart!',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
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
