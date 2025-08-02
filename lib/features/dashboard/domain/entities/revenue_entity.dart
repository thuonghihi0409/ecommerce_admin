import 'package:equatable/equatable.dart';

class RevenueEntity extends Equatable {
  final String? key;
  final double? value;

  const RevenueEntity({
    required this.key,
    required this.value,
  });

  RevenueEntity copyWith({
    String? key,
    double? value,
  }) =>
      RevenueEntity(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory RevenueEntity.fromJson(Map<String, dynamic> json) => RevenueEntity(
        key: json["key"],
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };

  @override
  List<Object?> get props => [key, value];
}
