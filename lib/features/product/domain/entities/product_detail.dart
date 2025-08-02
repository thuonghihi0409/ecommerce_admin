import 'package:thuongmaidientu/features/product/domain/entities/store.dart';

class ProductDetail {
  final String productId;
  final String? productName;
  final String? description;
  final int? price;
  final Store? store;
  final String? categoryId;
  final List<ImageItem>? images;
  final List<Variant>? variants;
  final double? avgRating;
  final int? totalSold;
  final int? totalRating;
  final String? cover;

  ProductDetail(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.price,
      required this.store,
      required this.categoryId,
      required this.images,
      required this.variants,
      required this.avgRating,
      required this.totalRating,
      required this.totalSold,
      required this.cover});
}

class ImageItem {
  final String id;
  final String? url;
  final String? alt;

  ImageItem({
    required this.id,
    required this.url,
    required this.alt,
  });
}

class Variant {
  final String id;
  final String? cover;
  final String? name;
  final int? price;
  final int? stock;
  final int? totalSold;

  Variant(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock,
      required this.cover,
      required this.totalSold});
}
