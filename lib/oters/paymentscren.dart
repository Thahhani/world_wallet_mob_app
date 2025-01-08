import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // You can perform any custom actions here before navigating back.
        Navigator.of(context).pop();
        return true; // Allow the back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display some payment information or a form
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: TextStyle(color: Colors.black),  // Set label color to grey
                  fillColor: Colors.cyan,  // Background color (optional)
                  filled: true,  // Ensure the fillColor is applied
                ),
                style: TextStyle(color: Colors.black),  // Set text color to black
              ),
              SizedBox(height: 30),
              // Payment button
              ElevatedButton(
                onPressed: () {
                  // Here you can handle the payment process
                  _processPayment(context);
                },
                child: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment(BuildContext context) {
    // Simulating a payment process
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment has been processed successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();  // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
