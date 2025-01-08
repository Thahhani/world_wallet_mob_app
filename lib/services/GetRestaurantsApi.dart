import 'package:dio/dio.dart';

  final Dio _dio = Dio(); // Create Dio instance for HTTP requests

  // Fetch restaurants from the backend API
  Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    try {
      // Replace this URL with your actual API endpoint
      final response = await _dio.get('https://your-api-endpoint.com/restaurants');
      
      if (response.statusCode == 200) {
        // Assuming the response data is a list of restaurants
        List<dynamic> data = response.data;
        
        // Return the data as List<Map<String, dynamic>>
        return data.map((restaurantData) => Map<String, dynamic>.from(restaurantData)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Throw error again to be handled by the calling code
    }
  }

