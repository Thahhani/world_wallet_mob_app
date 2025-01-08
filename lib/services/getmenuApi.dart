import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';


  final Dio _dio = Dio();

  // Your API endpoint for the food menu
  

  // Fetching food menu items (GET request)
  Future<List<Map<String, dynamic>>> fetchFoodMenu(restId) async {
    try {
      // Sending GET request to the API endpoint
      final response = await _dio.get('$baseUrl/FoodMenuView/$restId',);  // Replace with your actual endpoint

      if (response.statusCode == 200) {
        print(response.data);
        // If successful, return the list of food items from the response data
        List<dynamic> foodList = response.data;
        return foodList.map((food) => food as Map<String, dynamic>).toList();
      } else {
        return []; // Return empty list if API returns a non-200 response
      }
    } catch (e) {
      print('Error fetching food menu: $e');
      return []; // Return empty list if there's an error
    }
  }

