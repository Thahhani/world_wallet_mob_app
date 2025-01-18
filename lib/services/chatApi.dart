import 'package:dio/dio.dart';
import 'package:worldwalletnew/services/loginApi.dart';

// Dio instance
final Dio _dio = Dio();

// API base URL for the chatbot


// Function to send a message to the chatbot API and receive the response
Future<String> sendMessageToChatBot(String userMessage) async {
  try {
    // Prepare the request data
    final data = {
      'message': userMessage,  // Sending the user message to the bot
    };

    // Sending the POST request to the API
    final response = await _dio.post('$baseUrl/generate-itinerary/', data: data);
print(response.data);
    if (response.statusCode == 200) {
      // If successful, return the bot's response
      return response.data['chatbot_response'] ;
    } else {
      return '';
    }
  } catch (e) {
    print('Error sending message to bot: $e');
    return '';
  }
}



