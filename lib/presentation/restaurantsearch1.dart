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
  List<Map<String, dynamic>> allRestaurants = [];  // Store all restaurants
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
            filteredRestaurants = restaurants;  // Initially show all restaurants
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
        return restaurant['name']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            restaurant['place']
                .toLowerCase()
                .contains(query.toLowerCase());
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
                filterRestaurants(value); // Trigger the filter when user changes text
              },
              decoration: InputDecoration(
                labelText: 'Search by name or place',
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
