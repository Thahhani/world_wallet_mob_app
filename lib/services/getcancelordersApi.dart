import 'package:dio/dio.dart';


  final Dio _dio = Dio();

  // Method to cancel an order
  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    try {
      // Replace this URL with your actual cancel order API endpoint
      String url = 'https://your-api-url.com/cancel-order/$orderId';

      // Make the DELETE request to cancel the order
      Response response = await _dio.delete(url);

      // If successful, return the response data
      if (response.statusCode == 200) {
        return response.data; // Assuming the response is JSON with a success message
      } else {
        throw Exception('Failed to cancel the order');
      }
    } on DioError catch (e) {
      // Handle DioError if there is any issue with the request
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

