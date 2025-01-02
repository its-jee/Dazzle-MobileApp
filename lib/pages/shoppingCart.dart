import 'package:flutter/material.dart';
import 'package:splash_screen_project/pages/Loginfirst.dart';
import 'package:splash_screen_project/pages/home.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<Map<String, String>> cartProducts;

  const ShoppingCartPage({super.key, required this.cartProducts});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 3, 17, 86)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: widget.cartProducts.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Product List
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = widget.cartProducts[index];

                        // Debugging - Print product details to check null values
                        print('Product at index $index: $product');

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  product['image'] ?? 'assets/default.png',
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'] ?? 'No Name',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _formatPrice(product['price']),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              decreaseQuantity(index);
                                            },
                                            icon:
                                                const Icon(Icons.remove_circle),
                                            color: Colors.red,
                                          ),
                                          Text(
                                            product['quantity'] ?? '1',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              increaseQuantity(index);
                                            },
                                            icon: const Icon(Icons.add_circle),
                                            color: const Color.fromARGB(255, 4, 22, 109),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteProduct(index);
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Total Price Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${calculateTotal().toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Checkout Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 24, 98),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Function to format the price
  String _formatPrice(String? price) {
    if (price == null) return '0 EGP';
    return price.replaceAll(RegExp(r'[^0-9.]'), '');
  }

  // Function to calculate the total price
  double calculateTotal() {
    double total = 0.0;
    for (var product in widget.cartProducts) {
      double price = double.tryParse(_formatPrice(product['price'])) ?? 0.0;
      int quantity = int.tryParse(product['quantity'] ?? '1') ?? 1;
      print('Price: $price, Quantity: $quantity');
      total += price * quantity;
    }
    return total;
  }

  // Function to increase quantity
  void increaseQuantity(int index) {
    setState(() {
      final currentQuantity = int.tryParse(widget.cartProducts[index]['quantity'] ?? '0');
      if (currentQuantity != null && currentQuantity < 10) {
        widget.cartProducts[index]['quantity'] = (currentQuantity + 1).toString();
      }
    });
  }

  // Function to decrease quantity
  void decreaseQuantity(int index) {
    setState(() {
      final currentQuantity = int.tryParse(widget.cartProducts[index]['quantity'] ?? '0');
      if (currentQuantity != null && currentQuantity > 1) {
        widget.cartProducts[index]['quantity'] = (currentQuantity - 1).toString();
      }
    });
  }

  // Function to delete the product from the cart
  void deleteProduct(int index) {
    setState(() {
      widget.cartProducts.removeAt(index);
    });
  }
}
