import 'package:flutter/material.dart';
import 'package:splash_screen_project/pages/favourite.dart';
import 'package:splash_screen_project/pages/productPage.dart';
import 'package:splash_screen_project/pages/shoppingCart.dart';
import 'package:splash_screen_project/pages/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> favoriteProducts = [];
  final List<Map<String, String>> shoppingCart = [];

  final List<Map<String, String>> _allRecommendedProducts = [
    {'name': 'Vanish Power', 'price': '275 EGP', 'image': 'assets/vanish.jpg'},
    {'name': 'Dettol Power', 'price': '150 EGP', 'image': 'assets/dettol.jpg'},
    {'name': 'Persil Black', 'price': '250 EGP', 'image': 'assets/persil.jpg'},
    {'name': 'Tide Auto', 'price': '60 EGP', 'image': 'assets/tide.jpg'},
    {'name': 'Clorox', 'price': '80 EGP', 'image': 'assets/clorox.jpg'},
  ];

  List<Map<String, String>> filteredRecommendedProducts = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredRecommendedProducts = List.from(_allRecommendedProducts);
  }

  void _searchProducts() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      filteredRecommendedProducts = _allRecommendedProducts
          .where((product) => product['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      // Navigate to Favorites Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FavoritesPage(favoriteProducts: favoriteProducts),
        ),
      );
    } else if (index == 2) {
      // Navigate to Shopping Cart Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShoppingCartPage(cartProducts: shoppingCart),
        ),
      );
    } else if (index == 3) {
      // Navigate to Profile Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(   
          'assets/logo.png', 
          height: 60,  
        ),
        backgroundColor: const Color.fromARGB(255, 235, 239, 241),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _searchProducts();
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommended Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildVerticalList(filteredRecommendedProducts),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color.fromARGB(255, 14, 5, 113),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildVerticalList(List<Map<String, String>> products) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), 
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to Product Page with the selected product details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  image: products[index]['image']!,
                  name: products[index]['name']!,
                  price: products[index]['price']!,
                  product: {},
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100, 
                    width: 100, 
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        products[index]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index]['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              products[index]['price']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                favoriteProducts.contains(products[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    favoriteProducts.contains(products[index])
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (favoriteProducts
                                      .contains(products[index])) {
                                    favoriteProducts.remove(products[index]);
                                  } else {
                                    favoriteProducts.add(products[index]);
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Color.fromARGB(255, 3, 7, 82),
                              ),
                              onPressed: () {
                                setState(() {
                                  shoppingCart.add(products[index]);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
