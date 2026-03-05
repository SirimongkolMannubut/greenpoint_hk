class ProfileModel {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final int points;
  final DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    required this.points,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      phone: json['phone'],
      points: json['points'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
