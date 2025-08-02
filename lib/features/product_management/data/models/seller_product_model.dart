import 'package:thuongmaidientu/features/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';

class SellerProductModel extends SellerProduct {
  SellerProductModel(
      {required super.productId,
      required super.cover,
      required super.category,
      required super.productName,
      required super.description,
      required super.price,
      required super.avgRating,
      required super.totalSold,
      required super.variants,
      required super.totalRating});

  factory SellerProductModel.fromJson(Map<String, dynamic> json) {
    return SellerProductModel(
      cover: json["cover"],
      totalRating: json['total_rating'],
      avgRating: json['avg_rating'].toDouble(),
      totalSold: json['total_sold'],
      productId: json['id'],
      productName: json['product_name'],
      description: json['description'],
      price: json['price'],
      category: CategoryModel.fromJson(json['category']),
      variants: (json['variants'] as List)
          .map((e) => VariantModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_idd': productId,
      'category': {'category_id': category},
      'product_name': productName,
      'description': description,
      'price': price,
      'total_sold': totalSold,
      'avg_rating': avgRating
    };
  }
}
