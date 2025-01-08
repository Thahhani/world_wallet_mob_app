import 'package:flutter/material.dart';

void main() {
  runApp(FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RestaurantList(),
    );
  }
}

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Paragon',
      'location': 'Calicut',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdNBnDe-O51UtOt3c7zIMTsVksTYIDEJ2Gdg&s',
      'menu': [
        {'name': 'Chicken Biryani', 'price': 250},
        {'name': 'Mutton Korma', 'price': 350},
      ],
    },
    {
      'name': 'M-Grill',
      'location': 'Calicut',
      'image': 'https://media-cdn.tripadvisor.com/media/photo-s/0a/bf/53/42/outside.jpg',
      'menu': [
        {'name': 'Cheese Burger', 'price': 150},
        {'name': 'French Fries', 'price': 80},
      ],
    },
    {
      'name': 'Saffron',
      'location': 'Kochi',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTib6aKlzmCZFcFxPSn15FqVRkxYec0iWj1nA&s',
      'menu': [
        {'name': 'Fish Curry', 'price': 300},
        {'name': 'Beef Fry', 'price': 400},
      ],
    },
  ];

  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Restaurants', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        elevation: 10,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by location',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.deepPurple)),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurants
                  .where((restaurant) =>
                      restaurant['location']
                          .toLowerCase()
                          .contains(searchQuery))
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                var filteredRestaurants = restaurants
                    .where((restaurant) => restaurant['location']
                        .toLowerCase()
                        .contains(searchQuery))
                    .toList();
                var restaurant = filteredRestaurants[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailPage(restaurant),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(restaurant['image'], height: 100, width: 100, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(restaurant['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                                Text('Location: ${restaurant['location']}', style: TextStyle(fontSize: 16, color: Colors.grey)),
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
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  final TextEditingController quantityController = TextEditingController();

  RestaurantDetailPage(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          Image.network(restaurant['image']),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Menu', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          ),
          ...restaurant['menu'].map<Widget>((item) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text(item['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('Price: ₹${item['price']}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    _showOrderDialog(context, item);
                  },
                  child: Text('Order', style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showOrderDialog(BuildContext context, item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Place Order', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Quantity', style: TextStyle(fontSize: 18)),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                var quantity = int.parse(quantityController.text);
                var totalPrice = quantity * item['price'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSummaryPage(item, quantity, totalPrice.toInt()),
                  ),
                );
              },
              child: Text('Place Order', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        );
      },
    );
  }
}

class OrderSummaryPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final int quantity;
  final int totalPrice;

  OrderSummaryPage(this.item, this.quantity, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item: ${item['name']}', style: TextStyle(fontSize: 18)),
            Text('Quantity: $quantity', style: TextStyle(fontSize: 18)),
            Text('Total Price: ₹$totalPrice', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 168, 234, 75)),
              onPressed: () {
                // Navigate to Payment Page
              },
              child: Text('Proceed to Payment', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
