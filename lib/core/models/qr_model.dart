class QRModel {
  final String id;
  final String code;
  final DateTime expiresAt;

  QRModel({required this.id, required this.code, required this.expiresAt});

  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      id: json['id'],
      code: json['code'],
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }
}
