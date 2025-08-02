import 'package:thuongmaidientu/features/dashboard/data/models/transaction_status_model.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({required super.total, required super.statuses});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        total: json["total"].toInt(),
        statuses: json["statuses"] == null
            ? []
            : List<TransactionStatusModel>.from(json["statuses"]!
                .map((x) => TransactionStatusModel.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "total": total,
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [total, statuses];
}
