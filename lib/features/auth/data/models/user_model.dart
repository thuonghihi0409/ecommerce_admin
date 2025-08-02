import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'] ?? '',
    );
  }
}
