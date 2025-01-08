import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';

  final Dio _dio = Dio(); // Create Dio instance for HTTP requests

  // Fetch booking history data from the backend API
  Future<List<Map<String, dynamic>>> fetchroomBookingHistory() async {
    try {
      // Replace this URL with your actual API endpoint for fetching booking history
      final response = await _dio.get('$baseUrl/RoomBookingHistory/$loginId');
      
      if (response.statusCode == 200) {
        print(response.data);
        // Assuming the response data is a list of bookings
        List<dynamic> data = response.data;
        return List<Map<String, dynamic>>.from(data); // Convert response data into a list of maps
      } else {
        throw Exception('Failed to load booking history');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Throw error again to be handled by the calling code
    }
  }

