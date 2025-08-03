class UserEntity {
  final String id;
  final String name;

  final String? phone;
  final String? email;
  final String? role;
  final DateTime? birth;
  final String? status;

  final String? image;

  UserEntity({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    required this.role,
    this.birth,
    this.status,
    this.image,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? role,
    DateTime? birth,
    String? gender,
    String? image,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      birth: birth ?? this.birth,
      status: gender ?? this.status,
      image: image ?? this.image,
    );
  }
}
