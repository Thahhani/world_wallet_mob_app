import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:worldwalletnew/presentation/walletmanage.dart';
import 'package:worldwalletnew/services/getwalletbalance.dart';
import 'package:worldwalletnew/services/loginApi.dart';


  final Dio _dio = Dio();

  // Your API endpoint for the food menu
 

  // Fetching food menu items (GET request)
  Future<void> addtoWlletApi(data,context) async {
    try {
      // Sending GET request to the API endpoint
      final response = await _dio.post('$baseUrl/Addwalletbalance/$loginId/',data: data);  // Replace with your actual endpoint

      if (response.statusCode == 200) {
        // If successful, return the list of food items from the response data
      Navigator.pop(context);
       Navigator.pop(context);
        String walletbalance=      await getWalletbalance ();
                    // Navigate to Wallet Management screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletExpenseScreen(balance: walletbalance,)));
      } else {
       // Return empty list if API returns a non-200 response
      }
    } catch (e) {
      print('Error fetching food menu: $e');
       // Return empty list if there's an error
    }
  }

