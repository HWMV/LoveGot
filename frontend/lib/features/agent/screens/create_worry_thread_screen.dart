import 'package:flutter/material.dart';
import 'agent_chat_screen.dart';

class CreateWorryThreadScreen extends StatefulWidget {
  const CreateWorryThreadScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorryThreadScreen> createState() =>
      _CreateWorryThreadScreenState();
}

class _CreateWorryThreadScreenState extends State<CreateWorryThreadScreen> {
  final TextEditingController _controller = TextEditingController();

  // 앱 전체에서 사용할 베이지 계열 색상 정의
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트 색상)
  static const Color lightWarmBeigeColor =
      Color(0xFFF7E6D5); // 따뜻한 연한 베이지 (고민상담)

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStartChat() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgentChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBeigeColor,
      appBar: AppBar(
        title: const Text('고민상담 AI'),
        centerTitle: true,
        backgroundColor: secondaryBeigeColor,
        elevation: 0,
        foregroundColor: brownColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              minLines: 5,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: '고민 상황을 상세히 적어주세요!',
                hintStyle: TextStyle(color: brownColor.withOpacity(0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: accentBeigeColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: accentBeigeColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: brownColor, width: 2),
                ),
                filled: true,
                fillColor: lightWarmBeigeColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _onStartChat,
              style: ElevatedButton.styleFrom(
                backgroundColor: brownColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('채팅 시작',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
