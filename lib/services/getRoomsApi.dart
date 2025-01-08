// import 'package:dio/dio.dart';
// import 'package:flutterproject1/services/loginApi.dart';


//   final Dio _dio = Dio(); // Create a Dio instance for HTTP requests

//   // Fetch rooms from the backend API
//   Future<List<Map<String, dynamic>>> fetchRooms() async {
//     try {
//       // Replace this URL with your actual API endpoint
//       final response = await _dio.get('$baseUrl/viewroom');
      
//       if (response.statusCode == 200) {
//         // Assuming the response data is a list of rooms
//         List<dynamic> data = response.data;
        
//         // Return the data as List<Map<String, dynamic>>
//         return data.map((roomData) => Map<String, dynamic>.from(roomData)).toList();
//       } else {
//         throw Exception('Failed to load rooms');
//       }
//     } catch (e) {
//       print('Error: $e');
//       rethrow; // Throw error again to be handled by the calling code
//     }
//   }

