import 'package:thuongmaidientu/features/order_management.dart/data/models/product_item_model.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';

class SellerOrderItemModel extends SellerOrderItem {
  SellerOrderItemModel(
      {required super.user,
      required super.productItem,
      required super.id,
      required super.address,
      required super.status,
      required super.subtotal,
      required super.total});

  factory SellerOrderItemModel.fromJson(Map<String, dynamic> map) {
    return SellerOrderItemModel(
      total: map['total'],
      subtotal: map['subtotal'],
      status: orderStatusFromString(map['status']),
      address: AddressEntity.fromJson(map['address']),
      id: map['id'],
      user: ProfileEntityModel.fromJson(map['user']),
      productItem: (map['product_orders'] as List)
          .map((item) => ProductItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'subtotal': subtotal,
      'store': (user as ProfileEntityModel).toJson(),
      'status': orderStatusToString(status),
      'address': address?.toJson(),
      'product_item': productItem
          .map((item) => (item as ProductItemModel).toMap())
          .toList(),
    };
  }
}
