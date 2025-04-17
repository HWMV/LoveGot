import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  // static const String baseUrl = 'http://localhost:8000'; // 로컬 URL
  static const String baseUrl =
      'https://lovegot-844249836889.us-central1.run.app';
  //     ''; // 실제 백엔드 URL

  static Future<Map<String, dynamic>> getAISuggestions(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/request_card'),
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
