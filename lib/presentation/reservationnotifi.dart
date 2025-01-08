import 'package:flutter/material.dart';

class ReservationConfirmationScreen extends StatelessWidget {
  final String roomName;
  final double price;
  final String checkInDate;
  final String checkOutDate;
  final String reservationId;

  // Constructor to receive reservation details
  ReservationConfirmationScreen({
    required this.roomName,
    required this.price,
    required this.checkInDate,
    required this.checkOutDate,
    required this.reservationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservation Confirmation"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success message
            Text(
              "Reservation Confirmed!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Reservation Details
            Text(
              "Room Name: $roomName",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Price: \$${price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Check-In: $checkInDate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Check-Out: $checkOutDate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),

            // Reservation ID
            Text(
              "Reservation ID: $reservationId",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the home screen or wherever necessary
                    Navigator.pop(context); // Goes back to the previous screen
                  },
                  child: Text("Back to Home"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to reservation details screen (optional)
                    // Example: Navigator.push(...);
                  },
                  child: Text("View Reservation Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

