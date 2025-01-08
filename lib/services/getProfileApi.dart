import 'package:dio/dio.dart';

  final Dio _dio = Dio(); // Create Dio instance for HTTP requests

  // Fetch user profile data from the backend API
  Future<Map<String, dynamic>> fetchUserProfile(String userId) async {
    try {
      // Replace this URL with your actual API endpoint for fetching profile
      final response = await _dio.get('https://your-api-endpoint.com/users/$userId/profile');
      
      if (response.statusCode == 200) {
        // Assuming the response data is the user's profile details
        return response.data; // Return the profile data
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Throw error again to be handled by the calling code
    }
  }

  // Update user profile data on the backend
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> profileData) async {
    try {
      // Replace this URL with your actual API endpoint for updating profile
      final response = await _dio.put(
        'https://your-api-endpoint.com/users/$userId/profile',
        data: profileData,
      );
      
      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      print('Error: $e');
      return false; // Failed to update
    }
  }

