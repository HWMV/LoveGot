import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/config/env.dart';
import '../../auth/service/auth_service.dart';

class ThreadService {
  static String get baseUrl => Env.apiUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> createThread({
    required String userInput,
  }) async {
    try {
      // JWT 토큰 가져오기
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다. 로그인이 필요합니다.');
      }

      final response = await http.post(
        Uri.parse('${baseUrl}/api/threads'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_input': userInput,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to create thread');
      }
    } catch (e) {
      throw Exception('Error creating thread: $e');
    }
  }

  Future<Map<String, dynamic>> sendMessage({
    required String threadId,
    required String message,
  }) async {
    try {
      // JWT 토큰 가져오기
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다. 로그인이 필요합니다.');
      }

      // 요청 데이터 디버깅
      final requestBody = {
        'thread_id': threadId,
        'user_input': message,
      };

      final response = await http.post(
        Uri.parse('${baseUrl}/agent/counseling'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: utf8.encode(jsonEncode(requestBody)),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse == null ||
            !decodedResponse.containsKey('response')) {
          throw Exception('서버 응답이 올바르지 않습니다.');
        }
        return decodedResponse;
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(errorBody['detail'] ?? '메시지 전송에 실패했습니다.');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('메시지 전송 중 오류가 발생했습니다: $e');
    }
  }
}
