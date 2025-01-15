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
  final List<Map<String, dynamic>> reviews;
  final String roomNumber; // New field
  final String roomType; // New field
  final String bedType; // New field
  final String roomService; // New field (optional)
  final String status; // New field (optional)
  final double rating;

  Room({
    required this.rating,
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
      rating: map['average_rating'],
      id: map['id'] ??
          '', // Ensure this value is never null by defaulting to an empty string
      name: map['name'] ?? '', // Same here, default to empty string if null
      description: map['roomservice'] ?? '', // Default to empty string
      price: price,
      location: map['location'] ?? '', // Default to empty string
      amenities: List<String>.from(
          map['amenities'] ?? []), // Default to an empty list if null
      imageUrl: map['roomimage'] ?? '', // Default to empty string
      reviews: List<Map<String, dynamic>>.from(
          map['feedbacks']), // Default to an empty list
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
  TextEditingController amountController = TextEditingController();

  // Function to filter rooms based on the location (search query)
  void filterByLocation(String query) {
    setState(() {
      searchQuery = query;

      // Filter rooms based on location (case-insensitive)
      filteredRooms = allRooms.where((room) {
        return room.location.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // After applying location filter, apply the price filter as well
      filterByAmount(amountController.text);
    });
  }

  // Function to filter rooms based on the entered amount (budget)
  void filterByAmount(String amountText) {
    setState(() {
      // Get the price filter from the controller and try parsing it to a double
      double? maxPrice =
          amountText.isNotEmpty ? double.tryParse(amountText) : null;

      // Further filter rooms based on price (maxPrice)
      filteredRooms = filteredRooms.where((room) {
        return maxPrice == null || room.price >= maxPrice;
      }).toList();
    });
  }

  // Function to fetch rooms from the API and update state
  void fetchAndUpdateRooms() async {
    try {
      List<Room> rooms = await fetchRooms(); // Fetch rooms from API
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
    amountController.addListener(() {
      filterByAmount(amountController.text);
      setState(() {});
    });
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
            // Search bar with decoration and rounded corners for location search
            TextField(
              onChanged: filterByLocation, // Call location filter
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

            SizedBox(height: 5),

            // Amount filter (budget input)
            TextField(
              controller: amountController,
              onChanged: (value) {
                filterByAmount(value); // Call price filter
              },
              decoration: InputDecoration(
                labelText: 'Enter Budget',
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(Icons.attach_money, color: Colors.deepPurple),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), // Allow decimal input for budget
            ),

            SizedBox(height: 10),

            // Display filtered rooms or show loading spinner
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
                              child: Image.network('$baseUrl/${room.imageUrl}',
                                  fit: BoxFit.fill),
                            ),
                            title: Text(
                              room.name ??
                                  "Unnamed Room", // Display default name if null
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\$${room.price} / night',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.green)),
                                SizedBox(height: 2),
                                Text(room.location,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(room.rating.toString(),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey)),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15,
                                    )
                                  ],
                                ),
                                SizedBox(height: 4),
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
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.room.name), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  '$baseUrl/${widget.room.imageUrl}',
                  fit: BoxFit.fill,
                ),
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
              Text('Room Service: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(widget.room.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Reviews: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              for (var amenity in widget.room.reviews)
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(amenity['feedback'],
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(amenity['rating']),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                           SizedBox(width: 10,)
                         
                        ],
                      )
                      // Card(child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: ,
                      // )),
                      
                    ],
                  ),
                ),
              SizedBox(height: 16),
              if (widget.room.status == 'available')
                Container(
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: bookRoom,
                    child: Text('Book Room'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white),
                  ),
                ),
              if (widget.room.status != 'available')
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Not available'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 235, 246, 229)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
