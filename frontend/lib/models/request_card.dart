class RequestCard {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status; // pending, accepted, completed

  RequestCard({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory RequestCard.fromJson(Map<String, dynamic> json) {
    return RequestCard(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'],
    );
  }
}
