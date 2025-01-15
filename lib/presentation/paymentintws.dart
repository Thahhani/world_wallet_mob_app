// import 'package:flutter/material.dart';
// import 'package:worldwalletnew/presentation/homepage.dart';

// class PaymentProcess extends StatefulWidget {
//   final double price;

//   const PaymentProcess({super.key, required this.price});

//   @override
//   _PaymentProcessState createState() => _PaymentProcessState();
// }

// class _PaymentProcessState extends State<PaymentProcess> {

//   void processPayment() {
//     // Simulate payment processing and show success
   
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Payment", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.teal,
//         leading: BackButton(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               Text(
//                 "Payment Process",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal[700]),
//               ),
//               SizedBox(height: 20),

//               // Displaying the amount (read-only)
//               Text(
//                 "Amount: ₹${widget.price.toStringAsFixed(2)}", // Displaying amount with ₹
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[700]),
//               ),
//               SizedBox(height: 20),

//               // Proceed button
//               ElevatedButton.icon(
//                 onPressed: () {
//                   processPayment(); // Call processPayment on press
//                 },
//                 icon: Icon(Icons.payment, color: Colors.white),
//                 label: Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
