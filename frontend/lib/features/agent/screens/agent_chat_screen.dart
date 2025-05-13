import 'package:flutter/material.dart';

class AgentChatScreen extends StatefulWidget {
  final String chatType;
  final String initialMessage;

  const AgentChatScreen({
    Key? key,
    required this.chatType,
    required this.initialMessage,
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

  final TextEditingController _messageController = TextEditingController();
  late List<_ChatMessage> messages;

  @override
  void initState() {
    super.initState();
    // 하드코딩된 대화 시나리오
    messages = [
      _ChatMessage(
        sender: '상황',
        text: '남자친구가 동창회에서 첫사랑에게 뽀뽀를 받는 모습을 봤어',
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
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      // 사용자 메시지 추가
      messages.add(_ChatMessage(
        sender: '나',
        text: _messageController.text.trim(),
      ));

      // 메시지 전송 후 텍스트 필드 초기화
      _messageController.clear();
    });

    // 에이전트 응답 시뮬레이션 (실제 구현에서는 API 호출 등으로 대체)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(_ChatMessage(
          sender: '에이전트',
          text:
              "네, 그렇게 대화를 시작해보세요. 상대방의 반응을 관찰하고 대화를 이어나가는 것이 중요합니다. 상황이 어떻게 진행되는지 알려주세요.",
        ));
      });
    });
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
          // 상단 이미지 영역 (화면 높이의 1/3)
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Stack(
              children: [
                // 배경 이미지
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/dialog_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // 그라데이션 오버레이
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          primaryBeigeColor.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 메시지 목록
          Expanded(
            child: ListView.builder(
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
                            color: isUser || isAgent
                                ? Colors.black87
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 메시지 입력 필드
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      hintStyle: TextStyle(color: brownColor.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: secondaryBeigeColor.withOpacity(0.3),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: brownColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
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
