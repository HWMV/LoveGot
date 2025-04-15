import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/env.dart';

class RequestService {
  static Future<Map<String, dynamic>> getAISuggestions(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/request_card'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: utf8.encode(json.encode({
          'user_input': userInput,
        })),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return json.decode(decodedResponse);
      } else {
        final errorBody = utf8.decode(response.bodyBytes);
        throw Exception('Failed to get AI suggestions: $errorBody');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
