// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class Room {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final String location;
//   final List<String> amenities;
//   final String imageUrl;
//   final List<String> reviews;

//   Room({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.location,
//     required this.amenities,
//     required this.imageUrl,
//     required this.reviews,
//   });
// }

// // Sample room data
// List<Room> rooms = [
//   Room(
//     id: '1',
//     name: 'Cozy City Center Room',
//     description: 'A cozy, affordable room in the heart of the city.',
//     price: 8000,
//     location: 'City Center',
//     amenities: ['Wi-Fi', 'Air Conditioning', 'TV'],
//     imageUrl: 'https://t3.ftcdn.net/jpg/06/19/00/08/360_F_619000872_AxiwLsfQqRHMkNxAbN4l5wg1MsPgBsmo.jpg',
//     reviews: [
//       'Great location and very clean.',
//       'Comfortable stay, will return again.',
//       'Affordable and convenient, highly recommend!',
//     ],
//   ),
//   Room(
//     id: '2',
//     name: 'Parkside Affordable Suite',
//     description: 'A spacious room with a beautiful park view.',
//     price: 6000,
//     location: 'Near Park',
//     amenities: ['Wi-Fi', 'King-size bed', 'TV'],
//     imageUrl: 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/122445977.jpg?k=2903431b72d6484fd496d0019e519954676fc737451f53496ca21684441b8205&o=&hp=1',
//     reviews: [
//       'Amazing view of the park, very peaceful.',
//       'Comfortable and quiet, perfect for relaxation.',
//     ],
//   ),
// ];

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Room Booking App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: RoomSearch1(),
//     );
//   }
// }

// class RoomSearch1 extends StatefulWidget {
//   @override
//   _RoomSearch1State createState() => _RoomSearch1State();
// }

// class _RoomSearch1State extends State<RoomSearch1> {
//   List<Room> filteredRooms = rooms; // Start with all rooms
//   String searchQuery = '';

//   void filterRooms(String query) {
//     setState(() {
//       searchQuery = query;
//       filteredRooms = rooms
//           .where((room) =>
//               room.name.toLowerCase().contains(query.toLowerCase()) ||
//               room.location.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Browse Rooms'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Search bar with decoration and rounded corners
//             TextField(
//               onChanged: filterRooms,
//               decoration: InputDecoration(
//                 labelText: 'Search Rooms',
//                 labelStyle: TextStyle(color: Colors.deepPurple),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
//                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredRooms.length,
//                 itemBuilder: (context, index) {
//                   final room = filteredRooms[index];
//                   return Card(
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ListTile(
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           room.imageUrl,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         room.name,
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('\$${room.price} / night', style: TextStyle(fontSize: 16, color: Colors.green)),
//                           SizedBox(height: 4),
//                           Text(room.location, style: TextStyle(fontSize: 14, color: Colors.grey)),
//                         ],
//                       ),
//                       trailing: Icon(Icons.arrow_forward_ios),
//                       onTap: () {
//                         // Navigate to room detail page with reservation functionality
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => RoomDetailPage(room: room),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoomDetailPage extends StatefulWidget {
//   final Room room;

//   RoomDetailPage({required this.room});

//   @override
//   _RoomDetailPageState createState() => _RoomDetailPageState();
// }

// class _RoomDetailPageState extends State<RoomDetailPage> {
//   bool isBooked = false; // Track booking status

//   void bookRoom() {
//     setState(() {
//       isBooked = true; // Mark room as booked
//     });

//     // You can add additional logic for the booking process here
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Booking Confirmation'),
//           content: Text('You have successfully booked the room: ${widget.room.name}.'),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void cancelBooking() {
//     setState(() {
//       isBooked = false; // Cancel the booking
//     });

//     // Cancellation logic here (refund policy can be added)
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Cancellation'),
//           content: Text('Your booking has been cancelled. You will receive a full refund as per our policy.'),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.room.name), backgroundColor: Colors.deepPurple),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(widget.room.imageUrl),
//               ),
//               SizedBox(height: 16),
//               Text(widget.room.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text('Price: \$${widget.room.price}', style: TextStyle(fontSize: 20, color: Colors.green)),
//               SizedBox(height: 8),
//               Text('Location: ${widget.room.location}', style: TextStyle(fontSize: 16)),
//               SizedBox(height: 16),
//               Text('Description:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text(widget.room.description, style: TextStyle(fontSize: 16)),
//               SizedBox(height: 16),
//               Text('Amenities:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               for (var amenity in widget.room.amenities)
//                 Row(
//                   children: [
//                     Icon(Icons.check, color: Colors.green, size: 16),
//                     SizedBox(width: 8),
//                     Text(amenity, style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               SizedBox(height: 16),
//               if (isBooked) ...[
//                 ElevatedButton(
//                   onPressed: cancelBooking,
//                   child: Text('Cancel Booking'),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Refund Policy: You are eligible for a full refund if you cancel within 24 hours.',
//                   style: TextStyle(color: Colors.blueGrey, fontSize: 14),
//                 ),
//               ] else ...[
//                 ElevatedButton(
//                   onPressed: bookRoom,
//                   child: Text('Book Room'),
//                   style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 235, 246, 229)),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
