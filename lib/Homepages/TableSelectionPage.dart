import 'package:flutter/material.dart';
import 'package:restaubook/Homepages/CheckPage.dart'; // Correct import statement

class TableSelectionPage extends StatefulWidget {
  final int personCount;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String comments;

  const TableSelectionPage({
    Key? key,
    required this.personCount,
    required this.selectedDate,
    required this.selectedTime,
    required this.comments,
  }) : super(key: key);

  @override
  State<TableSelectionPage> createState() => _TableSelectionPageState();
}

class _TableSelectionPageState extends State<TableSelectionPage> {
  // Liste des tables avec images statiques
  final List<TableModel> allTables = [
    TableModel(
        id: 1,
        floor: 1,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 2,
        floor: 1,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 3,
        floor: 1,
        capacity: 8,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 4,
        floor: 1,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 5,
        floor: 1,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 6,
        floor: 1,
        capacity: 8,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 7,
        floor: 1,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 8,
        floor: 1,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 9,
        floor: 1,
        capacity: 8,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 10,
        floor: 1,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 11,
        floor: 1,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 12,
        floor: 1,
        capacity: 8,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 13,
        floor: 2,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 14,
        floor: 2,
        capacity: 4,
        status: TableStatus.selected,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 15,
        floor: 2,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 16,
        floor: 2,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 17,
        floor: 2,
        capacity: 4,
        status: TableStatus.selected,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 18,
        floor: 2,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 19,
        floor: 2,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 20,
        floor: 2,
        capacity: 4,
        status: TableStatus.selected,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 21,
        floor: 2,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 22,
        floor: 2,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 23,
        floor: 2,
        capacity: 4,
        status: TableStatus.selected,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 24,
        floor: 2,
        capacity: 6,
        status: TableStatus.reserved,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 25,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 26,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 27,
        floor: 3,
        capacity: 6,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 28,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 29,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 30,
        floor: 3,
        capacity: 6,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 31,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 32,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 33,
        floor: 3,
        capacity: 6,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
    TableModel(
        id: 34,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table1.png'),
    TableModel(
        id: 35,
        floor: 3,
        capacity: 4,
        status: TableStatus.free,
        imagePath: 'images/table2.png'),
    TableModel(
        id: 36,
        floor: 3,
        capacity: 6,
        status: TableStatus.free,
        imagePath: 'images/table3.png'),
  ];

  int? _selectedTableId;
  int _selectedFloor = 1; // Étage sélectionné par défaut

  @override
  Widget build(BuildContext context) {
    // Filtrer les tables en fonction de l'étage sélectionné
    final tables =
        allTables.where((table) => table.floor == _selectedFloor).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Boutons pour sélectionner les étages
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFloorButton(1),
                _buildFloorButton(2),
                _buildFloorButton(3),
              ],
            ),
            const SizedBox(height: 16),

            // Légende
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegend(Icons.chair, "Free", Colors.grey),
                _buildLegend(Icons.chair, "Selected", Colors.blue),
                _buildLegend(Icons.chair, "Reserved", Colors.red),
              ],
            ),
            const SizedBox(height: 16),

            // Grille des tables
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                ),
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];
                  return GestureDetector(
                    onTap: table.status == TableStatus.free
                        ? () {
                            setState(() {
                              _selectedTableId = table.id;
                              // Update the table status properly
                              allTables.forEach((t) {
                                if (t.id == table.id) {
                                  t.status = TableStatus.selected;
                                } else if (t.status == TableStatus.selected) {
                                  t.status = TableStatus.free;
                                }
                              });
                            });
                          }
                        : null,
                    child: _buildTableWidget(table),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Bouton "Continuer"
            ElevatedButton(
              onPressed: _selectedTableId != null
                  ? () {
                      // Naviguer vers la page de confirmation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckPage(
                            // Corrected class name
                            personCount: widget.personCount,
                            selectedDate: widget.selectedDate,
                            // selectedTime: widget.selectedTime,
                            comments: widget.comments,
                            selectedTableId: _selectedTableId!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher une table avec une image et des informations
  Widget _buildTableWidget(TableModel table) {
    Color iconColor;
    switch (table.status) {
      case TableStatus.free:
        iconColor = Colors.grey;
        break;
      case TableStatus.selected:
        iconColor = Colors.blue;
        break;
      case TableStatus.reserved:
        iconColor = Colors.red;
        break;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: iconColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            table.imagePath,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text("Table ${table.id}"),
          Text("Capacity: ${table.capacity}"),
        ],
      ),
    );
  }

  // Widget pour la légende
  Widget _buildLegend(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  // Widget pour les boutons des étages
  Widget _buildFloorButton(int floor) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedFloor = floor;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedFloor == floor ? Colors.blue : Colors.grey,
      ),
      child: Text('Floor $floor'),
    );
  }
}

// Énumération des statuts des tables
enum TableStatus { free, selected, reserved }

// Modèle de table
class TableModel {
  final int id;
  final int floor;
  final int capacity;
  TableStatus status;
  final String imagePath;

  TableModel({
    required this.id,
    required this.floor,
    required this.capacity,
    required this.status,
    required this.imagePath,
  });
}
