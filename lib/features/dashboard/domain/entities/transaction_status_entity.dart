import 'package:equatable/equatable.dart';

class TransactionStatusEntity extends Equatable {
  final String? status;
  final int? count;

  const TransactionStatusEntity({
    required this.status,
    required this.count,
  });

  TransactionStatusEntity copyWith({
    String? status,
    int? count,
  }) =>
      TransactionStatusEntity(
        status: status ?? this.status,
        count: count ?? this.count,
      );

  factory TransactionStatusEntity.fromJson(Map<String, dynamic> json) =>
      TransactionStatusEntity(
        status: json["status"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [status, count];
}
