import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/loginApi.dart';

  final Dio _dio = Dio(); // Dio instance for making API requests



  // Submit a food order (e.g., user places an order)
  Future<void> placeFoodOrder(Map<String, dynamic> orderData,context) async {
    print('object');
    try {
      // Replace with your actual API endpoint to submit an order
      final response = await _dio.post('$baseUrl/place_food_order/', data: orderData);
print(response.data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking success')));
        Navigator.pop(context);
         Navigator.pop(context);

        // Assuming the response contains the order confirmation
        return response.data;
      } else {
        throw Exception('Failed to place the order');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Throw error again to be handled by the calling code
    }
  }

