import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

  final Dio _dio = Dio();

  // Your API endpoint
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  // POST request method
  Future<Map<String, dynamic>> paymentApi(Map<String, dynamic> data) async {
    try {
      // Sending a POST request with data
      final response = await _dio.post(
        '$_baseUrl/posts', // Endpoint for the POST request
        data: data, // Data to be sent in the body
      );

      if (response.statusCode == 201) {
        // If successful, return the response data
        return response.data;
      } else {
        return {'error': 'Failed to create data'};
      }
    } catch (e) {
      print('Error posting data: $e');
      return {'error': e.toString()};
    }
  }


