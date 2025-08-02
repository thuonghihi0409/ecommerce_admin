class Store {
  final String id;
  final String? name;
  final String? logoUrl;
  final String? backgroundUrl;
  final String? address;
  final double? averageRating;
  final int? totalProducts;
  final String? phone;

  const Store({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.address,
    required this.averageRating,
    required this.totalProducts,
    required this.backgroundUrl,
    required this.phone,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      phone: json["phone"],
      id: json['id'] as String,
      name: json['name'] as String?,
      logoUrl: json['logo_url'] as String?,
      backgroundUrl: json['background_url'] as String?,
      address: json['address'] as String?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      totalProducts: json['total_products'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'background_url': backgroundUrl,
      'address': address,
      'average_rating': averageRating,
      'total_products': totalProducts,
    };
  }
}
