import 'package:thuongmaidientu/features/order_management.dart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';

class ProductItemModel extends ProductItem {
  ProductItemModel({
    required super.id,
    required super.productDetail,
    required super.variant,
    required super.number,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'],
      productDetail: ProductDetailModel.fromJson(map['product']),
      variant: VariantModel.fromJson(map['variant']),
      number: map['number'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_detail': (productDetail as ProductDetailModel).toJson(),
      'variant': (variant as VariantModel).toJson(),
      'number': number,
      'id': id
    };
  }
}
