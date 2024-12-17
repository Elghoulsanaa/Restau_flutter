import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class OrderSummaryPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const OrderSummaryPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isCardAdded = false;
  String _cardMessage = '';

  // Variable pour stocker le total
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    // Calcul du total
    total = 0.0;
    for (var item in widget.cartItems) {
      total += (item['price'] as double) * (item['quantity'] as int);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Command'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table et Infos Clients
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

            // Articles Sélectionnés
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  var item = widget.cartItems[index];
                  return MenuItemSummary(
                    name: item['name'],
                    price: item['price'],
                    imagePath: item['imagePath'],
                    quantity: item['quantity'],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Méthodes de Paiement
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.red[400]),
                  title: Text(_isCardAdded ? _cardMessage : 'Add new card'),
                  onTap: () {
                    if (_isCardAdded) {
                      _showCardDetails(context);
                    } else {
                      _showAddCardDialog(context);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money, color: Colors.green[400]),
                  title: const Text('Cash payment'),
                  onTap: () {
                    _showCashPaymentMessage(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Résumé et Total
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...widget.cartItems.map((item) {
                    return Text(
                      '${item['name']} × ${item['quantity']} = ${(item['price'] * item['quantity']).toStringAsFixed(2)} DH',
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  Text(
                    'Total: ${total.toStringAsFixed(2)} DH',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bouton de Confirmation
            ElevatedButton(
              onPressed: () {
                _confirmOrder();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF800020),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Confirm my order',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                ),
              ),
              TextField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                ),
              ),
              TextField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add Card'),
              onPressed: () {
                setState(() {
                  _isCardAdded = true;
                  _cardMessage =
                      'Payment is by card ending in ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)}';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCashPaymentMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment is by cash'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showCardDetails(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Card ending in ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)} is selected'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirmOrder() async {
    String orderSummary =
        'Your order has been successfully placed. \n\nItems:\n';
    for (var item in widget.cartItems) {
      orderSummary +=
          '${item['name']} × ${item['quantity']} = ${(item['price'] * item['quantity']).toStringAsFixed(2)} DH\n';
    }
    orderSummary += '\nTotal: ${total.toStringAsFixed(2)} DH\n';

    final Email email = Email(
      body: orderSummary,
      subject: 'Order Confirmation',
      recipients: ['user@example.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order Confirmed. Confirmation email sent!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending email.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class MenuItemSummary extends StatelessWidget {
  final String name;
  final double price;
  final String imagePath;
  final int quantity;

  const MenuItemSummary({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${(price * quantity).toStringAsFixed(2)} DH',
          style: const TextStyle(fontSize: 14, color: Colors.red),
        ),
      ],
    );
  }
}
