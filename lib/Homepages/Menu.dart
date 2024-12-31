import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action pour la recherche
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionTitle(title: 'Entrées'),
          MenuItem(
            imagePath: 'images/salade.jpg',
            name: 'Salade Marocaine',
            description: 'Une délicieuse salade traditionnelle.',
            price: 75.0,
          ),
          MenuItem(
            imagePath: 'images/soup.png',
            name: 'Soupe Harira',
            description: 'La soupe marocaine classique.',
            price: 50.0,
          ),
          const SectionTitle(title: 'Plats'),
          MenuItem(
            imagePath: 'images/tagine.png',
            name: 'Tajine au Poulet',
            description: 'Tajine traditionnel avec épices marocaines.',
            price: 120.0,
          ),
          MenuItem(
            imagePath: 'images/kebab.png',
            name: 'Kebab Marocain',
            description: 'Délicieux kebab aux saveurs authentiques.',
            price: 80.0,
          ),
          const SectionTitle(title: 'Boissons'),
          MenuItem(
            imagePath: 'images/juice.png',
            name: 'Jus d\'Orange',
            description: 'Jus d\'orange frais pressé.',
            price: 30.0,
          ),
          MenuItem(
            imagePath: 'images/mojito.png',
            name: 'Mojito Cocktail',
            description: 'Cocktail rafraîchissant sans alcool.',
            price: 50.0,
          ),
          const SectionTitle(title: 'Desserts'),
          MenuItem(
            imagePath: 'images/cake.png',
            name: 'Gâteau au Chocolat',
            description: 'Un dessert parfait pour les gourmands.',
            price: 40.0,
          ),
          MenuItem(
            imagePath: 'assets/icecream.png',
            name: 'Glace Vanille',
            description: 'Délicieuse glace à la vanille.',
            price: 35.0,
          ),
        ],
      ),
    );
  }
}

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

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;
  final double price;

  const MenuItem({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Text(
          '${price.toStringAsFixed(2)} DH',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        onTap: () {
          // Action lors du clic sur un élément du menu
        },
      ),
    );
  }
}
