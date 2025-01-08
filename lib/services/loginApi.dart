import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldwalletnew/presentation/homepage.dart';


String? baseUrl = 'http://192.168.1.150:5000'; // Django API URL
int? loginId;

Future<void> loginFunction(String username, String password, context) async {
  final Dio dio = Dio(); // Dio instance

  try {
    // Send the login request with email and password as JSON
    final response = await dio.post(
      '$baseUrl/LoginPage',
      data: {
        'Username': username,
        'Password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json', // Ensure proper content type
        },
      ),
    );
print(response.data);
    // Handle the response
    if (response.statusCode == 200) {
      if (response.data['message'] == 'success') {
        loginId = response.data['login_id'];
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (gy) => Homepage(username: username,)));
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login success")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(" Error")));
      // If login failed, display the error message
      print('Error: ${response.data['error']}');
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Exception error")));
    // Handle any error that occurs during the request
    print('Error occurred: $e');
  }
}
