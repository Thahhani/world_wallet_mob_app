import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:worldwalletnew/services/foodfeedback.dart';
import 'package:worldwalletnew/services/loginApi.dart';

class FoodBookingHistoryScreen extends StatefulWidget {
  final List<dynamic> foodHistory;

  const FoodBookingHistoryScreen({super.key, required this.foodHistory});

  @override
  _FoodBookingHistoryScreenState createState() =>
      _FoodBookingHistoryScreenState();
}

class _FoodBookingHistoryScreenState extends State<FoodBookingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: widget.foodHistory.length,
        itemBuilder: (context, index) {
          final booking = widget.foodHistory[index];
          final orderItems = booking['ORDERID']; // Extracting ORDERID list

          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ID: ${booking['USERID']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Order Status: ${booking['status']}'),
                  Text('Order Date: ${booking['created_at']}'),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderItems.length,
                    itemBuilder: (context, itemIndex) {
                      final item = orderItems[itemIndex];
                      final menu = item['MENUID'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Item: ${menu['foodname']}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Type: ${menu['foodtype']}'),
                          Text('Price: ${menu['price']}'),
                          Text('Quantity: ${item['quantity']}'),
                          Text('Item Status: ${item['status']}'),
                          Divider(),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        TextEditingController feedbackController =
                            TextEditingController();
                        double rating = 0;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Rate Now'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 40.0,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (newRating) {
                                    rating = newRating;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: feedbackController,
                                  decoration: InputDecoration(
                                      label: Text('Enter feedback here'),
                                      border: OutlineInputBorder()),
                                )
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    'USERID': loginId,
                                    'RESTAURANTID': orderItems.first['MENUID']
                                        ['RESTAURANTID'],
                                    'MENUID': orderItems.first['MENUID']['id'],
                                    'rating': rating,
                                    'feedback': feedbackController.text,
                                  };

                                  foodFeedbackApi(data, context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                      label: Text('Rate Now'),
                      icon: Icon(
                        Icons.star,
                        color: Colors.amber,
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
