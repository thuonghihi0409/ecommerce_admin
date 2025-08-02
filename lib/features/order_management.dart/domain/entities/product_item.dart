import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

class ProductItem {
  final String id;
  final ProductDetail? productDetail;
  final Variant? variant;
  final int number;

  ProductItem(
      {required this.id,
      required this.productDetail,
      required this.variant,
      required this.number});
  ProductItem copyWith({
    String? id,
    ProductDetail? productDetail,
    Variant? variant,
    int? number,
  }) {
    return ProductItem(
      id: id ?? this.id,
      productDetail: productDetail ?? this.productDetail,
      variant: variant ?? this.variant,
      number: number ?? this.number,
    );
  }
}
