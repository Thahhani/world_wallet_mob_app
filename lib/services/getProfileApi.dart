import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/loginApi.dart';

  final Dio _dio = Dio(); // Create Dio instance for HTTP requests

  // Fetch user profile data from the backend API

   Map<String, dynamic>profiledata={};
   
  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      // Replace this URL with your actual API endpoint for fetching profile
      final response = await _dio.get('$baseUrl/view-profile/$loginId/');
      print(response.data);
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
  Future<bool> updateUserProfile( Map<String, dynamic> profileData,context) async {
    try {
      // Replace this URL with your actual API endpoint for updating profile
      final response = await _dio.put(
        '$baseUrl/view-profile/$loginId/',
        data: profileData,
      );
      
      if (response.statusCode == 200) {
        profileData=await fetchUserProfile();
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profile Updated'),
    ));
        return true; // Successfully updated
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      print('Error: $e');
      return false; // Failed to update
    }
  }



  // update

  

