import 'package:thuongmaidientu/features/user_management/data/models/user_model.dart';
import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';

class StoreEntity {
  final String id;
  final String? name;
  final String? logoUrl;
  final String? backgroundUrl;
  final UserEntity user;
  final String? address;
  final double? averageRating;
  final int? totalProducts;
  final String? phone;
  final String? status;

  const StoreEntity(
      {required this.id,
      required this.name,
      required this.logoUrl,
      required this.address,
      required this.averageRating,
      required this.totalProducts,
      required this.backgroundUrl,
      required this.phone,
      required this.user,
      required this.status});

  factory StoreEntity.fromJson(Map<String, dynamic> json) {
    return StoreEntity(
      phone: json["phone"],
      id: json['id'] as String,
      name: json['name'] as String?,
      logoUrl: json['logo_url'] as String?,
      backgroundUrl: json['background_url'] as String?,
      address: json['address'] as String?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      totalProducts: json['total_products'] as int?,
      user: UserEntityModel.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String?,
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
