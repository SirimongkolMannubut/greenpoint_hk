class PointModel {
  final String id;
  final int points;
  final DateTime createdAt;

  PointModel({required this.id, required this.points, required this.createdAt});

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: json['id'],
      points: json['points'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
