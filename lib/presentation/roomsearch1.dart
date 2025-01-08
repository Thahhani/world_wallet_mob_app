// import 'package:flutter/material.dart';
// import 'package:flutterproject1/presentation/paymentintws.dart';

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
//     imageUrl:
//         'https://t3.ftcdn.net/jpg/06/19/00/08/360_F_619000872_AxiwLsfQqRHMkNxAbN4l5wg1MsPgBsmo.jpg',
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
//     imageUrl:
//         'https://cf.bstatic.com/xdata/images/hotel/max1024x768/122445977.jpg?k=2903431b72d6484fd496d0019e519954676fc737451f53496ca21684441b8205&o=&hp=1',
//     reviews: [
//       'Amazing view of the park, very peaceful.',
//       'Comfortable and quiet, perfect for relaxation.',
//     ],
//   ),
// ];

// class RoomSearch1 extends StatefulWidget {
//   @override
//   _RoomSearch1State createState() => _RoomSearch1State();
// }

// class _RoomSearch1State extends State<RoomSearch1> {
//   List<Room> filteredRooms = rooms; // Start with all rooms
//   String searchQuery = '';
//   DateTime? selectedDate=DateTime.now();

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
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               ),
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               // mainAxisSSize: MainAxisSize.min,
//               children: [
//                 InkWell(
//                   onTap: ()async {
//               selectedDate=await      showDatePicker(
//                         context: context,
//                         firstDate: DateTime.now(),
//                         initialDate: DateTime.now(),
//                         lastDate: DateTime.now().add(Duration(days: 30)));
//                   },
//                   child: Container(
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month),
//                         Text(selectedDate.toString().substring(0,10),style: TextStyle(fontWeight: FontWeight.bold),),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
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
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('\$${room.price} / night',
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.green)),
//                           SizedBox(height: 4),
//                           Text(room.location,
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey)),
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
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentProcess()));
//     });

//     // You can add additional logic for the booking process here
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text('Booking Confirmation'),
//   //         content: Text(
//   //             'You have successfully booked the room: ${widget.room.name}.'),
//   //         actions: [
//   //           TextButton(
//   //             child: Text('OK'),
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   }

//   // void cancelBooking() {
//   //   setState(() {
//   //     isBooked = false; // Cancel the booking
//   //   });

//   //   // Cancellation logic here (refund policy can be added)
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text('Cancellation'),
//   //         content: Text(
//   //             'Your booking has been cancelled. You will receive a full refund as per our policy.'),
//   //         actions: [
//   //           TextButton(
//   //             child: Text('OK'),
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(widget.room.name), backgroundColor: Colors.deepPurple),
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
//               Text(widget.room.name,
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text('Price: \$${widget.room.price}',
//                   style: TextStyle(fontSize: 20, color: Colors.green)),
//               SizedBox(height: 8),
//               Text('Location: ${widget.room.location}',
//                   style: TextStyle(fontSize: 16)),
//               SizedBox(height: 16),
//               Text('Description:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text(widget.room.description, style: TextStyle(fontSize: 16)),
//               SizedBox(height: 16),
//               Text('Amenities:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               for (var amenity in widget.room.amenities)
//                 Row(
//                   children: [
//                     Icon(Icons.check, color: Colors.green, size: 16),
//                     SizedBox(width: 8),
//                     Text(amenity, style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               // SizedBox(height: 16),
//               // if (isBooked) ...[
//               //   ElevatedButton(
//               //     onPressed: cancelBooking,
//               //     child: Text('Cancel Booking'),
//               //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               //   ),
//               //   SizedBox(height: 8),
//               //   Text(
//               //     'Refund Policy: You are eligible for a full refund if you cancel within 24 hours.',
//               //     style: TextStyle(color: Colors.blueGrey, fontSize: 14),
//               //   ),
//             //   ] else ...[
//                 ElevatedButton(
//                   onPressed: bookRoom,
//                   child: Text('Book Room'),
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           const Color.fromARGB(255, 235, 246, 229)),
//                 ),
//               ],
//             // ],
//          ),
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:worldwalletnew/presentation/paymentintws.dart';
import 'package:worldwalletnew/presentation/roombooking.dart';
import 'package:worldwalletnew/services/loginApi.dart';

// Room class now includes roomNumber, roomType, bedType, etc.
class Room {
  final int id;
  final String name;
  final String description;
  final double price;
  final String location;
  final List<String> amenities;
  final String imageUrl;
  final List<String> reviews;
  final String roomNumber; // New field
  final String roomType; // New field
  final String bedType; // New field
  final String roomService; // New field (optional)
  final String status; // New field (optional)

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.amenities,
    required this.imageUrl,
    required this.reviews,
    required this.roomNumber, // Initialize new fields
    required this.roomType, // Initialize new fields
    required this.bedType, // Initialize new fields
    required this.roomService, // Initialize new fields
    required this.status, // Initialize new fields
  });

  // Factory constructor to create a Room from a map (API response)
  factory Room.fromMap(Map<String, dynamic> map) {
    double price = 0.0;
    if (map['price'] is String) {
      price = double.tryParse(map['price']) ?? 0.0;
    } else if (map['price'] is num) {
      price = map['price'].toDouble();
    }

    return Room(
      id: map['id'] ??
          '', // Ensure this value is never null by defaulting to an empty string
      name: map['name'] ?? '', // Same here, default to empty string if null
      description: map['description'] ?? '', // Default to empty string
      price: price,
      location: map['location'] ?? '', // Default to empty string
      amenities: List<String>.from(
          map['amenities'] ?? []), // Default to an empty list if null
      imageUrl: map['roomimage'] ?? '', // Default to empty string
      reviews:
          List<String>.from(map['reviews'] ?? []), // Default to an empty list
      roomNumber: map['roomnumber'] ?? '', // Default to empty string if null
      roomType: map['roomtype'] ?? '', // Default to empty string if null
      bedType: map['bedtype'] ?? '', // Default to empty string if null
      roomService: map['roomservice'] ?? '', // Default to empty string if null
      status: map['status'] ?? '', // Default to empty string if null
    );
  }
}

// Sample API call to fetch rooms
final Dio _dio = Dio(); // Create a Dio instance for HTTP requests

Future<List<Room>> fetchRooms() async {
  try {
    final response = await _dio.get('$baseUrl/viewroom');

    if (response.statusCode == 200) {
      // Assuming the response data is a list of rooms
      List<dynamic> data = response.data;
      print(response.data);

      // Convert the list of data into a list of Room objects
      return data.map((roomData) => Room.fromMap(roomData)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  } catch (e) {
    print('Error: $e');
    rethrow; // Throw error again to be handled by the calling code
  }
}

class RoomSearch1 extends StatefulWidget {
  @override
  _RoomSearch1State createState() => _RoomSearch1State();
}

class _RoomSearch1State extends State<RoomSearch1> {
  List<Room> filteredRooms = []; // Start with an empty list
  List<Room> allRooms = [];
  String searchQuery = '';
  DateTime? selectedDate = DateTime.now();

  // Function to filter rooms based on the search query
  void filterRooms(String query) {
    setState(() {
      searchQuery = query;
      filteredRooms = allRooms
          .where((room) =>
              room.name.toLowerCase().contains(query.toLowerCase()) ||
              room.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Function to fetch rooms from the API and update state
  void fetchAndUpdateRooms() async {
    try {
      List<Room> rooms = await fetchRooms();
      setState(() {
        allRooms = rooms;
        filteredRooms = rooms; // Initially, show all rooms
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch rooms: $e'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndUpdateRooms(); // Fetch rooms when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Rooms'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar with decoration and rounded corners
            TextField(
              onChanged: filterRooms,
              decoration: InputDecoration(
                labelText: 'Search Rooms',
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30)));
                    setState(
                        () {}); // Rebuild the widget with the selected date
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text(
                          selectedDate.toString().substring(0, 10),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredRooms.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: SizedBox(
                                height: 100,
                                width: 60, // Limit width of the leading image
                                child: Image.network(
                                    '$baseUrl/${room.imageUrl}',
                                    fit: BoxFit.fill)),
                            title: Text(
                              room.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\$${room.price} / night',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.green)),
                                SizedBox(height: 4),
                                Text(room.location,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RoomDetailPage(room: room),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// RoomDetailPage remains unchanged except for the carousel code below
class RoomDetailPage extends StatefulWidget {
  final Room room;

  RoomDetailPage({required this.room});

  @override
  _RoomDetailPageState createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  bool isBooked = false; // Track booking status

  void bookRoom() {
    setState(() {
      isBooked = true; // Mark room as booked
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingScreen(
              room: widget.room,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prepare image URLs for carousel (e.g., from the room's images)
    // List<String> imageUrls = [
    //   widget.room.imageUrl, // Main image
    //   'assets/default_image.png', // Fallback image (example)
    //   // You can add more URLs to create a multi-image carousel
    // ];

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.room.name), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider for images
              // CarouselSlider(
              //   items: imageUrls.map((url) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //           margin: EdgeInsets.symmetric(horizontal: 5),
              //           child: url.isNotEmpty && url != 'null'
              //               ? Image.network(
              //                   widget.room.imageUrl, // Use real backend URL
              //                   fit: BoxFit.cover,
              //                   loadingBuilder:
              //                       (context, child, loadingProgress) {
              //                     if (loadingProgress == null) {
              //                       return child;
              //                     } else {
              //                       return Center(
              //                         child: CircularProgressIndicator(),
              //                       );
              //                     }
              //                   },
              //                 )
              //               : Image.asset(
              //                   widget.room.imageUrl, // Fallback image
              //                   fit: BoxFit.cover,
              //                 ),
              //         );
              //       },
              //     );
              //   }).toList(),
              //   options: CarouselOptions(
              //     height: 200.0, // Set the height of the carousel
              //     enlargeCenterPage: true,
              //     autoPlay: true,
              //     aspectRatio: 16 / 9,
              //     viewportFraction: 0.9,
              //   ),
              // ),

              SizedBox(height: 16),
              Container(
                height: 180,
                width: double.infinity,
                child: Image.network('$baseUrl/${widget.room.imageUrl}',fit: BoxFit.fill,),
              ),
              SizedBox(height: 16),
              Text(widget.room.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Price: \$${widget.room.price}',
                  style: TextStyle(fontSize: 20, color: Colors.green)),
              SizedBox(height: 8),
              Text('Location: ${widget.room.location}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Room Type: ${widget.room.roomType}',
                  style: TextStyle(fontSize: 16)),
              Text('Bed Type: ${widget.room.bedType}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Description: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(widget.room.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Amenities: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              for (var amenity in widget.room.amenities)
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Text(amenity, style: TextStyle(fontSize: 16)),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: bookRoom,
                child: Text('Book Room'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 246, 229)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
