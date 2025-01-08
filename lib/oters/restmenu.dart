import 'package:flutter/material.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key});

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  // A list of restaurants with menus, reviews, and more details
  List<Map<String, dynamic>> restaurant = [
    {
      'res_name': 'Paragon',
      'res_type': 'Casual Dining',
      'location': 'Calicut',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdNBnDe-O51UtOt3c7zIMTsVksTYIDEJ2Gdg&s',
      'reviews': [
        {'reviewer': 'John', 'rating': 5, 'comment': 'Great food, good ambiance!'},
        {'reviewer': 'Alice', 'rating': 4, 'comment': 'Nice place for casual dining.'},
      ],
      'menu': [
        {'name': 'Chicken Biryani', 'price': 250},
        {'name': 'Mutton Korma', 'price': 350},
        {'name': 'Fish Fry', 'price': 300},
      ],
    },
    {
      'res_name': 'M-Grill',
      'res_type': 'Fast Food',
      'location': 'Calicut',
      'image': 'https://media-cdn.tripadvisor.com/media/photo-s/0a/bf/53/42/outside.jpg',
      'reviews': [
        {'reviewer': 'Bob', 'rating': 4, 'comment': 'Good burgers, but a bit expensive.'},
        {'reviewer': 'Emma', 'rating': 5, 'comment': 'Love their fries!'},
      ],
      'menu': [
        {'name': 'Cheese Burger', 'price': 150},
        {'name': 'French Fries', 'price': 80},
        {'name': 'Cold Drink', 'price': 40},
      ],
    },
    {
      'res_name': 'Keraleeyam Calicut',
      'res_type': 'Fine Dining',
      'location': 'Arayidathupalam',
      'image': 'https://media-cdn.tripadvisor.com/media/photo-s/29/dd/f6/8f/keraleeyam-restaurant.jpg',
      'reviews': [
        {'reviewer': 'Martha', 'rating': 5, 'comment': 'Amazing experience! The food was out of this world.'},
        {'reviewer': 'Raj', 'rating': 4, 'comment': 'Good quality food, but expensive.'},
      ],
      'menu': [
        {'name': 'Kerala Sadya', 'price': 500},
        {'name': 'Fish Curry', 'price': 300},
        {'name': 'Appam', 'price': 150},
      ],
    },
  ];

  // List to store filtered restaurants
  List<Map<String, dynamic>> filteredRes = [];

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
              restaurant['res_type']!.toLowerCase().contains(query.toLowerCase()) ||
              restaurant['res_name']!.toLowerCase().contains(query.toLowerCase()))
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
            hintText: 'Search for city, restaurant name, or type...',
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
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: InkWell(
              onTap: () {
                // Navigate to restaurant detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailPage(restaurantItem),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 130,
                      width: 130,
                      child: Image.network(
                        restaurantItem['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantItem['res_name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
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
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              minimumSize: Size(double.infinity, 45),
                            ),
                            child: Text(
                              'View Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurantItem;

  RestaurantDetailPage(this.restaurantItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantItem['res_name']),
        backgroundColor: Colors.teal[600],
      ),
      body: ListView(
        children: [
          // Display restaurant image
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.network(
              restaurantItem['image'],
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),

          // Display restaurant name and type
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              restaurantItem['res_name'],
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${restaurantItem['res_type']} - ${restaurantItem['location']}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),

          // Menu Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ...restaurantItem['menu'].map<Widget>((item) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: ListTile(
                title: Text(item['name']),
                subtitle: Text('Price: ₹${item['price']}'),
              ),
            );
          }).toList(),

          // Reviews Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Reviews',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ...restaurantItem['reviews'].map<Widget>((review) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: ListTile(
                title: Text(review['reviewer']),
                subtitle: Text('${review['comment']} - Rating: ${review['rating']} ⭐'),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
