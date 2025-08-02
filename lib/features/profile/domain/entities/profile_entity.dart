class ProfileEntity {
  final String id;
  final String name;

  final String? phone;
  final String? email;
  final String? role;
  final DateTime? birth;
  final String? gender;

  final String? image;

  ProfileEntity({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    required this.role,
    this.birth,
    this.gender,
    this.image,
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? role,
    DateTime? birth,
    String? gender,
    String? image,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }
}
