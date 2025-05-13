enum MessageType {
  situation, // 상황 설명
  user, // 사용자 메시지
  agent, // AI 에이전트 메시지
}

class ChatMessage {
  final String sender;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.type,
    DateTime? timestamp, //메세지 순서 관리
  }) : timestamp = timestamp ?? DateTime.now();

  factory ChatMessage.situation(String text) {
    return ChatMessage(
      sender: '상황',
      text: text,
      type: MessageType.situation,
    );
  }

  factory ChatMessage.user(String text) {
    return ChatMessage(
      sender: '나',
      text: text,
      type: MessageType.user,
    );
  }

  factory ChatMessage.agent(String text) {
    return ChatMessage(
      sender: '에이전트',
      text: text,
      type: MessageType.agent,
    );
  }
}
