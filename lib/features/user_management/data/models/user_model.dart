import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';

class UserEntityModel extends UserEntity {
  UserEntityModel({
    required super.id,
    required super.name,
    super.phone,
    super.email,
    super.role,
    super.birth,
    super.status,
    super.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'birth': birth,
      'gender': status,
    };
  }

  static UserEntityModel fromJson(Map<String, dynamic> json) {
    return UserEntityModel(
      id: json['id'],
      name: json['name']?.toString() ?? "",
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      birth: (json['birth'] != null && json['birth'] != '')
          ? DateTime.tryParse(json['birth'].toString())
          : null,
      role: json['role']?.toString(),
      status: json['status']?.toString(),
      image: json['image']?.toString(),
    );
  }
}
