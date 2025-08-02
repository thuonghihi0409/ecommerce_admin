import 'package:thuongmaidientu/features/product/domain/entities/store.dart';

class Product {
  final String productId;
  final String? cover;
  final Store? store;
  final String? categoryId;
  final String? productName;
  final String? description;

  final int? price;
  final double? avgRating;
  final int? totalSold;

  Product(
      {required this.productId,
      this.cover,
      this.store,
      this.categoryId,
      this.productName,
      this.description,
      this.price,
      this.avgRating,
      this.totalSold});
}
