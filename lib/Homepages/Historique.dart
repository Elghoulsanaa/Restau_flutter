import 'package:flutter/material.dart';
import 'package:restaubook/Homepages/Home.dart';
import 'package:restaubook/Homepages/Profile.dart';
import 'package:restaubook/Homepages/SearchPage.dart';

class Historique extends StatelessWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter for the header (title and logout icon)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF8B0000), // Dark Red color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historique des Réservations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      // Functionality for logout can be implemented here
                      print('Déconnexion cliquée');
                    },
                  ),
                ],
              ),
            ),
          ),
          // SliverList to show all the reservation cards
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ReservationCard(
                  restaurantName: 'Lao Marrakech',
                  reservationDate: '2024-12-28',
                  status: 'Complétée',
                  imageUrl: 'images/lao.jpg', // Example image
                ),
                ReservationCard(
                  restaurantName: 'Le Passage Restaurant',
                  reservationDate: '2024-12-15',
                  status: 'Annulée',
                  imageUrl: 'images/passage.jpg', // Example image
                ),
                ReservationCard(
                  restaurantName: 'Plais Dar Soukkar',
                  reservationDate: '2024-11-10',
                  status: 'Complétée',
                  imageUrl: 'images/dar.jpg', // Example image
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
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Home()), // Navigate to Home page
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
        },
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final String restaurantName;
  final String reservationDate;
  final String status;
  final String imageUrl;

  const ReservationCard({
    Key? key,
    required this.restaurantName,
    required this.reservationDate,
    required this.status,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du restaurant
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Nom du restaurant et date de réservation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(
                          0xFF8B0000), // Dark Red color for restaurant name
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Date de réservation: $reservationDate',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Statut de la réservation (par exemple, Complétée ou Annulée)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: status == 'Complétée'
                    ? Colors.green
                    : const Color(0xFF8B0000), // Dark Red for 'Cancelled'
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
