import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_status_entity.dart';

class TransactionEntity extends Equatable {
  final int? total;
  final List<TransactionStatusEntity>? statuses;

  const TransactionEntity({
    required this.total,
    required this.statuses,
  });

  TransactionEntity copyWith({
    int? total,
    List<TransactionStatusEntity>? statuses,
  }) =>
      TransactionEntity(
        total: total ?? this.total,
        statuses: statuses ?? this.statuses,
      );

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      TransactionEntity(
        total: json["total"].toInt(),
        statuses: json["statuses"] == null
            ? []
            : List<TransactionStatusEntity>.from(json["statuses"]!
                .map((x) => TransactionStatusEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [total, statuses];
}
