class WardEntity {
  final String code;
  final String name;

  WardEntity({
    required this.code,
    required this.name,
  });

  factory WardEntity.fromJson(Map<String, dynamic> json) {
    return WardEntity(
      code: json['code'].toString(),
      name: json['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ward_code': code,
      'ward_name': name,
    };
  }
}
