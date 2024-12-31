import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaubook/Homepages/OrderSummaryPage.dart';

class CheckPage extends StatefulWidget {
  final int selectedTableId; // Table ID
  final int personCount; // Number of persons
  final DateTime selectedDate; // Selected date
  final String comments; // Additional comments

  const CheckPage({
    Key? key,
    required this.selectedTableId,
    required this.personCount,
    required this.selectedDate,
    required this.comments,
  }) : super(key: key);
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  List<Map<String, dynamic>> cartItems = []; // List to store cart items

  // Function to add item to the cart
  void addToCart(String name, double price) {
    setState(() {
      cartItems.add({'name': name, 'price': price});
    });
  }

  // Function to save the order to Firestore
  Future<void> _saveOrder() async {
    try {
      var orderRef = FirebaseFirestore.instance.collection('orders').doc();
      await orderRef.set({
        'items': cartItems,
        'totalPrice': cartItems.fold(
            0.0, (previousValue, item) => previousValue + item['price']),
        'timestamp': FieldValue.serverTimestamp(),
        'tableId': widget.selectedTableId, // Use selectedTableId
        'personCount': widget.personCount, // Use personCount
        'selectedDate': widget.selectedDate, // Use selectedDate
        'comments': widget.comments, // Use comments
      });

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc('restaurantId')
          .collection('tables')
          .doc(widget.selectedTableId
              as String?) // Use selectedTableId dynamically
          .update({'status': 'reserved'});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Table ${widget.selectedTableId}'), // Display selected table ID
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table and Customer info container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.table_bar, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Table ${widget.selectedTableId}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 24),
                      SizedBox(width: 8),
                      Text(
                        '${widget.personCount} Customers',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Menu Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const SectionTitle(title: 'Entrées'),
                  MenuItem(
                    imagePath: 'images/salade.jpg',
                    name: 'Salade Marocaine',
                    description: 'Une délicieuse salade traditionnelle.',
                    price: 75.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'images/soup.png',
                    name: 'Soupe Harira',
                    description: 'La soupe marocaine classique.',
                    price: 50.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Plats'),
                  MenuItem(
                    imagePath: 'images/tagine.png',
                    name: 'Tajine au Poulet',
                    description: 'Tajine traditionnel avec épices marocaines.',
                    price: 120.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'images/kebab.png',
                    name: 'Kebab Marocain',
                    description: 'Délicieux kebab aux saveurs authentiques.',
                    price: 80.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Boissons'),
                  MenuItem(
                    imagePath: 'images/juice.png',
                    name: 'Jus d\'Orange',
                    description: 'Jus d\'orange frais pressé.',
                    price: 30.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'images/mojito.png',
                    name: 'Mojito Cocktail',
                    description: 'Cocktail rafraîchissant sans alcool.',
                    price: 50.0,
                    onAddToCart: addToCart,
                  ),
                  const SectionTitle(title: 'Desserts'),
                  MenuItem(
                    imagePath: 'images/cake.png',
                    name: 'Gâteau au Chocolat',
                    description: 'Un dessert parfait pour les gourmands.',
                    price: 40.0,
                    onAddToCart: addToCart,
                  ),
                  MenuItem(
                    imagePath: 'images/icecream.png',
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
            // Checkout Button
            ElevatedButton(
              onPressed: () {
                _saveOrder(); // Save the order to Firestore
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSummaryPage(
                      cartItems: cartItems,
                      selectedTableId:
                          widget.selectedTableId, // Pass selectedTableId
                      personCount: widget.personCount, // Pass personCount
                      selectedDate: widget.selectedDate, // Pass selectedDate
                      comments: widget.comments, // Pass comments
                    ),
                  ),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
