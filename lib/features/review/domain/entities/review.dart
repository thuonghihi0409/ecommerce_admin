import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

class Review {
  final String id;
  final String? content;
  final List<String>? imageUrls;
  final int? rating;
  final int? likesCount;
  final ProfileEntity? user;
  final String? productId;
  final Variant? variant;
  final DateTime? createdAt;

  const Review({
    required this.id,
    required this.content,
    required this.imageUrls,
    required this.rating,
    required this.likesCount,
    required this.user,
    required this.productId,
    required this.variant,
    required this.createdAt,
  });
}
