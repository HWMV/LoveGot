// 토큰 저장 및 조회 기능
// 로그인/회원가입 시 토큰이 SharedPreferences에 저장
// 토큰 조회, 삭제, 존재 여부 확인 기능이 추가

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/config/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _tokenKey = 'auth_token';

  // 현재 사용자 상태 스트림
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 현재 사용자 가져오기
  User? get currentUser => _auth.currentUser;

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

  // 로그인
  Future<UserCredential> signIn(String email, String password) async {
    try {
      // Firebase 로그인
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 백엔드 로그인
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveToken(data['access_token']);
        return userCredential;
      } else {
        throw Exception('로그인에 실패했습니다: ${response.body}');
      }
    } catch (e) {
      throw Exception('로그인에 실패했습니다: $e');
    }
  }

  // 회원가입
  Future<UserCredential> signUp(String email, String password) async {
    try {
      // Firebase 회원가입
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 백엔드 회원가입
      final response = await http.post(
        Uri.parse('${Env.apiUrl}/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'nickname': userCredential.user?.displayName ?? email.split('@')[0],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveToken(data['access_token']);
        return userCredential;
      } else {
        throw Exception('회원가입에 실패했습니다: ${response.body}');
      }
    } catch (e) {
      throw Exception('회원가입에 실패했습니다: $e');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    await deleteToken();
  }
}
