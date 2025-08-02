import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/revenue_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_entity.dart';

class StatisticEntity extends Equatable {
  final int? totalOrders;
  final int? totalProducts;
  final int? totalUsers;
  final int? totalStores;
  final TransactionEntity? transactions;
  final List<TopProductEntity>? topOrderedProducts;
  final List<TopProductEntity>? topAvgRatingProducts;
  final List<RevenueEntity>? revenue;

  const StatisticEntity(
      {required this.totalOrders,
      required this.totalProducts,
      required this.transactions,
      required this.topOrderedProducts,
      required this.revenue,
      required this.totalUsers,
      required this.totalStores,
      required this.topAvgRatingProducts});

  StatisticEntity copyWith({
    int? totalOrders,
    int? totalProducts,
    TransactionEntity? transactions,
    List<TopProductEntity>? topOrderedProducts,
    List<TopProductEntity>? topAvgRatingProducts,
    List<RevenueEntity>? revenue,
    int? totalUsers,
    int? totalStores,
  }) =>
      StatisticEntity(
          totalOrders: totalOrders ?? this.totalOrders,
          totalProducts: totalProducts ?? this.totalProducts,
          transactions: transactions ?? this.transactions,
          topOrderedProducts: topOrderedProducts ?? this.topOrderedProducts,
          revenue: revenue ?? this.revenue,
          totalStores: totalStores ?? this.totalStores,
          totalUsers: totalUsers ?? this.totalUsers,
          topAvgRatingProducts:
              topOrderedProducts ?? this.topAvgRatingProducts);

  factory StatisticEntity.fromJson(Map<String, dynamic> json) =>
      StatisticEntity(
          totalUsers: json["total_users"],
          totalStores: json["total_stores"],
          totalOrders: json["totalOrders"],
          totalProducts: json["totalProducts"],
          transactions: TransactionEntity.fromJson(json["transactions"]),
          topOrderedProducts: json["topOrderedProducts"] == null
              ? []
              : List<TopProductEntity>.from(json["topOrderedProducts"]!
                  .map((x) => TopProductEntity.fromJson(x))),
          revenue: json["revenue"] == null
              ? []
              : List<RevenueEntity>.from(
                  json["revenue"]!.map((x) => RevenueEntity.fromJson(x))),
          topAvgRatingProducts: json["topAvgRating"] == null
              ? []
              : List<TopProductEntity>.from(json["topOrderedProducts"]!
                  .map((x) => TopProductEntity.fromJson(x))));

  @override
  List<Object?> get props => [
        totalOrders,
        totalProducts,
        transactions,
        topOrderedProducts,
        revenue,
        totalStores,
        totalOrders,
        topAvgRatingProducts
      ];
}
