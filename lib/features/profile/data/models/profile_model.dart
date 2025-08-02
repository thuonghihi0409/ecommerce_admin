import '../../domain/entities/profile_entity.dart';

class ProfileEntityModel extends ProfileEntity {
  ProfileEntityModel({
    required super.id,
    required super.name,
    super.phone,
    super.email,
    super.role,
    super.birth,
    super.gender,
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
      'gender': gender,
    };
  }

  static ProfileEntityModel fromJson(Map<String, dynamic> json) {
    return ProfileEntityModel(
      id: json['id'],
      name: json['name']?.toString() ?? "",
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      birth: (json['birth'] != null && json['birth'] != '')
          ? DateTime.tryParse(json['birth'].toString())
          : null,
      role: json['role']?.toString(),
      gender: json['gender']?.toString(),
      image: json['image']?.toString(),
    );
  }
}
