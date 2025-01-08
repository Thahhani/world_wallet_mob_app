import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Sample data for bookings
class FoodBookingHistoryScreen extends StatefulWidget {
  final List<dynamic> foodHistory;
  
  const FoodBookingHistoryScreen({super.key, required this.foodHistory});

  @override
  _FoodBookingHistoryScreenState createState() =>
      _FoodBookingHistoryScreenState();
}

class _FoodBookingHistoryScreenState extends State<FoodBookingHistoryScreen> {
  // Cancel Booking Function
  void cancelBooking(String bookingId) {
    // In real-world application, here you can cancel the booking through an API call
    // setState(() {
    //   bookings.firstWhere((booking) => booking.bookingId == bookingId).isCancelled = true;
    // });

    // Cancellation Confirmation
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Booking Cancelled'),
          content: Text('Your booking has been cancelled successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item: ${widget.foodHistory[index]['ORDERID']['MENUID']['foodname']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Type: ${widget.foodHistory[index]['ORDERID']['MENUID']['foodtype']}',
                  ),
                  Text(
                    'Price: ${widget.foodHistory[index]['ORDERID']['MENUID']['price']}',
                  ),
                  Text(
                    'Quantity: ${widget.foodHistory[index]['ORDERID']['quantity']}',
                  ),
                  Text(
                    'Status: ${widget.foodHistory[index]['status']}',
                  ),
                  Text(
                    'Date: ${widget.foodHistory[index]['created_at']}',
                  ),
                  // Check if booking is cancelled or not, based on some condition
                  // You should ensure your data model includes isCancelled or equivalent flag
                  if (booking['isCancelled'] == false)
                    ElevatedButton(
                      onPressed: () =>
                          cancelBooking(booking['bookingId']), // Adjust based on your data
                      child: Text('Cancel Booking'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  if (booking['isCancelled'] == true)
                    Text(
                      'Booking Cancelled',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Rate Now'),
                            content: RatingBar.builder(
                              initialRating: 3.0, // Default rating
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 40.0,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print('Rated: $rating');
                                // You can save the rating via an API or update the state here
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
