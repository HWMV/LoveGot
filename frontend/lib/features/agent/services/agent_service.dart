import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/env.dart';

enum AgentType {
  worry, // 고민상담
  conflict, // 갈등상담
}

class AgentService {
  static String get baseUrl => Env.apiUrl;

  // 에이전트 타입에 따른 엔드포인트 매핑
  static final Map<AgentType, String> _endpoints = {
    AgentType.worry: '/api/agents/worry',
    AgentType.conflict: '/api/agents/conflict',
  };

  // 초기 메시지 전송 및 상황 정리 요청
  Future<Map<String, dynamic>> initializeChat({
    required AgentType agentType, //에이전트 타입 구분
    required String initialMessage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${_endpoints[agentType]}/initialize'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': initialMessage,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to initialize chat');
      }
    } catch (e) {
      throw Exception('Error initializing chat: $e');
    }
  }

  // 메시지 전송 및 응답 요청
  Future<Map<String, dynamic>> sendMessage({
    required AgentType agentType,
    required String message,
    required String sessionId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${_endpoints[agentType]}/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'sessionId': sessionId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }
}
