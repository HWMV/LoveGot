import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String baseUrl = 'http://localhost:8080';

  // 로그인
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // 토큰 저장
      await saveToken(data['access_token']);
      return data;
    } else {
      throw Exception('로그인에 실패했습니다: ${response.body}');
    }
  }

  // 토큰 저장
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // 토큰 조회
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // 토큰 삭제 (로그아웃 시)
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // 토큰 존재 여부 확인
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }

  // API 요청을 위한 헤더 생성
  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('인증 토큰이 없습니다. 로그인이 필요합니다.');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
