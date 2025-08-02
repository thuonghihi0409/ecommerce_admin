import 'package:thuongmaidientu/features/dashboard/domain/entities/revenue_entity.dart';

class RevenueModel extends RevenueEntity {
  const RevenueModel({required super.key, required super.value});

  @override
  RevenueModel copyWith({
    String? key,
    double? value,
  }) =>
      RevenueModel(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory RevenueModel.fromJson(Map<String, dynamic> json) => RevenueModel(
        key: json["key"],
        value: json["value"]?.toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };

  @override
  List<Object?> get props => [key, value];
}
