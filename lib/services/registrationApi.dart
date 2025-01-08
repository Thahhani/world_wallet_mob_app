import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldwalletnew/presentation/login.dart';
import 'package:worldwalletnew/services/loginApi.dart';

Future<void> registerFun(String username, data, context) async {
  final Dio dio = Dio(); // Dio instance

  try {
 
    final response = await dio.post('$baseUrl/UserReg',
        data: data,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', 
          },
        ));

    
    if (response.statusCode == 201) {
      
      print('Registration successful');

    
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login1()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login failed")));
      // If registration failed, display the error message
      print('Error: ${response.data['error']}');
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("exception error")));
    // Handle any error that occurs during the request
    print('Error occurred: $e');
  }
}
