import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';
import 'package:thuongmaidientu/features/video/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.content,
    required super.imageUrls,
    required super.rating,
    required super.likesCount,
    required super.user,
    required super.productId,
    required super.variant,
    required super.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      imageUrls: List<String>.from(
          json['image_urls'].map((item) => item["url"]).toList() ?? []),
      rating: json['rating'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      user: ProfileEntityModel.fromJson(json['user'] ?? ''),
      productId: json['product_id'] ?? '',
      variant: VariantModel.fromJson(json['variant'] ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image_urls': imageUrls,
      'rating': rating,
      'likes_count': likesCount,
      'user': user,
      'product_id': productId,
      'variant': variant,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
    };
  }
}
