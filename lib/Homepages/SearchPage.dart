import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaubook/Homepages/Historique.dart';
import 'package:restaubook/Homepages/Home.dart';
import 'package:restaubook/Homepages/Profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  bool isExpanded = false;
  int? selectedIndex;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> allRestaurants = [];
  List<Map<String, dynamic>> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('restaurants').get();
      setState(() {
        allRestaurants = querySnapshot.docs.map((doc) {
          return {
            'name': doc['name'] ?? '',
            'imagePath': doc['imagePath'] ??
                '', // Modification ici pour utiliser 'imagePath'
            'address': doc['address'] ?? '',
            'rating': doc['rating'] ?? 0.0,
            'isOpen': doc['isOpen'] ?? false,
            'phoneNumber': doc['phoneNumber'] ?? '',
            'details': doc['details'] ?? '',
            'openHours': doc['openHours'] ?? '',
          };
        }).toList();
        filteredRestaurants = allRestaurants;
      });
    } catch (e) {
      print("Erreur lors de la récupération des restaurants: $e");
    }
  }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRestaurants = allRestaurants;
      } else {
        filteredRestaurants = allRestaurants.where((restaurant) {
          return restaurant['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                onChanged: _filterSearchResults,
                decoration: InputDecoration(
                  labelText: 'Search by name or category',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var restaurant = filteredRestaurants[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = (selectedIndex == index) ? null : index;
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.asset(
                          restaurant[
                              'imagePath'], // Utilisation de 'imagePath' ici
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
                                restaurant['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                restaurant['address'],
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
                                    restaurant['rating'].toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const Spacer(),
                                  if (restaurant['isOpen'])
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
                        if (selectedIndex == index) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Details: ${restaurant['details']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Phone: ${restaurant['phoneNumber']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Open Hours: ${restaurant['openHours']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              childCount: filteredRestaurants.length,
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
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1, // Page actuelle : Search
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Historique()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },
      ),
    );
  }
}
