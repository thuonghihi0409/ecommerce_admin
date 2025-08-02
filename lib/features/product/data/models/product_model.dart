import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.productId,
      required super.cover,
      required super.store,
      required super.categoryId,
      required super.productName,
      required super.description,
      required super.price,
      required super.avgRating,
      required super.totalSold});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['id'],
        cover: json['cover'],
        store: StoreModel.fromJson(json['store']), // Nested store object
        categoryId: json['category_id'],
        productName: json['product_name'],
        description: json['description'],
        price: json['price'],
        avgRating: json['avg_rating'].toDouble(),
        totalSold: json['total_sold']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_idd': productId,
      'store': {'store_id': store?.id},
      'category': {'category_id': categoryId},
      'product_name': productName,
      'description': description,
      'price': price,
      'total_sold': totalSold,
      'avg_rating': avgRating
    };
  }
}
