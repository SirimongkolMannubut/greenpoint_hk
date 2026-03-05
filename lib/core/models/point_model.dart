class PointModel {
  final String id;
  final String userId;
  final int points;
  final String type;
  final String? description;
  final DateTime createdAt;

  PointModel({
    required this.id,
    required this.userId,
    required this.points,
    required this.type,
    this.description,
    required this.createdAt,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: json['id'],
      userId: json['user_id'],
      points: json['points'],
      type: json['type'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
