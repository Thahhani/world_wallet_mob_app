import 'package:flutter/material.dart';
import 'package:worldwalletnew/oters/paymentscren.dart';


class Paymentvia extends StatelessWidget {
  Paymentvia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              PaymentOptionCard(
                paymentMethod: 'UPI',
                backgroundColor: Color.fromARGB(255, 209, 199, 199),
                onTap: () {
                  // Navigate to UPI Payment Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
              ),
              SizedBox(height: 15),
              PaymentOptionCard(
                paymentMethod: 'Credit/Debit Cards',
                backgroundColor: Color.fromARGB(255, 237, 228, 228),
                onTap: () {
                  // Navigate to Credit/Debit Card Payment Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
              ),
              SizedBox(height: 15),
              PaymentOptionCard(
                paymentMethod: 'Bank Transfer',
                backgroundColor: Color.fromARGB(255, 231, 222, 222),
                onTap: () {
                  // Navigate to Bank Transfer Payment Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
              ),
              SizedBox(height: 15),
              PaymentOptionCard(
                paymentMethod: 'Wallet',
                backgroundColor: Color.fromARGB(255, 231, 222, 222),
                onTap: () {
                  // Navigate to Wallet Payment Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final String paymentMethod;
  final Color backgroundColor;
  final VoidCallback onTap;

  PaymentOptionCard({
    required this.paymentMethod,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the passed onTap function for navigation
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            paymentMethod,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
