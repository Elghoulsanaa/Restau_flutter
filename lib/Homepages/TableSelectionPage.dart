import 'package:flutter/material.dart';
import 'package:restaubook/Homepages/CheckPage.dart';

class TableSelectionPage extends StatefulWidget {
  const TableSelectionPage({Key? key}) : super(key: key);

  @override
  State<TableSelectionPage> createState() => _TableSelectionPageState();
}

class _TableSelectionPageState extends State<TableSelectionPage> {
  final List<Table> tables = [
    Table(id: 1, floor: 1, capacity: 4, status: TableStatus.free),
    Table(id: 2, floor: 1, capacity: 6, status: TableStatus.reserved),
    Table(id: 3, floor: 1, capacity: 8, status: TableStatus.free),
    Table(id: 4, floor: 2, capacity: 4, status: TableStatus.free),
    Table(id: 5, floor: 2, capacity: 4, status: TableStatus.selected),
    Table(id: 6, floor: 2, capacity: 6, status: TableStatus.reserved),
    Table(id: 7, floor: 3, capacity: 4, status: TableStatus.free),
    Table(id: 8, floor: 3, capacity: 4, status: TableStatus.free),
    Table(id: 9, floor: 3, capacity: 6, status: TableStatus.free),
  ];

  int? _selectedTableId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegend(Icons.chair, "Free", Colors.grey),
                _buildLegend(Icons.chair, "Selected", Colors.blue),
                _buildLegend(Icons.chair, "Reserved", Colors.red),
              ],
            ),
            const SizedBox(height: 16),
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
                              for (var t in tables) {
                                if (t.id == table.id) {
                                  t.status = TableStatus.selected;
                                } else if (t.status == TableStatus.selected) {
                                  t.status = TableStatus.free;
                                }
                              }
                            });
                          }
                        : null,
                    child: _buildTableWidget(table),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedTableId != null
                  ? () {
                      // Navigate to CheckoutPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkpage(),
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

  Widget _buildTableWidget(Table table) {
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
          Icon(Icons.chair, color: iconColor, size: 40),
          Text("Table ${table.id}"),
          Text("Capacity: ${table.capacity}"),
        ],
      ),
    );
  }

  Widget _buildLegend(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

enum TableStatus { free, selected, reserved }

class Table {
  final int id;
  final int floor;
  final int capacity;
  TableStatus status;

  Table({
    required this.id,
    required this.floor,
    required this.capacity,
    required this.status,
  });
}
