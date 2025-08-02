class ProvinceEntity {
  final String code;
  final String name;

  ProvinceEntity({
    required this.code,
    required this.name,
  });

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) {
    return ProvinceEntity(
      code: json['code'].toString(),
      name: json['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}
