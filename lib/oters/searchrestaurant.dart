import 'package:flutter/material.dart';

class Searchrestaurant extends StatefulWidget {
  const Searchrestaurant({super.key});

  @override
  _SearchrestaurantState createState() => _SearchrestaurantState();
}

class _SearchrestaurantState extends State<Searchrestaurant> {
  // A list of restaurants, each with a name, type, price, status, location, and image URL
  List<Map<String, String>> restaurant = [
    {
      'res_name': 'Paragon',
      'res_type': 'Casual Dining',
      'location': 'Calicut',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdNBnDe-O51UtOt3c7zIMTsVksTYIDEJ2Gdg&s',
    },
    {
      'res_name': 'M-Grill',
      'res_type': 'Fast Food',
      'location': 'Calicut',
      'image': 'https://media-cdn.tripadvisor.com/media/photo-s/0a/bf/53/42/outside.jpg',
    },
    {
      'res_name': 'Keraleeyam Calicut',
      'res_type': 'Fine Dining',
      'cuisine_type': 'Indian',
      'location': 'Arayidathupalam',
      'image': 'https://media-cdn.tripadvisor.com/media/photo-s/29/dd/f6/8f/keraleeyam-restaurant.jpg',
    },
    // Add more restaurants as needed
  ];

  // List to store filtered restaurants
  List<Map<String, String>> filteredRes = [];

  // Search query
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredRes = restaurant; // Initialize with all restaurants
  }

  // Function to filter restaurants based on search query
  void _filterRes(String query) {
    setState(() {
      searchQuery = query;
      filteredRes = restaurant
          .where((restaurant) =>
              restaurant['location']!.toLowerCase().contains(query.toLowerCase()) ||
              restaurant['res_type']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: TextField(
          onChanged: _filterRes,
          decoration: InputDecoration(
            hintText: 'City, restaurant name or cuisine type...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredRes.length,
        itemBuilder: (context, index) {
          final restaurantItem = filteredRes[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 130,
                    width: 130,
                    child: Image.network(
                      restaurantItem['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantItem['res_name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${restaurantItem['res_type']} | ${restaurantItem['location']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 5),
                        if (restaurantItem.containsKey('cuisine_type'))
                          Text(
                            'Cuisine: ${restaurantItem['cuisine_type']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add booking logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600], // Button color
                            minimumSize: Size(double.infinity, 45), // Button width and height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
