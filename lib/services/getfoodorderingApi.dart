// import 'package:dio/dio.dart';
// import 'package:flutterproject1/services/loginApi.dart';

//   final Dio _dio = Dio(); // Dio instance for making API requests

//   // Fetch available food items from the backend API
//   Future<List<Map<String, dynamic>>> fetchFoodItems() async {
//     try {
//       // Replace this URL with your actual API endpoint to fetch food items
//       final response = await _dio.get('$baseUrl/hfgvjbn');

//       if (response.statusCode == 200) {
//         // Assuming the response data is a list of food items
//         List<dynamic> data = response.data;
//         return List<Map<String, dynamic>>.from(data); // Convert response data into a list of maps
//       } else {
//         throw Exception('Failed to load food items');
//       }
//     } catch (e) {
//       print('Error: $e');
//       rethrow; // Throw error again to be handled by the calling code
//     }
//   }

//   // Submit a food order (e.g., user places an order)
//   Future<Map<String, dynamic>> placeFoodOrder(Map<String, dynamic> orderData) async {
//     try {
//       // Replace with your actual API endpoint to submit an order
//       final response = await _dio.post('https://your-api-endpoint.com/place-order', data: orderData);

//       if (response.statusCode == 200) {
//         // Assuming the response contains the order confirmation
//         return response.data;
//       } else {
//         throw Exception('Failed to place the order');
//       }
//     } catch (e) {
//       print('Error: $e');
//       rethrow; // Throw error again to be handled by the calling code
//     }
//   }

