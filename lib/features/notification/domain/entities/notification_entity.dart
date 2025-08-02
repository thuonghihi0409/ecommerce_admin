import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

import '../../../profile/domain/entities/profile_entity.dart';

class NotificationEntity {
  final String id;
  final String? content;
  final List<String>? imageUrls;
  final int? rating;
  final int? likesCount;
  final ProfileEntity? user;
  final String? productId;
  final Variant? variant;
  final DateTime? createdAt;

  const NotificationEntity({
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
