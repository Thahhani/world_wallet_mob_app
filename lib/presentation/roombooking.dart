import 'package:flutter/material.dart';
import 'package:worldwalletnew/presentation/paymentintws.dart';
import 'package:worldwalletnew/presentation/roomsearch1.dart';
import 'package:worldwalletnew/services/loginApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For encoding the data to JSON
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final Room room; // Room object passed to the screen

  BookingScreen({required this.room});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;

  // Function to handle the check-in date selection
  Future<void> selectCheckInDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // 1 year ahead
    );

    if (selectedDate != null && selectedDate != checkInDate) {
      setState(() {
        checkInDate = selectedDate;
      });
    }
  }

  // Function to handle the check-out date selection
  Future<void> selectCheckOutDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)), // Start from tomorrow
      firstDate: checkInDate ?? DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // 1 year ahead
    );

    if (selectedDate != null && selectedDate != checkOutDate) {
      setState(() {
        checkOutDate = selectedDate;
      });
    }
  }

  // Function to validate if check-out is after check-in
  bool isBookingValid() {
    if (checkInDate == null || checkOutDate == null) {
      return false;
    }
    return checkOutDate!.isAfter(checkInDate!);
  }

  // Format date to "yyyy-MM-dd"
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Function to send booking data to the backend API
  Future<void> saveBookingToBackend() async {
    if (checkInDate == null || checkOutDate == null) {
      return;
    }

    // Convert dates to the format 'yyyy-MM-dd'
    String checkInDateFormatted = DateFormat('yyyy-MM-dd').format(checkInDate!);
    String checkOutDateFormatted = DateFormat('yyyy-MM-dd').format(checkOutDate!);

    // API endpoint to save booking data
    final String url = "$baseUrl/roombooking"; // Replace with your actual backend URL

    // Ensure that roomId and other necessary fields are of type String
    final Map<String, dynamic> bookingData = {
      "USERID": loginId, // Send the user ID (loginId as string)
      "ROOMID": widget.room.id.toString(), // Convert roomId to String if it's an int
      "checkindate": checkInDateFormatted, // Send only the date as a string
      "checkoutdate": checkOutDateFormatted, // Send only the date as a string
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bookingData), // Encode data to JSON
      );

      // Print response status and body for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the server returns a 200 response, navigate to payment process
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentProcess(
              price: widget.room.price, // This is where you pass the price
            ),
          ),
        );
      } else {
        // Handle failure (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Booking failed. Please try again. ${response.body}"),
        ));
      }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $error. Please try again later."),
      ));
      print("Error occurred: $error"); // Print error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Room: ${widget.room.name}"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Name
            Text(
              widget.room.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Check-in Date Selector
            InkWell(
              onTap: () => selectCheckInDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Check-in Date",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  formatDate(checkInDate),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Check-out Date Selector
            InkWell(
              onTap: () => selectCheckOutDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Check-out Date",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  formatDate(checkOutDate),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Booking Button
            ElevatedButton(
              onPressed: isBookingValid()
                  ? () {
                      saveBookingToBackend(); // Save booking data to the backend
                    }
                  : null,
              child: Text("Proceed to Booking"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isBookingValid() ? Colors.deepPurple : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
