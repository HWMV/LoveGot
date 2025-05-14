import 'package:flutter/material.dart';
import '../services/thread_service.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String sender;
  final bool isSituation;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.sender = '',
    this.isSituation = false,
  });
}

class AgentChatScreen extends StatefulWidget {
  final String chatType;
  final String initialMessage;
  final String threadId;
  final String initialResponse;

  const AgentChatScreen({
    Key? key,
    required this.chatType,
    required this.initialMessage,
    required this.threadId,
    required this.initialResponse,
  }) : super(key: key);

  @override
  State<AgentChatScreen> createState() => _AgentChatScreenState();
}

class _AgentChatScreenState extends State<AgentChatScreen> {
  // 앱 전체에서 사용할 베이지 계열 색상 정의
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트, 텍스트 색상)
  static const Color lightWarmBeigeColor =
      Color(0xFFF7E6D5); // 따뜻한 연한 베이지 (사용자 메시지)
  static const Color lightCoolBeigeColor = Color(0xFFECE8E1); // 차가운 연한 베이지

  final TextEditingController _controller = TextEditingController();
  final ThreadService _threadService = ThreadService();
  bool _isLoading = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = [
      ChatMessage(
        text: widget.initialMessage,
        isUser: true,
        sender: '나',
      ),
      ChatMessage(
        text: widget.initialResponse,
        isUser: false,
        sender: 'GotAI',
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, sender: '나'));
      _controller.clear();
      _isLoading = true;
    });

    try {
      final response = await _threadService.sendMessage(
        threadId: widget.threadId,
        message: text,
      );

      setState(() {
        _messages.add(ChatMessage(
            text: response['response'], isUser: false, sender: '에이전트'));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오류가 발생했습니다: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBeigeColor,
      appBar: AppBar(
        title: Text(widget.chatType),
        centerTitle: true,
        backgroundColor: secondaryBeigeColor,
        elevation: 0,
        foregroundColor: brownColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? lightWarmBeigeColor
                          : lightCoolBeigeColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: TextStyle(
                            color: brownColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.text,
                          style: TextStyle(color: brownColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      hintStyle: TextStyle(color: brownColor.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: accentBeigeColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: accentBeigeColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: brownColor, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(Icons.send, color: brownColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
