import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

class ProductDetailModel extends ProductDetail {
  ProductDetailModel(
      {required super.productId,
      required super.productName,
      required super.description,
      required super.price,
      required super.store,
      required super.categoryId,
      required super.images,
      required super.variants,
      required super.avgRating,
      required super.totalRating,
      required super.totalSold,
      required super.cover});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      cover: json["cover"],
      totalRating: json['total_rating'],
      avgRating: json['avg_rating'].toDouble(),
      totalSold: json['total_sold'],
      productId: json['id'],
      productName: json['product_name'],
      description: json['description'],
      price: json['price'],
      store: StoreModel.fromJson(json['store']),
      categoryId: json['category_id'],
      images:
          (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      variants: (json['variants'] as List)
          .map((e) => VariantModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'product_name': productName,
      'description': description,
      'price': price,
      'store_id': store?.id,
      'category_id': categoryId,
      'total_rating': totalRating,
      'total_sold': totalSold,
      'avg_rating': avgRating
    };
  }
}

class ImageModel extends ImageItem {
  ImageModel({
    required super.id,
    required super.url,
    required super.alt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'alt': alt,
    };
  }
}

class VariantModel extends Variant {
  VariantModel(
      {required super.id,
      required super.name,
      required super.price,
      required super.stock,
      required super.cover,
      required super.totalSold});

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        stock: json['stock'] ?? 0,
        cover: json['cover'] ?? "",
        totalSold: json['total_sold']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}
