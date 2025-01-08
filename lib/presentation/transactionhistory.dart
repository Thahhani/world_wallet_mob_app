// import 'package:flutter/material.dart';

// class TransactionHistoryScreen extends StatefulWidget {
//   @override
//   _TransactionHistoryScreenState createState() =>
//       _TransactionHistoryScreenState();
// }

// class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
//   // Mock data for transactions
//   List<Map<String, dynamic>> transactions = [
//     {'type': 'Room Booking', 'amount': 100, 'date': '2024-12-01'},
//     {'type': 'Food Order', 'amount': 25, 'date': '2024-12-02'},
//     {'type': 'Room Booking', 'amount': 80, 'date': '2024-12-05'},
//     {'type': 'Food Order', 'amount': 30, 'date': '2024-12-06'},
//     {'type': 'Room Booking', 'amount': 50, 'date': '2024-12-10'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Transaction History"),
//         leading: BackButton(),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               Text(
//                 "Your Transaction History",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Transaction List
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: transactions.length,
//                 itemBuilder: (context, index) {
//                   return _buildTransactionCard(transactions[index]);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionCard(Map<String, dynamic> transaction) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 8,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: InkWell(
//         onTap: () {
//           // Optionally, handle tap for more details
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               // Icon for transaction type
//               Icon(
//                 transaction['type'] == 'Room Booking'
//                     ? Icons.hotel
//                     : Icons.fastfood,
//                 color: Colors.deepPurple,
//                 size: 30,
//               ),
//               SizedBox(width: 15),

//               // Transaction details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       transaction['type'],
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       'Date: ${transaction['date']}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Transaction amount
//               Text(
//                 '\$${transaction['amount']}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: transaction['amount'] > 50
//                       ? Colors.green
//                       : Colors.orange,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
