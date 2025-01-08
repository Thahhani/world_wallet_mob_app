import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';

  final Dio _dio = Dio(); // Dio instance for making API requests

  // Fetch available food items from the backend API
  Future<String> getWalletbalance() async {
    try {
      // Replace this URL with your actual API endpoint to fetch food items
      final response = await _dio.get('$baseUrl/ViewWalletBalance/$loginId/');

      if (response.statusCode == 200) {
        // Assuming the response data is a list of food items
        print(response.data);
       return response.data['Balance'].toString();
      } else {
        throw Exception('Failed to load food items');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Throw error again to be handled by the calling code
    }
  }



