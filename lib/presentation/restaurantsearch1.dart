import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/bookFood.dart';
import 'package:worldwalletnew/services/getfoodorderingApi.dart';
import 'package:worldwalletnew/services/getmenuApi.dart';
import 'package:worldwalletnew/services/loginApi.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dio/dio.dart';

// Your API URL

// class Restaurant {
//   final String name;
//   final String imageUrl;
//   final String description;
//   final List<String> menu;
//   final double rating;
//   final String cuisine;
//   final double priceRange;
//   final LatLng location;
//   final List<String> reviews;

//   Restaurant({
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.menu,
//     required this.rating,
//     required this.cuisine,
//     required this.priceRange,
//     required this.location,
//     required this.reviews,
//   });

//   factory Restaurant.fromJson(Map<String, dynamic> json) {
//     return Restaurant(
//       name: json['name'],
//       imageUrl: json['imageUrl'],
//       description: json['description'],
//       menu: List<String>.from(json['menu']),
//       rating: json['rating'].toDouble(),
//       cuisine: json['cuisine'],
//       priceRange: json['priceRange'].toDouble(),
//       location: LatLng(json['latitude'], json['longitude']),
//       reviews: List<String>.from(json['reviews']),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RestaurantSearchPage(),
    );
  }
}

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  List<Map<String, dynamic>> filteredRestaurants = [];
  String selectedCuisine = 'All';
  double minPrice = 0;
  double maxPrice = 50;
  double minRating = 0;
  bool isLoading = true;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      final response = await dio.get('$baseUrl/viewrestaurant');
      print("Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}");

        // Check if the response contains a list (or a map with a list inside)
        if (response.data is List) {
          List<dynamic> data = response.data;
          List<Map<String, dynamic>> restaurants =
              data.map((json) => Map<String, dynamic>.from(json)).toList();
          setState(() {
            filteredRestaurants = restaurants;
            isLoading = false;
          });
          // } else if (response.data is Map) {
          //   Map<String, dynamic> data = response.data;
          //    List<dynamic> restaurantsData = data;
          //     List<Restaurant> restaurants = restaurantsData.map((json) => Restaurant.fromJson(json)).toList();
          //     setState(() {
          //       filteredRestaurants = restaurants;
          //       isLoading = false;
          //     });
          // if (data != null) {

          // } else {
          //   print("API response doesn't contain a 'restaurants' key");
          //   setState(() {
          //     isLoading = false;
          //   });
          // }
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

  // void filterRestaurants() {
  //   setState(() {
  //     filteredRestaurants = filteredRestaurants.where((restaurant) {
  //       return (selectedCuisine == 'All' || restaurant.cuisine == selectedCuisine) &&
  //           restaurant.priceRange >= minPrice &&
  //           restaurant.priceRange <= maxPrice &&
  //           restaurant.rating >= minRating;
  //     }).toList();
  //   });
  // }

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
            // Filter options for restaurants
            // Row(
            //   children: [
            //     Expanded(
            //       child: InputDecorator(
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide: BorderSide(color: Colors.deepOrangeAccent),
            //           ),
            //           filled: true,
            //           fillColor: Colors.white,
            //         ),
            //         child: DropdownButton<String>(
            //           value: selectedCuisine,
            //           isExpanded: true,
            //           items: ['All', 'Japanese', 'Italian', 'Indian', 'Chinese']
            //               .map((String value) {
            //             return DropdownMenuItem<String>(
            //               value: value,
            //               child: Text(value),
            //             );
            //           }).toList(),
            //           onChanged: (newValue) {
            //             setState(() {
            //               selectedCuisine = newValue!;
            //             });
            //             // filterRestaurants();
            //           },
            //           style: TextStyle(color: Colors.deepOrangeAccent),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 16),
            //     Text('Price Range:'),
            // Slider(
            //   min: 0,
            //   max: 50,
            //   value: maxPrice,
            //   activeColor: Colors.deepOrangeAccent,
            //   onChanged: (value) {
            //     setState(() {
            //       maxPrice = value;
            //     });
            //     // filterRestaurants();
            //   },
            // ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Text('Min Rating:'),
            //     RatingBar.builder(
            //       initialRating: minRating,
            //       minRating: 0,
            //       itemCount: 5,
            //       itemSize: 20.0,
            //       itemBuilder: (context, _) => Icon(
            //         Icons.star,
            //         color: Colors.amber,
            //       ),
            //       onRatingUpdate: (rating) {
            //         setState(() {
            //           minRating = rating;
            //         });
            //         // filterRestaurants();
            //       },
            //     ),
            //   ],
            // ),
            SizedBox(height: 16),
            // Loading indicator
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
                            // leading: ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Image.network(
                            //     restaurant.imageUrl,
                            //     width: 100,
                            //     height: 100,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
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
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
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



class RestaurantDetailPage extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  final List<Map<String, dynamic>> menudata;

  RestaurantDetailPage({required this.restaurant, required this.menudata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(restaurant['name']),
      //   backgroundColor: Colors.deepOrangeAccent,
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
               title: Text(restaurant['name'],style: TextStyle(color: Colors.white),),
              expandedHeight: 300.0, // Adjust height as needed
              floating: false,
              pinned: true, // App bar stays visible when scrolled
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
                  restaurant['name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${restaurant['place']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('${restaurant['phoneno']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),

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
                    itemCount: menudata.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(menudata[index]['foodname']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(menudata[index]['foodtype']),
                            Text(menudata[index]['description']),
                            Text('Price: \$${menudata[index]['price']}'),
                          ],
                        ),
                        trailing: ElevatedButton(onPressed: (){
                        placeFoodOrder({
                          'USERID':loginId,
                          'MENUID': menudata[index]['id'],
                          'quantity':1,
                        },context);
                        }, child: Text('Book')),
                      ),
                    ),
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
