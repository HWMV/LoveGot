import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/env.dart';
import '../../../models/compliment_model.dart';

class ComplimentService {
  static Future<void> sendCompliment(String content) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/compliment'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: utf8.encode(json.encode({
          'content': content,
        })),
      );

      if (response.statusCode != 200) {
        final errorBody = utf8.decode(response.bodyBytes);
        throw Exception('Failed to send compliment: $errorBody');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<ComplimentModel>> getCompliments() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.apiUrl}/compliments'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonList = json.decode(decodedResponse);
        return jsonList.map((json) => ComplimentModel.fromJson(json)).toList();
      } else {
        final errorBody = utf8.decode(response.bodyBytes);
        throw Exception('Failed to get compliments: $errorBody');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
