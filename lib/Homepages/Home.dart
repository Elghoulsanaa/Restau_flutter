import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaubook/Homepages/Historique.dart';
import 'package:restaubook/Homepages/Profile.dart';
import 'package:restaubook/Homepages/RestaurantDetailPage.dart';
import 'package:restaubook/Homepages/SearchPage.dart'; // Assure-toi d'importer la page pour la navigation

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                color: Color(0xFF800020),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Affichage du nom de l'utilisateur depuis Firestore
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid) // Utilise l'ID de l'utilisateur
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.hasError) {
                                return const Text('Error retrieving user name');
                              }

                              if (snapshot.hasData && snapshot.data != null) {
                                var userData = snapshot.data?.data()
                                    as Map<String, dynamic>;
                                String userName =
                                    userData['username'] ?? 'User';
                                return Text(
                                  userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                );
                              }

                              return Text(
                                'User',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        'images/logoBon.png', // Remplace par le logo approprié
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Récupération des catégories depuis Firestore
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection(
                          'categories') // Collection Firestore "category"
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No categories available.'));
                    }

                    // Affichage des catégories récupérées
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.docs.map((doc) {
                          String name = doc['name']; // Nom de la catégorie
                          String imageUrl = doc[
                              'imagePath']; // Chemin de l'image de la catégorie

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Afficher un message avec le nom de la catégorie
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('$name'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Navigation vers une autre page pour afficher les détails de la catégorie
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailPage(
                                      categoryName: name, // Passe le nom de la catégorie
                                      categoryImageUrl: imageUrl, // Passe l'URL de l'image
                                    ),
                                  ),
                                );*/
                              },
                              child: ClipOval(
                                child: Image.network(
                                  imageUrl, // Charge l'image depuis Firestore
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Fetching restaurant data from Firestore
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('restaurants')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No restaurants available.'));
                    }

                    // Displaying the list of restaurants
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        String imagePath =
                            doc['imagePath']; // Récupère le chemin local
                        String name = doc['name'];
                        String address = doc['address'];
                        double rating = doc['rating'].toDouble();
                        bool isOpen = doc['isOpen'];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to RestaurantDetailPage with details
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetailPage(
                                  // restaurantId: doc
                                  // .id, // Utilisez l'ID du document Firebase
                                  imageUrl: imagePath,
                                  name: name,
                                  address: address,
                                  rating: rating,
                                  phoneNumber: doc['phoneNumber'],
                                  details: doc['details'],
                                  openHours: doc['openHours'],
                                ),
                              ),
                            );
                          },
                          child: RestaurantCard(
                            imagePath: imagePath,
                            name: name,
                            address: address,
                            rating: rating,
                            isOpen: isOpen,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          //selectedIconTheme: IconThemeData(color: Colors.green, size: 30),
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Home()), // Navigate to Home page
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SearchPage()), // Navigate to Search page
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Historique()), // Stay on Historique page
              );
            } else if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Profile()), // Navigate to Profile page
              );
            }
          }),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String address;
  final double rating;
  final bool isOpen;

  const RestaurantCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.address,
    required this.rating,
    required this.isOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            imagePath, // Charge l'image locale
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 5),
                Text(
                  address,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    if (isOpen)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'Open Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
