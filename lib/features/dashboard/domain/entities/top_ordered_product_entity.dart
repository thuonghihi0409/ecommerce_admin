import 'package:equatable/equatable.dart';

class TopProductEntity extends Equatable {
  final String? id;
  final int? totalOrdered;
  final String? name;
  final double? avgRating;

  const TopProductEntity({
    required this.id,
    required this.avgRating,
    required this.totalOrdered,
    required this.name,
  });

  TopProductEntity copyWith(
          {String? id, int? totalOdered, String? name, double? avgRating}) =>
      TopProductEntity(
          id: id ?? this.id,
          totalOrdered: totalOdered ?? totalOrdered,
          name: name ?? this.name,
          avgRating: avgRating ?? this.avgRating);

  factory TopProductEntity.fromJson(Map<String, dynamic> json) =>
      TopProductEntity(
          id: json["id"],
          totalOrdered: json["totalOrdered"],
          name: json["name"],
          avgRating: json["avg_rating"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalOrdered": totalOrdered,
        "name": name,
      };

  @override
  List<Object?> get props => [id, totalOrdered, name];
}
