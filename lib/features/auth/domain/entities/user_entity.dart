enum Role { customer, store, admin, guest }

class UserEntity {
  late String? id;
  late String? email;
  late bool? isVerify;
  UserEntity({this.id, this.email, this.isVerify});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'],
      email: json['email'] ?? '',
    );
  }
}
