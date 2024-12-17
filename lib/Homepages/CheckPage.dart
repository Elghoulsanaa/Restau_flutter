import 'package:flutter/material.dart';
import 'package:restaubook/Homepages/OrderSummaryPage.dart';

class Checkpage extends StatefulWidget {
  const Checkpage({Key? key}) : super(key: key);

  @override
  _CheckpageState createState() => _CheckpageState();
}

class _CheckpageState extends State<Checkpage> {
  List<Map<String, dynamic>> cartItems = []; // List to store cart items

  // Function to add item to the cart
  void addToCart(String name, double price) {
    setState(() {
      cartItems.add({'name': name, 'price': price});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table R2.3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.table_bar, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Table No. R2.3',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 24),
                      SizedBox(width: 8),
                      Text(
                        '5 Customers',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const SectionTitle(title: 'Entrées'),
                  MenuItem(
                    imagePath: 'assets/salad.png',
                    name: 'Salade Marocaine',
                    description: 'Une délicieuse salade traditionnelle.',
                    price: 75.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'assets/soup.png',
                    name: 'Soupe Harira',
                    description: 'La soupe marocaine classique.',
                    price: 50.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Plats'),
                  MenuItem(
                    imagePath: 'assets/tajine.png',
                    name: 'Tajine au Poulet',
                    description: 'Tajine traditionnel avec épices marocaines.',
                    price: 120.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'assets/kebab.png',
                    name: 'Kebab Marocain',
                    description: 'Délicieux kebab aux saveurs authentiques.',
                    price: 80.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Boissons'),
                  MenuItem(
                    imagePath: 'assets/juice.png',
                    name: 'Jus d\'Orange',
                    description: 'Jus d\'orange frais pressé.',
                    price: 30.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'assets/mojito.png',
                    name: 'Mojito Cocktail',
                    description: 'Cocktail rafraîchissant sans alcool.',
                    price: 50.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Desserts'),
                  MenuItem(
                    imagePath: 'assets/cake.png',
                    name: 'Gâteau au Chocolat',
                    description: 'Un dessert parfait pour les gourmands.',
                    price: 40.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'assets/icecream.png',
                    name: 'Glace Vanille',
                    description: 'Délicieuse glace à la vanille.',
                    price: 35.0,
                    onAddToCart: addToCart,
                  ),
                ],
              ),
            ),
            // Cart items display
            if (cartItems.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'Cart (${cartItems.length} items)',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // List of items in the cart
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['price']} DH'),
                    trailing: const Icon(Icons.remove_circle_outline),
                  );
                },
              ),
            ],
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderSummaryPage(cartItems: cartItems)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF800020),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Proceed to checkout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final Function(String, double) onAddToCart;

  const MenuItem({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            '${price.toStringAsFixed(2)} DH',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              onAddToCart(name, price); // Add item to the cart
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

// SectionTitle widget for section headers
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
