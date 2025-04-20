import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/config/env.dart';
// import '../model/user_model.dart'; 나중에 사용하게 될 때 활성화 시켜서 테스트

class AuthService {
  // 현재 사용자 상태 스트림
  Stream<Map<String, dynamic>?> get authStateChanges => Stream.empty();

  // 로그인
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true, // 토큰 반환 여부로, true 포함되어 있는지 확인
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('로그인에 실패했습니다: ${response.body}');
      }
    } catch (e) {
      throw Exception('로그인 중 오류가 발생했습니다: $e');
    }
  }

  // 회원가입
  Future<Map<String, dynamic>> signUp(
      String nickname, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'nickname': nickname,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('회원가입에 실패했습니다: ${response.body}');
      }
    } catch (e) {
      throw Exception('회원가입 중 오류가 발생했습니다: $e');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    // 백엔드에서 로그아웃 처리가 필요한 경우 여기에 구현
  }
}
