class ComplimentModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isRead;

  ComplimentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    this.isRead = false,
  });

  factory ComplimentModel.fromJson(Map<String, dynamic> json) {
    return ComplimentModel(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}
