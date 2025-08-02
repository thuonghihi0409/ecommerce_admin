import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_status_entity.dart';

class TransactionStatusModel extends TransactionStatusEntity {
  const TransactionStatusModel({required super.status, required super.count});

  @override
  TransactionStatusModel copyWith({
    String? status,
    int? count,
  }) =>
      TransactionStatusModel(
        status: status ?? this.status,
        count: count ?? this.count,
      );

  factory TransactionStatusModel.fromJson(Map<String, dynamic> json) =>
      TransactionStatusModel(
        status: json["status"],
        count: json["count"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [status, count];
}
