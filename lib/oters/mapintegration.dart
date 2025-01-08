// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RestaurantMapScreen extends StatefulWidget {
//   @override
//   _RestaurantMapScreenState createState() => _RestaurantMapScreenState();
// }

// class _RestaurantMapScreenState extends State<RestaurantMapScreen> {
//   late GoogleMapController _mapController;

//   // Define a list of restaurant locations (latitude, longitude)
//   final Set<Marker> _markers = {};
  
//   // Sample data for restaurants (for demonstration)
//   final List<Map<String, dynamic>> _restaurants = [
//     {
//       'name': 'Ocean Breeze Restaurant',
//       'latitude': 37.7749,
//       'longitude': -122.4194,
//       'cuisine': 'Seafood',
//       'priceRange': '\$20 - \$50',
//       'rating': 4.5
//     },
//     {
//       'name': 'Mountain View Diner',
//       'latitude': 37.7849,
//       'longitude': -122.4094,
//       'cuisine': 'American',
//       'priceRange': '\$10 - \$30',
//       'rating': 4.0
//     },
//     {
//       'name': 'City Grill',
//       'latitude': 37.7649,
//       'longitude': -122.4294,
//       'cuisine': 'Grill',
//       'priceRange': '\$15 - \$40',
//       'rating': 4.2
//     },
//     // Add more restaurants here
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _restaurants.forEach((restaurant) {
//       _markers.add(
//         Marker(
//           markerId: MarkerId(restaurant['name']),
//           position: LatLng(restaurant['latitude'], restaurant['longitude']),
//           infoWindow: InfoWindow(
//             title: restaurant['name'],
//             snippet: '${restaurant['cuisine']} | Rating: ${restaurant['rating']}',
//             onTap: () {
//               _showRestaurantDetails(restaurant);
//             },
//           ),
//         ),
//       );
//     });
//   }

//   // Method to show restaurant details when a marker is tapped
//   void _showRestaurantDetails(Map<String, dynamic> restaurant) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 restaurant['name'],
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text('Cuisine: ${restaurant['cuisine']}'),
//               Text('Price Range: ${restaurant['priceRange']}'),
//               Text('Rating: ${restaurant['rating']} stars'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // You can add functionality to book a table or view more info
//                 },
//                 child: Text('Book a Table'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to create the map
//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Nearby Restaurants"),
//         backgroundColor: Colors.teal[600],
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.7749, -122.4194), // Set the default camera position to San Francisco
//           zoom: 14,
//         ),
//         markers: _markers,
//         onMapCreated: _onMapCreated,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//       ),
//     );
//   }
// }

