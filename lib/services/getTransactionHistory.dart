import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';

final Dio _dio = Dio();

// Method to get transaction history
Future<List<Map<String, dynamic>>> getTransactionHistory() async {
  try {
    // Replace this URL with your actual endpoint
    String url = '$baseUrl/TransactionHistory/$loginId';

    // Make the GET request to fetch transaction history
    Response response = await _dio.get(url);

    // Print the response data for debugging
    print(response.data);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Assuming the response data is a list of transactions
      List<dynamic> data = response.data;
      
      // Convert the response data to a list of maps
      return data.map((transaction) => Map<String, dynamic>.from(transaction)).toList();
    } else {
      throw Exception('Failed to fetch transaction history');
    }
  } on DioError catch (e) {
    // Handle DioError if there is an issue with the request
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
