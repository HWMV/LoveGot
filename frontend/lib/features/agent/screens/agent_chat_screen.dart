import 'package:flutter/material.dart';

class AgentChatScreen extends StatelessWidget {
  const AgentChatScreen({Key? key}) : super(key: key);

  // 앱 전체에서 사용할 베이지 계열 색상 정의
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트 색상)
  static const Color lightWarmBeigeColor =
      Color(0xFFF7E6D5); // 따뜻한 연한 베이지 (사용자 메시지)
  static const Color lightCoolBeigeColor = Color(0xFFECE8E1); // 차가운 연한 베이지

  @override
  Widget build(BuildContext context) {
    // 하드코딩된 대화 시나리오
    final List<_ChatMessage> messages = [
      _ChatMessage(
        sender: '상황',
        text: '남자친구가 동창회에서 첫사랑과 뽀뽀를 하는 장면을 내가 목격함.',
        isSituation: true,
      ),
      _ChatMessage(
        sender: '나',
        text:
            '남자친구는 의도하지 않은 상황이라 하는데 어떻게 이 사실을 믿지? 어떻게 나를 두고 이런 행동을 할 수가 있는지 모르겠어',
        isSituation: false,
      ),
      _ChatMessage(
        sender: '에이전트',
        text:
            "정말 당황스럽고 속상하셨겠어요. 이런 상황에서는 상대방의 입장도 들어보는 것이 중요하지만, 자신의 감정을 솔직하게 전달하는 것도 필요해요. 예를 들어, '나는 네가 그런 행동을 했다는 사실에 많이 놀랐고, 상처를 받았어. 네 입장을 듣고 싶어.'처럼 '나 전달법'으로 대화를 시작해보는 건 어떨까요?",
        isSituation: false,
      ),
      _ChatMessage(
        sender: '나',
        text: '그래.. 한번 이렇게 말해볼게',
        isSituation: false,
      ),
    ];

    return Scaffold(
      backgroundColor: primaryBeigeColor,
      appBar: AppBar(
        title: const Text('갈등 에이전트와의 대화'),
        centerTitle: true,
        backgroundColor: secondaryBeigeColor,
        foregroundColor: brownColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, idx) {
          final msg = messages[idx];
          if (msg.isSituation) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: accentBeigeColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentBeigeColor),
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          final isUser = msg.sender == '나';
          final isAgent = msg.sender == '에이전트';
          return Align(
            alignment: isUser
                ? Alignment.centerRight
                : isAgent
                    ? Alignment.centerLeft
                    : Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser
                    ? lightWarmBeigeColor
                    : isAgent
                        ? secondaryBeigeColor
                        : accentBeigeColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isUser
                      ? accentBeigeColor
                      : isAgent
                          ? brownColor.withOpacity(0.5)
                          : accentBeigeColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.sender,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isUser
                          ? brownColor
                          : isAgent
                              ? brownColor
                              : brownColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.text,
                    style: TextStyle(
                      color:
                          isUser || isAgent ? Colors.black87 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChatMessage {
  final String sender;
  final String text;
  final bool isSituation;
  _ChatMessage(
      {required this.sender, required this.text, this.isSituation = false});
}
