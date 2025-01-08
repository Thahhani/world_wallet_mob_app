import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Booking {
  final String bookingId;
  final String customerName;
  final String roomNumber;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String paymentStatus;
  bool isCancelled;

  Booking({
    required this.bookingId,
    required this.customerName,
    required this.roomNumber,
    required this.checkInDate,
    required this.checkOutDate,
    required this.paymentStatus,
    this.isCancelled = false,
  });
}

// Sample data for bookings
// List<Booking> bookings = [
//   Booking(
//     bookingId: 'B001',
//     customerName: 'John Doe',
//     roomNumber: '101',
//     checkInDate: DateTime(2024, 12, 1),
//     checkOutDate: DateTime(2024, 12, 5),
//     paymentStatus: 'Paid',
//   ),
//   Booking(
//     bookingId: 'B002',
//     customerName: 'Jane Smith',
//     roomNumber: '102',
//     checkInDate: DateTime(2024, 12, 3),
//     checkOutDate: DateTime(2024, 12, 7),
//     paymentStatus: 'Pending',
//   ),
//   Booking(
//     bookingId: 'B003',
//     customerName: 'Alice Johnson',
//     roomNumber: '103',
//     checkInDate: DateTime(2024, 12, 10),
//     checkOutDate: DateTime(2024, 12, 12),
//     paymentStatus: 'Paid',
//   ),
// ];

class BookingHistoryScreen extends StatefulWidget {
  final List<Map<String,dynamic>> bookinghistory;

  const BookingHistoryScreen({super.key, required this.bookinghistory});
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  // Cancel Booking Function
  void cancelBooking(String bookingId) {
    // setState(() {
    //   bookings
    //       .firstWhere((booking) => booking.bookingId == bookingId)
    //       .isCancelled = true;
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
        itemCount: widget.bookinghistory.length,
        itemBuilder: (context, index) {
          // final booking = widget.bookinghistory[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Booking ID: ${widget.bookinghistory['']}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      'Pay Method: ${widget.bookinghistory[index]['paymentmethod']??"paid"}'),
                  Text(
                      'Room Number: ${widget.bookinghistory[index]['ROOMID']}'),
                  Text(
                      'Check-in: ${widget.bookinghistory[index]['checkindate']}'),
                  Text(
                      'Check-out: ${widget.bookinghistory[index]['checkoutdate']}'),
                  Text(
                      ' Status: ${widget.bookinghistory[index]['bookingstatus']}'),
                  // if (!booking.isCancelled)
                  //   ElevatedButton(
                  //     onPressed: () => cancelBooking(booking.bookingId),
                  //     child: Text('Cancel Booking'),
                  //     style:
                  //         ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  //   ),
                  // if (booking.isCancelled)
                  //   Text('Booking Cancelled',
                  //       style: TextStyle(
                  //           color: Colors.red, fontWeight: FontWeight.bold)),
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
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
