import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaubook/Homepages/Menu.dart';
import 'package:restaubook/Homepages/TableSelectionPage.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String address;
  final double rating;
  final String phoneNumber; // Added phone number
  final String details; // Added details text
  final String openHours; // Added open hours

  const RestaurantDetailPage({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.rating,
    required this.phoneNumber,
    required this.details,
    required this.openHours,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  int _personCount = 1;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _comments = "";

  // Navigate to another page (for example: BookingConfirmationPage)
  void _goToBookingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TableSelectionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.address, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(widget.rating.toString()),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () async {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.details, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              "Open Hours: ${widget.openHours}",
              style: const TextStyle(fontSize: 16),
            ),

            // Number of Persons
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number of Persons:'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _personCount--),
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_personCount'),
                    IconButton(
                      onPressed: () => setState(() => _personCount++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),

            // Pick a Date in the same line as the button
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Pick a Date: ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 35,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                ),
              ],
            ),

            // Pick Time in the same line as the button
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Pick Time: ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 35,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (picked != null && picked != _selectedTime) {
                      setState(() {
                        _selectedTime = picked;
                      });
                    }
                  },
                  child: Text(_selectedTime.format(context)),
                ),
              ],
            ),

            // Comments Section
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "+",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => setState(() => _comments = value),
              decoration: const InputDecoration(hintText: 'Add comments'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Row for buttons (Book Table and View Menu)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF800020), // Background color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to CheckoutPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Menu(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFFF800020), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Menu'),
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF800020), // Background color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: _goToBookingPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFFF800020), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Book Table'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
