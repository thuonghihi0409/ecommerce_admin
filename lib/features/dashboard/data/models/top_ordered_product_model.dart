import 'package:thuongmaidientu/features/dashboard/domain/entities/top_ordered_product_entity.dart';

class TopProductModel extends TopProductEntity {
  const TopProductModel(
      {required super.id,
      required super.totalOrdered,
      required super.name,
      required super.avgRating});

  @override
  TopProductModel copyWith(
          {String? id, int? totalOdered, String? name, double? avgRating}) =>
      TopProductModel(
          id: id ?? this.id,
          totalOrdered: totalOdered ?? totalOrdered,
          name: name ?? this.name,
          avgRating: avgRating ?? this.avgRating);

  factory TopProductModel.fromJson(Map<String, dynamic> json) =>
      TopProductModel(
          id: json["id"],
          totalOrdered: json["totalOrdered"],
          name: json["name"],
          avgRating: json["avg_rating"]);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "totalOrdered": totalOrdered,
        "name": name,
      };

  @override
  List<Object?> get props => [id, totalOrdered, name];
}
