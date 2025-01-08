import 'package:flutter/material.dart';

class Searchroom extends StatefulWidget {
  Searchroom({super.key});

  @override
  _SearchroomState createState() => _SearchroomState();
}

class _SearchroomState extends State<Searchroom> {
  // A list of rooms, each with a name, type, bed type, price, and location
  List<Map<String, String>> rooms = [
    {
      'room_no': '1334',
      'room_type': 'Presidential Suite',
      'bed_type': 'King',
      'price': '3000',
      'status': 'Booked',
      'location': 'Beach View',
      'image': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/122445977.jpg?k=2903431b72d6484fd496d0019e519954676fc737451f53496ca21684441b8205&o=&hp=1'
    },
    {
      'room_no': '1335',
      'room_type': 'Deluxe Suite',
      'bed_type': 'Queen',
      'price': '2500',
      'status': 'Available',
      'location': 'City View',
      'image': 'https://example.com/room2.jpg'
    },
    {
      'room_no': '1336',
      'room_type': 'Standard Room',
      'bed_type': 'Single',
      'price': '1500',
      'status': 'Available',
      'location': 'Mountain View',
      'image': 'https://example.com/room3.jpg'
    },
    // Add more rooms as needed
  ];

  // List to store filtered rooms
  List<Map<String, String>> filteredRooms = [];

  // Search query
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredRooms = rooms; // Initialize with all rooms
  }

  // Function to filter rooms based on search query
  void _filterRooms(String query) {
    setState(() {
      searchQuery = query;
      filteredRooms = rooms
          .where((room) => room['location']!.toLowerCase().contains(query.toLowerCase()) ||
              room['room_type']!.toLowerCase().contains(query.toLowerCase()) ||
              room['bed_type']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 2)),
            ],
          ),
          child: TextField(
            onChanged: _filterRooms,
            decoration: InputDecoration(
              hintText: 'Search by location or type...',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.teal[600]),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredRooms.length,
        itemBuilder: (context, index) {
          final room = filteredRooms[index];
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      room['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Room No: ${room['room_no']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text(
                          '${room['room_type']}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Bed Type: ${room['bed_type']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text('Price: \$${room['price']}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                        SizedBox(height: 8),
                        Text('Location: ${room['location']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        SizedBox(height: 10),
                        if (room['status'] == 'Available')
                          ElevatedButton(
                            onPressed: () {
                              // Booking action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(150, 50),
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Room Booked',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
