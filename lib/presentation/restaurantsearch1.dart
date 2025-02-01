import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/bookFood.dart';
import 'package:worldwalletnew/services/getfoodorderingApi.dart';
import 'package:worldwalletnew/services/getmenuApi.dart';
import 'package:worldwalletnew/services/loginApi.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  List<Map<String, dynamic>> filteredRestaurants = [];
  List<Map<String, dynamic>> allRestaurants = []; // Store all restaurants
  bool isLoading = true;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  // Fetch restaurant data
  Future<void> _fetchRestaurants() async {
    try {
      final response = await dio.get('$baseUrl/viewrestaurant');
      print("Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}");

        // Check if the response contains a list
        if (response.data is List) {
          List<dynamic> data = response.data;
          List<Map<String, dynamic>> restaurants =
              data.map((json) => Map<String, dynamic>.from(json)).toList();
          setState(() {
            allRestaurants = restaurants;
            filteredRestaurants = restaurants; // Initially show all restaurants
            isLoading = false;
          });
        } else {
          print("Unexpected response format: ${response.data}");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print("API Response Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching restaurants: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Filter restaurants based on name or place
  void filterRestaurants(String query) {
    setState(() {
      filteredRestaurants = allRestaurants.where((restaurant) {
        return restaurant['name'].toLowerCase().contains(query.toLowerCase()) ||
            restaurant['place'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Nearby Restaurants'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              onChanged: (value) {
                filterRestaurants(
                    value); // Trigger the filter when user changes text
              },
              decoration: InputDecoration(
                labelText: 'Search by name or place',
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              style: TextStyle(color: Colors.black),
            ),

            SizedBox(height: 16),

            // Loading indicator or restaurant list
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = filteredRestaurants[index];
                        return Card(
                          elevation: 8,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(
                              restaurant['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${restaurant['place']}'),
                                Text('${restaurant['phoneno']} '),
                                if(restaurant['average_rating']!=null)
                                Row(
                                  children: [
                                    
                                    Text(
                                        '${restaurant['average_rating'].toStringAsFixed(1) }'),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: Colors.deepOrangeAccent,
                            ),
                            onTap: () async {
                              List<Map<String, dynamic>> menudata =
                                  await fetchFoodMenu(restaurant['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailPage(
                                    restaurant: restaurant,
                                    menudata: menudata,
                                  ),
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

class RestaurantDetailPage extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final List<Map<String, dynamic>> menudata;

  RestaurantDetailPage({required this.restaurant, required this.menudata});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  List<Map<String, dynamic>> cart = []; // Cart as a list of maps

  void addToCart(int menuId, String foodName, double price) {
    setState(() {
      // Check if item is already in cart
      var existingItem = cart.firstWhere(
        (item) => item['menuId'] == menuId,
        orElse: () => {},
      );

      if (existingItem.isNotEmpty) {
        // Update quantity if the item already exists
        existingItem['quantity']++;
      } else {
        // Add new item to the cart
        cart.add({
          'MENUID': menuId,
          'foodName': foodName,
          'price': price,
          'quantity': 1,
        });
      }
    });
  }

  void updateQuantity(Map<String, dynamic> item, int quantity) {
    setState(() {
      item['quantity'] = quantity;
    });
  }

  void removeFromCart(int menuId) {
    setState(() {
      cart.removeWhere((item) => item['menuId'] == menuId);
    });
  }

  // void placeFoodOrder(BuildContext context) {
  //   // Prepare the order data
  //   List<Map<String, dynamic>> orderData = [];
  //   for (var item in cart) {
  //     orderData.add({
  //       'USERID': 'loginId',  // Replace with actual loginId
  //       'MENUID': item['menuId'],
  //       'quantity': item['quantity'],
  //     });
  //   }

  // You can send the order data to your API here
  //   print("Order Data: $orderData");

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Order placed successfully!')),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/03/24/73/92/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Details
                Text(
                  widget.restaurant['name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${widget.restaurant['place']}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('${widget.restaurant['phoneno']}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),

                ExpansionTile(
                  title: Text('Reviews'),
                  children: [
                    Container(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = widget.restaurant['feedbacks'][index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text(item['user_id']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(item['rating']),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['feedback']),
                                    Text(
                                      'Reply:',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(item['reply'] ?? 'no reply'),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: widget.restaurant['feedbacks'].length,
                        ))
                  ],
                ),

                SizedBox(height: 5),

                // Menu Section
                Text(
                  'Menu:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                // Menu Items List
                Container(
                  height: 400, // Adjust as needed
                  child: ListView.builder(
                    itemCount: widget.menudata.length,
                    itemBuilder: (context, index) {
                      var menuItem = widget.menudata[index];
                      double price =
                          double.tryParse(menuItem['price'].toString()) ?? 0.0;

                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(menuItem['foodname']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(menuItem['foodtype']),
                              Text(menuItem['description']),
                              Text('Price: \$${price.toString()}'),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              addToCart(
                                  menuItem['id'], menuItem['foodname'], price);
                            },
                            child: Text('Add to Cart'),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Cart Section Button
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Cart screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          cart: cart,
                          // totalAmount: totalAmount,
                          // placeOrder: placeFoodOrder,
                        ),
                      ),
                    );
                  },
                  child: Text('Go to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  // final Function(BuildContext) placeOrder;

  CartScreen({
    required this.cart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Calculate the total amount
  double get totalAmount {
    double total = 0;
    for (var item in widget.cart) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  // Method to handle quantity change
  void updateQuantity(Map<String, dynamic> cartItem, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cartItem['quantity'] = newQuantity;
      } else {
        // Remove item from cart if quantity is 0
        widget.cart.remove(cartItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  var cartItem = widget.cart[index];

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(cartItem['foodName']),
                      subtitle: Row(
                        children: [
                          Text('Price: \$${cartItem['price']}'),
                          SizedBox(width: 10),
                          Text('Qty:'),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (cartItem['quantity'] > 1) {
                                updateQuantity(
                                    cartItem, cartItem['quantity'] - 1);
                              }
                            },
                          ),
                          Text('${cartItem['quantity']}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              updateQuantity(
                                  cartItem, cartItem['quantity'] + 1);
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            widget.cart.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  );
                },
              ),
            ),

            // Total Amount
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Place Order Button
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print(widget.cart);
                placeFoodOrder(widget.cart, context);
              },
              child: Text('Place Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
