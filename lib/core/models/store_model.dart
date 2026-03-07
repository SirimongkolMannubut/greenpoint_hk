class StoreModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double distance;
  final double rating;
  final bool isPartner;
  final bool noPlastic;
  final bool ecoFriendly;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  StoreModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    this.isPartner = true,
    this.noPlastic = false,
    this.ecoFriendly = false,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      imageUrl: json['image_url'],
      distance: json['distance']?.toDouble() ?? 0.0,
      rating: json['rating']?.toDouble() ?? 0.0,
      isPartner: json['is_partner'] ?? true,
      noPlastic: json['no_plastic'] ?? false,
      ecoFriendly: json['eco_friendly'] ?? false,
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }
}
