import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';

final Dio _dio = Dio();

// Define the method to track the order
Future<List<Map<String, dynamic>>> getOrderHistory() async {
  try {
    // Replace the URL with your actual API endpoint
    String url = '$baseUrl/food_order_history/$loginId/';

    // Make the GET request
    Response response = await _dio.get(url);

    // If successful, check the response status and return the data
    if (response.statusCode == 200) {
      print(response.data);
      // Assuming the response is a JSON array, return it as a list of maps
      List<Map<String, dynamic>> orderHistory = List<Map<String, dynamic>>.from(response.data);
      return orderHistory;
    } else {
      throw Exception('Failed to track order');
    }
  } on DioError catch (e) {
    // Handle DioError
    if (e.response != null) {
      // Server responded with an error
      print('Error: ${e.response?.data}');
    } else {
      // No response from the server
      print('Error: ${e.message}');
    }
    rethrow; // Propagate the error to be handled by the calling method
  }
}
